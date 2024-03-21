import 'package:chat_app/models/demo_user.dart';
import 'package:chat_app/screens/home_screen.dart';
import 'package:chat_app/widgets/avatar.dart';
import 'package:flutter/material.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

class SelectUserScreen extends StatefulWidget {
  static Route get route =>
      MaterialPageRoute(builder: (context) => const SelectUserScreen());
  const SelectUserScreen({Key? key}) : super(key: key);

  @override
  State<SelectUserScreen> createState() => _SelectUserScreenState();
}

class _SelectUserScreenState extends State<SelectUserScreen> {
  bool _loading = false;
  Future<void> onUserSelected(DemoUser user) async {
    setState(() {
      _loading = true;
    });
    try {
      final client = StreamChatCore.of(context).client;
      await client.connectUser(
          User(id: user.id, extraData: {
            'name': user.name,
            'image': user.image,
          },),
          client.devToken(user.id).rawValue);

      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomeScreen()));
    } catch (e) {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _loading
            ? const CircularProgressIndicator()
            : Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(32.0),
                      child: Text('Select a user'),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: users.length,
                        itemBuilder: (context, index) {
                          return SelectUserButton(
                            user: users[index],
                            onPressed: onUserSelected,
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}

class SelectUserButton extends StatelessWidget {
  final DemoUser user;
  final Function(DemoUser user) onPressed;
  const SelectUserButton(
      {Key? key, required this.user, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: InkWell(
        onTap: () => onPressed(user),
        child: Row(
          children: [
            Avatar.large(url: user.image),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                user.name,
                style: TextStyle(fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
