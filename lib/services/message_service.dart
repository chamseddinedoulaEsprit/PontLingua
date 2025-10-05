import 'package:pontlingua/models/message_model.dart';
import 'package:pontlingua/services/storage_service.dart';
import 'package:pontlingua/services/translation_service.dart';
import 'package:pontlingua/services/conversation_service.dart';
import 'package:uuid/uuid.dart';

class MessageService {
  static List<MessageModel> _messages = [];
  static const _uuid = Uuid();

  static Future<void> initialize() async {
    final data = await StorageService.getMessages();
    if (data.isEmpty) {
      await _loadSampleData();
    } else {
      _messages = data.map((json) => MessageModel.fromJson(json)).toList();
    }
  }

  static Future<void> _loadSampleData() async {
    final now = DateTime.now();
    _messages = [
      MessageModel(
        id: 'msg1',
        conversationId: 'conv1',
        senderId: 'user2',
        originalText: 'Hola',
        originalLanguage: 'es',
        translations: TranslationService.translateToAll('Hola', 'es'),
        createdAt: now.subtract(const Duration(minutes: 10)),
        updatedAt: now.subtract(const Duration(minutes: 10)),
      ),
      MessageModel(
        id: 'msg2',
        conversationId: 'conv1',
        senderId: 'user1',
        originalText: 'Bonjour',
        originalLanguage: 'fr',
        translations: TranslationService.translateToAll('Bonjour', 'fr'),
        createdAt: now.subtract(const Duration(minutes: 5)),
        updatedAt: now.subtract(const Duration(minutes: 5)),
      ),
      MessageModel(
        id: 'msg3',
        conversationId: 'conv2',
        senderId: 'user3',
        originalText: 'Hallo',
        originalLanguage: 'de',
        translations: TranslationService.translateToAll('Hallo', 'de'),
        createdAt: now.subtract(const Duration(hours: 1)),
        updatedAt: now.subtract(const Duration(hours: 1)),
      ),
      MessageModel(
        id: 'msg4',
        conversationId: 'conv3',
        senderId: 'user4',
        originalText: 'مرحبا',
        originalLanguage: 'ar',
        translations: TranslationService.translateToAll('مرحبا', 'ar'),
        createdAt: now.subtract(const Duration(hours: 3)),
        updatedAt: now.subtract(const Duration(hours: 3)),
      ),
      MessageModel(
        id: 'msg5',
        conversationId: 'conv4',
        senderId: 'user5',
        originalText: '你好',
        originalLanguage: 'zh',
        translations: TranslationService.translateToAll('你好', 'zh'),
        createdAt: now.subtract(const Duration(days: 1)),
        updatedAt: now.subtract(const Duration(days: 1)),
      ),
    ];
    await _save();
  }

  static Future<void> _save() async {
    await StorageService.saveMessages(_messages.map((m) => m.toJson()).toList());
  }

  static List<MessageModel> getMessagesByConversationId(String conversationId) {
    final msgs = _messages.where((m) => m.conversationId == conversationId).toList();
    msgs.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    return msgs;
  }

  static Future<void> sendMessage({
    required String conversationId,
    required String senderId,
    required String text,
    required String language,
  }) async {
    final now = DateTime.now();
    final message = MessageModel(
      id: _uuid.v4(),
      conversationId: conversationId,
      senderId: senderId,
      originalText: text,
      originalLanguage: language,
      translations: TranslationService.translateToAll(text, language),
      createdAt: now,
      updatedAt: now,
    );
    
    _messages.add(message);
    await _save();

    final conversation = ConversationService.getConversationById(conversationId);
    if (conversation != null) {
      await ConversationService.updateConversation(
        conversation.copyWith(
          lastMessageText: text,
          lastMessageTime: now,
          updatedAt: now,
        ),
      );
    }
  }
}
