import 'package:pontlingua/models/user_model.dart';
import 'package:pontlingua/services/storage_service.dart';

class UserService {
  static List<UserModel> _users = [];

  static Future<void> initialize() async {
    final data = await StorageService.getUsers();
    if (data.isEmpty) {
      await _loadSampleData();
    } else {
      _users = data.map((json) => UserModel.fromJson(json)).toList();
    }
  }

  static Future<void> _loadSampleData() async {
    final now = DateTime.now();
    _users = [
      UserModel(
        id: 'user1',
        name: 'Marie Dubois',
        preferredLanguage: 'fr',
        avatar: '🇫🇷',
        createdAt: now,
        updatedAt: now,
      ),
      UserModel(
        id: 'user2',
        name: 'Carlos García',
        preferredLanguage: 'es',
        avatar: '🇪🇸',
        createdAt: now,
        updatedAt: now,
      ),
      UserModel(
        id: 'user3',
        name: 'Hans Mueller',
        preferredLanguage: 'de',
        avatar: '🇩🇪',
        createdAt: now,
        updatedAt: now,
      ),
      UserModel(
        id: 'user4',
        name: 'Ahmed Hassan',
        preferredLanguage: 'ar',
        avatar: '🇸🇦',
        createdAt: now,
        updatedAt: now,
      ),
      UserModel(
        id: 'user5',
        name: 'Li Wei',
        preferredLanguage: 'zh',
        avatar: '🇨🇳',
        createdAt: now,
        updatedAt: now,
      ),
    ];
    await _save();
  }

  static Future<void> _save() async {
    await StorageService.saveUsers(_users.map((u) => u.toJson()).toList());
  }

  static List<UserModel> getAllUsers() => _users;

  static UserModel? getUserById(String id) {
    try {
      return _users.firstWhere((u) => u.id == id);
    } catch (e) {
      return null;
    }
  }

  static Future<void> updateUser(UserModel user) async {
    final index = _users.indexWhere((u) => u.id == user.id);
    if (index != -1) {
      _users[index] = user;
      await _save();
    }
  }

  static Future<void> updateUserLanguage(String userId, String language) async {
    final user = getUserById(userId);
    if (user != null) {
      final updated = user.copyWith(
        preferredLanguage: language,
        updatedAt: DateTime.now(),
      );
      await updateUser(updated);
    }
  }
}
