import 'package:pontlingua/models/conversation_model.dart';
import 'package:pontlingua/services/storage_service.dart';

class ConversationService {
  static List<ConversationModel> _conversations = [];

  static Future<void> initialize() async {
    final data = await StorageService.getConversations();
    if (data.isEmpty) {
      await _loadSampleData();
    } else {
      _conversations = data.map((json) => ConversationModel.fromJson(json)).toList();
    }
  }

  static Future<void> _loadSampleData() async {
    final now = DateTime.now();
    _conversations = [
      ConversationModel(
        id: 'conv1',
        participantIds: ['user1', 'user2'],
        lastMessageText: 'Hola',
        lastMessageTime: now.subtract(const Duration(minutes: 5)),
        createdAt: now.subtract(const Duration(days: 2)),
        updatedAt: now.subtract(const Duration(minutes: 5)),
      ),
      ConversationModel(
        id: 'conv2',
        participantIds: ['user1', 'user3'],
        lastMessageText: 'Hallo',
        lastMessageTime: now.subtract(const Duration(hours: 1)),
        createdAt: now.subtract(const Duration(days: 5)),
        updatedAt: now.subtract(const Duration(hours: 1)),
      ),
      ConversationModel(
        id: 'conv3',
        participantIds: ['user1', 'user4'],
        lastMessageText: 'مرحبا',
        lastMessageTime: now.subtract(const Duration(hours: 3)),
        createdAt: now.subtract(const Duration(days: 1)),
        updatedAt: now.subtract(const Duration(hours: 3)),
      ),
      ConversationModel(
        id: 'conv4',
        participantIds: ['user1', 'user5'],
        lastMessageText: '你好',
        lastMessageTime: now.subtract(const Duration(days: 1)),
        createdAt: now.subtract(const Duration(days: 7)),
        updatedAt: now.subtract(const Duration(days: 1)),
      ),
    ];
    await _save();
  }

  static Future<void> _save() async {
    await StorageService.saveConversations(_conversations.map((c) => c.toJson()).toList());
  }

  static List<ConversationModel> getAllConversations() {
    _conversations.sort((a, b) {
      if (a.lastMessageTime == null) return 1;
      if (b.lastMessageTime == null) return -1;
      return b.lastMessageTime!.compareTo(a.lastMessageTime!);
    });
    return _conversations;
  }

  static ConversationModel? getConversationById(String id) {
    try {
      return _conversations.firstWhere((c) => c.id == id);
    } catch (e) {
      return null;
    }
  }

  static Future<void> updateConversation(ConversationModel conversation) async {
    final index = _conversations.indexWhere((c) => c.id == conversation.id);
    if (index != -1) {
      _conversations[index] = conversation;
      await _save();
    }
  }
}
