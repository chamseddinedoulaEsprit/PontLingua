class ConversationModel {
  final String id;
  final List<String> participantIds;
  final String? lastMessageText;
  final DateTime? lastMessageTime;
  final DateTime createdAt;
  final DateTime updatedAt;

  ConversationModel({
    required this.id,
    required this.participantIds,
    this.lastMessageText,
    this.lastMessageTime,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'participantIds': participantIds,
    'lastMessageText': lastMessageText,
    'lastMessageTime': lastMessageTime?.toIso8601String(),
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
  };

  factory ConversationModel.fromJson(Map<String, dynamic> json) => ConversationModel(
    id: json['id'] as String,
    participantIds: List<String>.from(json['participantIds'] as List),
    lastMessageText: json['lastMessageText'] as String?,
    lastMessageTime: json['lastMessageTime'] != null
        ? DateTime.parse(json['lastMessageTime'] as String)
        : null,
    createdAt: DateTime.parse(json['createdAt'] as String),
    updatedAt: DateTime.parse(json['updatedAt'] as String),
  );

  ConversationModel copyWith({
    String? id,
    List<String>? participantIds,
    String? lastMessageText,
    DateTime? lastMessageTime,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => ConversationModel(
    id: id ?? this.id,
    participantIds: participantIds ?? this.participantIds,
    lastMessageText: lastMessageText ?? this.lastMessageText,
    lastMessageTime: lastMessageTime ?? this.lastMessageTime,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
}
