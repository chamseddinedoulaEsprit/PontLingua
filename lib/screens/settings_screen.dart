import 'package:flutter/material.dart';
import 'package:pontlingua/models/user_model.dart';
import 'package:pontlingua/services/user_service.dart';
import 'package:pontlingua/widgets/language_selector.dart';

class SettingsScreen extends StatefulWidget {
  final String currentUserId;

  const SettingsScreen({super.key, required this.currentUserId});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  UserModel? _currentUser;
  String _selectedLanguage = 'fr';

  @override
  void initState() {
    super.initState();
    _currentUser = UserService.getUserById(widget.currentUserId);
    _selectedLanguage = _currentUser?.preferredLanguage ?? 'fr';
  }

  Future<void> _updateLanguage(String language) async {
    await UserService.updateUserLanguage(widget.currentUserId, language);
    setState(() {
      _selectedLanguage = language;
      _currentUser = UserService.getUserById(widget.currentUserId);
    });
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Langue mise à jour avec succès'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paramètres'),
      ),
      body: ListView(
        children: [
          if (_currentUser != null) ...[
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(_currentUser!.avatar, style: const TextStyle(fontSize: 64)),
                  const SizedBox(height: 8),
                  Text(
                    _currentUser!.name,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ],
              ),
            ),
            const Divider(),
          ],
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Langue préférée',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              'Les messages reçus seront automatiquement traduits dans votre langue',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
          ),
          const SizedBox(height: 16),
          LanguageSelector(
            selectedLanguage: _selectedLanguage,
            onLanguageChanged: _updateLanguage,
          ),
          const Divider(height: 32),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('À propos'),
            subtitle: const Text('PontLingua v1.0.0'),
          ),
          ListTile(
            leading: const Icon(Icons.translate),
            title: const Text('Traduction instantanée'),
            subtitle: const Text('Briser les barrières linguistiques'),
          ),
        ],
      ),
    );
  }
}
