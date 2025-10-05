import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const String _currentUserKey = 'current_user_id';
  static const String _usersKey = 'users';
  static const String _conversationsKey = 'conversations';
  static const String _messagesKey = 'messages';

  static Future<SharedPreferences> get _prefs async => await SharedPreferences.getInstance();

  static Future<void> setCurrentUserId(String userId) async {
    final prefs = await _prefs;
    await prefs.setString(_currentUserKey, userId);
  }

  static Future<String?> getCurrentUserId() async {
    final prefs = await _prefs;
    return prefs.getString(_currentUserKey);
  }

  static Future<void> saveUsers(List<Map<String, dynamic>> users) async {
    final prefs = await _prefs;
    await prefs.setString(_usersKey, jsonEncode(users));
  }

  static Future<List<Map<String, dynamic>>> getUsers() async {
    final prefs = await _prefs;
    final data = prefs.getString(_usersKey);
    if (data == null) return [];
    return List<Map<String, dynamic>>.from(jsonDecode(data));
  }

  static Future<void> saveConversations(List<Map<String, dynamic>> conversations) async {
    final prefs = await _prefs;
    await prefs.setString(_conversationsKey, jsonEncode(conversations));
  }

  static Future<List<Map<String, dynamic>>> getConversations() async {
    final prefs = await _prefs;
    final data = prefs.getString(_conversationsKey);
    if (data == null) return [];
    return List<Map<String, dynamic>>.from(jsonDecode(data));
  }

  static Future<void> saveMessages(List<Map<String, dynamic>> messages) async {
    final prefs = await _prefs;
    await prefs.setString(_messagesKey, jsonEncode(messages));
  }

  static Future<List<Map<String, dynamic>>> getMessages() async {
    final prefs = await _prefs;
    final data = prefs.getString(_messagesKey);
    if (data == null) return [];
    return List<Map<String, dynamic>>.from(jsonDecode(data));
  }

  static Future<void> clearAll() async {
    final prefs = await _prefs;
    await prefs.clear();
  }
}
