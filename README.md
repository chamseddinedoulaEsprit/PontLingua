# PontLingua 🌍💬

Une application de messagerie instantanée avec traduction en temps réel permettant à des personnes parlant différentes langues de communiquer facilement.

## 📋 Fonctionnalités

### Communication Multilingue
- **Traduction automatique** : Les messages sont traduits instantanément dans la langue préférée de l'utilisateur
- **Support de 6 langues** : Français, Anglais, Espagnol, Allemand, Arabe, Chinois
- **Indicateur de langue** : Affiche la langue originale du message et sa traduction

### Messagerie Instantanée
- **Chat en temps réel** : Envoi et réception instantanés de messages
- **Emojis** : Support complet des emojis
- **Partage de fichiers** : Possibilité d'envoyer des images et documents
- **Interface intuitive** : Design moderne et ergonomique

### Personnalisation
- **Choix de langue** : Chaque utilisateur sélectionne sa langue préférée
- **Profils utilisateurs** : Gestion des profils avec avatar et informations
- **Thème personnalisé** : Interface élégante avec palette de couleurs harmonieuse

## 🏗️ Architecture

### Structure du Projet

```
lib/
├── models/              # Modèles de données
│   ├── user_model.dart
│   ├── conversation_model.dart
│   └── message_model.dart
├── services/            # Logique métier
│   ├── user_service.dart
│   ├── conversation_service.dart
│   ├── message_service.dart
│   ├── translation_service.dart
│   └── storage_service.dart
├── screens/             # Écrans de l'application
│   ├── home_screen.dart
│   ├── chat_screen.dart
│   └── settings_screen.dart
├── widgets/             # Composants réutilisables
│   ├── conversation_tile.dart
│   ├── message_bubble.dart
│   └── language_selector.dart
├── theme.dart           # Configuration du thème
└── main.dart            # Point d'entrée
```

### Modèles de Données

#### User (Utilisateur)
- ID unique
- Nom, email, avatar
- Langue préférée
- Statut en ligne
- Dates de création/modification

#### Conversation
- ID unique
- Liste des participants
- Dernier message
- Compteur de messages non lus
- Dates de création/modification

#### Message
- ID unique
- Contenu du message
- Langue originale
- Traductions multiples
- Type (texte/fichier)
- Expéditeur et conversation
- Statut de lecture
- Horodatage

### Services

#### UserService
Gestion des utilisateurs (CRUD, statut en ligne, profils)

#### ConversationService
Gestion des conversations (création, récupération, mise à jour)

#### MessageService
Gestion des messages (envoi, réception, marquage comme lu)

#### TranslationService
Service de traduction simulé supportant 6 langues

#### StorageService
Persistance locale avec SharedPreferences

## 🚀 Installation

### Prérequis
- Flutter SDK (version 3.0 ou supérieure)
- Dart SDK
- Un IDE (VS Code, Android Studio, etc.)

### Étapes d'installation

1. **Cloner le projet**
```bash
git clone <https://github.com/chamseddinedoulaEsprit/PontLingua.git>
cd pontlingua
```

2. **Installer les dépendances**
```bash
flutter pub get
```

3. **Lancer l'application**
```bash
flutter run
```

## 📱 Utilisation

### Premier lancement
1. L'application charge avec des données de démonstration
2. Trois utilisateurs sont pré-configurés avec différentes langues
3. Des conversations d'exemple sont disponibles

### Changer de langue
1. Accéder aux paramètres (icône en haut à droite)
2. Sélectionner votre langue préférée
3. Les messages seront automatiquement traduits

### Envoyer un message
1. Sélectionner une conversation
2. Taper votre message
3. Cliquer sur envoyer
4. Le message sera traduit pour les autres participants

### Créer une conversation
1. Depuis l'écran d'accueil
2. Sélectionner un contact
3. Commencer à discuter

## 🎨 Personnalisation

### Thème
Le thème est défini dans `lib/theme.dart`. Vous pouvez personnaliser :
- Couleurs primaires et secondaires
- Typographie
- Styles des composants

### Langues supportées
Pour ajouter une langue, modifier `lib/services/translation_service.dart` :
```dart
static const Map<String, String> supportedLanguages = {
  'nouvelle_langue': 'Nom de la langue',
  // ...
};
```

## 🔧 Technologies Utilisées

- **Flutter** : Framework de développement
- **Dart** : Langage de programmation
- **SharedPreferences** : Stockage local
- **Material Design** : Design system

## 📝 Données de Démonstration

L'application inclut :
- 3 utilisateurs avec des langues différentes
- 2 conversations pré-configurées
- Messages d'exemple traduits

## 🌐 Support Multiplateforme

L'application fonctionne sur :
- Android
- iOS
- Web

## 🔮 Évolutions Futures

- [ ] Intégration d'une API de traduction réelle (Google Translate, DeepL)
- [ ] Backend avec Firebase/Supabase pour synchronisation en temps réel
- [ ] Appels audio/vidéo avec traduction vocale
- [ ] Détection automatique de la langue
- [ ] Historique de traduction
- [ ] Mode hors ligne amélioré
- [ ] Notifications push

## 📄 Licence

Ce projet est sous licence MIT.

## 👥 Contribution

Les contributions sont les bienvenues ! N'hésitez pas à :
1. Forker le projet
2. Créer une branche (`git checkout -b feature/amelioration`)
3. Commiter vos changements (`git commit -m 'Ajout de fonctionnalité'`)
4. Pusher vers la branche (`git push origin feature/amelioration`)
5. Ouvrir une Pull Request

## 📧 Contact

Pour toute question ou suggestion, n'hésitez pas à ouvrir une issue.

---

**PontLingua** - Connecter le monde, une traduction à la fois 🌍💬
