import 'package:flutter/material.dart';
import 'package:pontlingua/models/conversation_model.dart';
import 'package:pontlingua/models/user_model.dart';
import 'package:intl/intl.dart';

class ConversationTile extends StatelessWidget {
  final ConversationModel conversation;
  final UserModel otherUser;
  final VoidCallback onTap;

  const ConversationTile({
    super.key,
    required this.conversation,
    required this.otherUser,
    required this.onTap,
  });

  String _formatTime(DateTime? time) {
    if (time == null) return '';
    final now = DateTime.now();
    final diff = now.difference(time);
    
    if (diff.inDays > 0) {
      return DateFormat('dd/MM').format(time);
    } else if (diff.inHours > 0) {
      return '${diff.inHours}h';
    } else if (diff.inMinutes > 0) {
      return '${diff.inMinutes}m';
    } else {
      return 'now';
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: CircleAvatar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        child: Text(otherUser.avatar, style: const TextStyle(fontSize: 24)),
      ),
      title: Text(otherUser.name, style: Theme.of(context).textTheme.titleMedium),
      subtitle: conversation.lastMessageText != null
          ? Text(
              conversation.lastMessageText!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyMedium,
            )
          : null,
      trailing: conversation.lastMessageTime != null
          ? Text(
              _formatTime(conversation.lastMessageTime),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            )
          : null,
    );
  }
}
