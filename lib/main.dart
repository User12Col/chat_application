import 'package:chat_app/app.dart';
import 'package:chat_app/screens/home_screen.dart';
import 'package:chat_app/screens/select_user_screen.dart';
import 'package:chat_app/theme.dart';
import 'package:flutter/material.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

void main() async {
  final client = StreamChatClient(streamKey);
  runApp(MyApp(
    client: client,
  ));
}

class MyApp extends StatelessWidget {
  final StreamChatClient client;
  const MyApp({Key? key, required this.client}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.light,
      builder: (context, child) {
        return StreamChatCore(client: client, child: child!,);
      },
      home: SelectUserScreen(),
    );
  }
}
