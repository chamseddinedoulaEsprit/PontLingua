import 'package:flutter/material.dart';
import 'package:pontlingua/theme.dart';
import 'package:pontlingua/services/user_service.dart';
import 'package:pontlingua/services/conversation_service.dart';
import 'package:pontlingua/services/message_service.dart';
import 'package:pontlingua/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserService.initialize();
  await ConversationService.initialize();
  await MessageService.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PontLingua',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      home: const HomeScreen(),
    );
  }
}
