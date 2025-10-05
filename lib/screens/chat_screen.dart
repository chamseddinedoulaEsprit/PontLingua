import 'package:flutter/material.dart';
import 'package:pontlingua/models/conversation_model.dart';
import 'package:pontlingua/models/message_model.dart';
import 'package:pontlingua/models/user_model.dart';
import 'package:pontlingua/services/message_service.dart';
import 'package:pontlingua/services/user_service.dart';
import 'package:pontlingua/widgets/message_bubble.dart';

class ChatScreen extends StatefulWidget {
  final ConversationModel conversation;
  final String currentUserId;

  const ChatScreen({
    super.key,
    required this.conversation,
    required this.currentUserId,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  List<MessageModel> _messages = [];
  UserModel? _currentUser;
  UserModel? _otherUser;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    _currentUser = UserService.getUserById(widget.currentUserId);
    final otherUserId = widget.conversation.participantIds
        .firstWhere((id) => id != widget.currentUserId, orElse: () => '');
    _otherUser = UserService.getUserById(otherUserId);
    
    setState(() {
      _messages = MessageService.getMessagesByConversationId(widget.conversation.id);
    });
    
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  Future<void> _sendMessage() async {
    if (_messageController.text.trim().isEmpty || _currentUser == null) return;

    await MessageService.sendMessage(
      conversationId: widget.conversation.id,
      senderId: widget.currentUserId,
      text: _messageController.text.trim(),
      language: _currentUser!.preferredLanguage,
    );

    _messageController.clear();
    _loadData();
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _otherUser != null
            ? Row(
                children: [
                  Text(_otherUser!.avatar, style: const TextStyle(fontSize: 20)),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(_otherUser!.name, style: const TextStyle(fontSize: 16)),
                      Text(
                        'Langue: ${_otherUser!.preferredLanguage.toUpperCase()}',
                        style: const TextStyle(fontSize: 11, fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ],
              )
            : const Text('Chat'),
      ),
      body: Column(
        children: [
          Expanded(
            child: _messages.isEmpty
                ? Center(
                    child: Text(
                      'Commencez la conversation',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(8),
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      final message = _messages[index];
                      return MessageBubble(
                        message: message,
                        isMe: message.senderId == widget.currentUserId,
                        displayLanguage: _currentUser?.preferredLanguage ?? 'en',
                      );
                    },
                  ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 4,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: SafeArea(
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        hintText: 'Votre message...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      ),
                      maxLines: null,
                      textInputAction: TextInputAction.send,
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  CircleAvatar(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    child: IconButton(
                      icon: Icon(Icons.send, color: Theme.of(context).colorScheme.onPrimary),
                      onPressed: _sendMessage,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
