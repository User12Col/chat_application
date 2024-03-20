import 'package:chat_app/models/message_data.dart';
import 'package:chat_app/theme.dart';
import 'package:chat_app/widgets/avatar.dart';
import 'package:chat_app/widgets/glowing_action_button.dart';
import 'package:chat_app/widgets/icon_button.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  final MessageData messageData;
  const ChatScreen({Key? key, required this.messageData}) : super(key: key);

  static Route route(MessageData data) =>
      MaterialPageRoute(builder: (context) => ChatScreen(messageData: data));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        centerTitle: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingWidth: 54,
        leading: Align(
          alignment: Alignment.centerRight,
          child: IconBackground(
            icon: Icons.arrow_back_ios_new,
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        title: _AppBarTitle(
          messageData: messageData,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Center(
              child: IconBorder(icon: Icons.video_camera_back, onTap: () {}),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Center(
              child: IconBorder(icon: Icons.call, onTap: () {}),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(child: _DemoMessageList()),
          _ActionBar(),
        ],
      ),
    );
  }
}

class _AppBarTitle extends StatelessWidget {
  final MessageData messageData;
  const _AppBarTitle({Key? key, required this.messageData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Avatar.small(url: messageData.profilePic),
        SizedBox(
          width: 16,
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                messageData.senderName,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 14),
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                'Online now',
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.green),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class _DemoMessageList extends StatelessWidget {
  const _DemoMessageList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ListView(
        children: [
          _DateLable(lable: 'Yesterday'),
          _MessageTile(
            message: 'Hi',
            messageDate: '11:01 PM',
          ),
          _MessageOwnTile(
            message: 'Hello',
            messageDate: '11:01 PM',
          ),
        ],
      ),
    );
  }
}

class _DateLable extends StatelessWidget {
  final String lable;
  const _DateLable({Key? key, required this.lable}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 32),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
            child: Text(
              lable,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: AppColors.textFaded,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _MessageTile extends StatelessWidget {
  final String message;
  final String messageDate;

  static const _borderRadius = 26.0;

  const _MessageTile(
      {Key? key, required this.message, required this.messageDate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(_borderRadius),
                  topRight: Radius.circular(_borderRadius),
                  bottomRight: Radius.circular(_borderRadius),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 20),
                child: Text(message),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Text(
                messageDate,
                style: TextStyle(
                  color: AppColors.textFaded,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _MessageOwnTile extends StatelessWidget {
  final String message;
  final String messageDate;

  static const _borderRadius = 26.0;

  const _MessageOwnTile(
      {Key? key, required this.message, required this.messageDate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Align(
        alignment: Alignment.centerRight,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColors.secondary,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(_borderRadius),
                  topRight: Radius.circular(_borderRadius),
                  bottomRight: Radius.circular(_borderRadius),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 20),
                child: Text(message),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Text(
                messageDate,
                style: TextStyle(
                  color: AppColors.textFaded,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _ActionBar extends StatelessWidget {
  const _ActionBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      top: false,
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
                border: Border(
                    right: BorderSide(
              width: 2,
              color: Theme.of(context).dividerColor,
            ))),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Icon(Icons.camera_alt),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: TextField(
                style: TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  hintText: 'Type something',
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 12,
              right: 24.0,
            ),
            child: GlowingActionButton(
                color: AppColors.accent, icon: Icons.send, onPressed: () {}),
          ),
        ],
      ),
    );
  }
}
