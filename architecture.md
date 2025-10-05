# Architecture - PontLingua

## Vue d'ensemble
Application de chat avec traduction en temps réel permettant à des utilisateurs parlant différentes langues de communiquer facilement.

## Fonctionnalités principales
- ✅ Messagerie instantanée en temps réel
- ✅ Traduction automatique des messages reçus
- ✅ Choix de langue préférée par utilisateur
- ✅ Indicateur de langue (affiche langue d'origine + traduction)
- ✅ Interface intuitive avec liste de conversations
- ✅ Messages affichés dans la langue préférée de l'utilisateur

## Structure du projet

### Modèles (`lib/models/`)
- `user_model.dart` - Modèle utilisateur (id, nom, langue préférée, avatar)
- `conversation_model.dart` - Modèle de conversation entre utilisateurs
- `message_model.dart` - Modèle de message avec texte original et traductions

### Services (`lib/services/`)
- `storage_service.dart` - Gestion du stockage local (shared_preferences)
- `user_service.dart` - Gestion des utilisateurs et données d'exemple
- `conversation_service.dart` - Gestion des conversations
- `message_service.dart` - Gestion des messages et envoi
- `translation_service.dart` - Service de traduction (simulation locale)

### Écrans (`lib/screens/`)
- `home_screen.dart` - Liste des conversations
- `chat_screen.dart` - Interface de chat avec traduction en temps réel
- `settings_screen.dart` - Paramètres et sélection de langue

### Widgets (`lib/widgets/`)
- `conversation_tile.dart` - Élément de liste de conversation
- `message_bubble.dart` - Bulle de message avec indicateur de traduction
- `language_selector.dart` - Sélecteur de langue

## Langues supportées
- 🇬🇧 Anglais (en)
- 🇫🇷 Français (fr)
- 🇪🇸 Espagnol (es)
- 🇩🇪 Allemand (de)
- 🇸🇦 Arabe (ar)
- 🇨🇳 Chinois (zh)

## Données d'exemple
L'application est pré-chargée avec 5 utilisateurs parlant différentes langues et 4 conversations avec messages d'exemple.

## Fonctionnement de la traduction
- Chaque message stocke le texte original + langue d'origine
- Les traductions sont générées pour toutes les langues supportées
- L'utilisateur voit automatiquement les messages dans sa langue préférée
- Possibilité d'appuyer sur un message traduit pour voir l'original

## Technologies
- Flutter & Dart
- shared_preferences (stockage local)
- intl (formatage dates/heures)
- uuid (génération d'IDs uniques)
- google_fonts (typographie)
