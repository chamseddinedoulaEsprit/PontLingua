class MessageModel {
  final String id;
  final String conversationId;
  final String senderId;
  final String originalText;
  final String originalLanguage;
  final Map<String, String> translations;
  final DateTime createdAt;
  final DateTime updatedAt;

  MessageModel({
    required this.id,
    required this.conversationId,
    required this.senderId,
    required this.originalText,
    required this.originalLanguage,
    required this.translations,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'conversationId': conversationId,
    'senderId': senderId,
    'originalText': originalText,
    'originalLanguage': originalLanguage,
    'translations': translations,
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
  };

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
    id: json['id'] as String,
    conversationId: json['conversationId'] as String,
    senderId: json['senderId'] as String,
    originalText: json['originalText'] as String,
    originalLanguage: json['originalLanguage'] as String,
    translations: Map<String, String>.from(json['translations'] as Map),
    createdAt: DateTime.parse(json['createdAt'] as String),
    updatedAt: DateTime.parse(json['updatedAt'] as String),
  );

  MessageModel copyWith({
    String? id,
    String? conversationId,
    String? senderId,
    String? originalText,
    String? originalLanguage,
    Map<String, String>? translations,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => MessageModel(
    id: id ?? this.id,
    conversationId: conversationId ?? this.conversationId,
    senderId: senderId ?? this.senderId,
    originalText: originalText ?? this.originalText,
    originalLanguage: originalLanguage ?? this.originalLanguage,
    translations: translations ?? this.translations,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
}
