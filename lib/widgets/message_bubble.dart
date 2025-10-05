import 'package:flutter/material.dart';
import 'package:pontlingua/models/message_model.dart';
import 'package:intl/intl.dart';

class MessageBubble extends StatefulWidget {
  final MessageModel message;
  final bool isMe;
  final String displayLanguage;

  const MessageBubble({
    super.key,
    required this.message,
    required this.isMe,
    required this.displayLanguage,
  });

  @override
  State<MessageBubble> createState() => _MessageBubbleState();
}

class _MessageBubbleState extends State<MessageBubble> {
  bool _showOriginal = false;

  @override
  Widget build(BuildContext context) {
    final translatedText = widget.message.translations[widget.displayLanguage] ?? 
                          widget.message.originalText;
    final isTranslated = widget.message.originalLanguage != widget.displayLanguage;
    
    return Align(
      alignment: widget.isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
        child: Column(
          crossAxisAlignment: widget.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: isTranslated ? () => setState(() => _showOriginal = !_showOriginal) : null,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: widget.isMe
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _showOriginal ? widget.message.originalText : translatedText,
                      style: TextStyle(
                        color: widget.isMe
                            ? Theme.of(context).colorScheme.onPrimary
                            : Theme.of(context).colorScheme.onSurface,
                        fontSize: 15,
                      ),
                    ),
                    if (isTranslated) ...[
                      const SizedBox(height: 4),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.translate,
                            size: 12,
                            color: widget.isMe
                                ? Theme.of(context).colorScheme.onPrimary.withValues(alpha: 0.7)
                                : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            _showOriginal ? 'Original (${widget.message.originalLanguage.toUpperCase()})' 
                                         : 'Traduit • Appuyez pour voir l\'original',
                            style: TextStyle(
                              fontSize: 10,
                              color: widget.isMe
                                  ? Theme.of(context).colorScheme.onPrimary.withValues(alpha: 0.7)
                                  : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 2, left: 8, right: 8),
              child: Text(
                DateFormat('HH:mm').format(widget.message.createdAt),
                style: TextStyle(
                  fontSize: 11,
                  color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
