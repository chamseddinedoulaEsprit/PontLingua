import 'package:flutter/material.dart';
import 'package:pontlingua/models/conversation_model.dart';
import 'package:pontlingua/models/user_model.dart';
import 'package:pontlingua/services/conversation_service.dart';
import 'package:pontlingua/services/user_service.dart';
import 'package:pontlingua/services/storage_service.dart';
import 'package:pontlingua/widgets/conversation_tile.dart';
import 'package:pontlingua/screens/chat_screen.dart';
import 'package:pontlingua/screens/settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _currentUserId = 'user1';
  UserModel? _currentUser;
  List<ConversationModel> _conversations = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final userId = await StorageService.getCurrentUserId() ?? 'user1';
    await StorageService.setCurrentUserId(userId);
    
    setState(() {
      _currentUserId = userId;
      _currentUser = UserService.getUserById(_currentUserId);
      _conversations = ConversationService.getAllConversations();
    });
  }

  void _refreshConversations() {
    setState(() {
      _currentUser = UserService.getUserById(_currentUserId);
      _conversations = ConversationService.getAllConversations();
    });
  }

  UserModel? _getOtherUser(ConversationModel conversation) {
    final otherUserId = conversation.participantIds
        .firstWhere((id) => id != _currentUserId, orElse: () => '');
    return UserService.getUserById(otherUserId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PontLingua'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingsScreen(currentUserId: _currentUserId),
                ),
              );
              _refreshConversations();
            },
          ),
        ],
      ),
      body: _conversations.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.chat_bubble_outline, size: 64, color: Colors.grey),
                  const SizedBox(height: 16),
                  Text(
                    'Aucune conversation',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.grey),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: _conversations.length,
              itemBuilder: (context, index) {
                final conversation = _conversations[index];
                final otherUser = _getOtherUser(conversation);
                
                if (otherUser == null) return const SizedBox.shrink();
                
                return ConversationTile(
                  conversation: conversation,
                  otherUser: otherUser,
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatScreen(
                          conversation: conversation,
                          currentUserId: _currentUserId,
                        ),
                      ),
                    );
                    _refreshConversations();
                  },
                );
              },
            ),
    );
  }
}
