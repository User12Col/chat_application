import 'package:chat_app/app.dart';
import 'package:chat_app/helpers.dart';
import 'package:chat_app/pages/call_page.dart';
import 'package:chat_app/pages/contact_page.dart';
import 'package:chat_app/pages/message_page.dart';
import 'package:chat_app/pages/notification_page.dart';
import 'package:chat_app/screens/profile_screen.dart';
import 'package:chat_app/theme.dart';
import 'package:chat_app/widgets/avatar.dart';
import 'package:chat_app/widgets/glowing_action_button.dart';
import 'package:chat_app/widgets/icon_button.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final ValueNotifier<int> pageIndex = ValueNotifier(0);
  final ValueNotifier<String> title = ValueNotifier('Messages');
  final pages = [MessagePage(), NotificationPage(), CallPage(), ContactPage()];
  final pageTitles = ['Messages', 'Notification', 'Call', 'Contact'];

  void _onNavigationItemSelected(index) {
    title.value = pageTitles[index];
    pageIndex.value = index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: Colors.transparent,
        title: ValueListenableBuilder(
          valueListenable: title,
          builder: (context, value, _) {
            return Text(
              value,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            );
          },
        ),
        leading: Center(
          child: IconBackground(
              icon: Icons.search,
              onTap: () {
                print('Loc');
              }),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Hero(
              tag: 'hero-profile-picture',
              child: Avatar.small(
                url: context.currentUserImage,
                onTap: () {
                  Navigator.of(context).push(ProfileScreen.route);
                },
              ),
            ),
          ),
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: pageIndex,
        builder: (context, value, _) {
          return pages[value];
        },
      ),
      bottomNavigationBar: _bottomNavigationBar(
        onItemSelected: _onNavigationItemSelected,
      ),
    );
  }
}

class _bottomNavigationBar extends StatefulWidget {
  ValueChanged<int> onItemSelected;
  _bottomNavigationBar({Key? key, required this.onItemSelected})
      : super(key: key);

  @override
  State<_bottomNavigationBar> createState() => _bottomNavigationBarState();
}

class _bottomNavigationBarState extends State<_bottomNavigationBar> {
  var selectedIndex = 0;
  void handleItemSelected(int index) {
    setState(() {
      selectedIndex = index;
    });
    widget.onItemSelected(index);
  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Card(
      color: (brightness == Brightness.light) ? Colors.transparent : null,
      elevation: 0,
      margin: const EdgeInsets.all(0),
      child: SafeArea(
        top: false,
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.only(top: 16, left: 8, right: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _navigationBarItem(
                label: 'Message',
                icon: Icons.message,
                index: 0,
                onTap: handleItemSelected,
                isSelected: (selectedIndex == 0),
              ),
              _navigationBarItem(
                label: 'Notification',
                icon: Icons.notifications,
                index: 1,
                onTap: handleItemSelected,
                isSelected: (selectedIndex == 1),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: GlowingActionButton(
                  color: AppColors.secondary,
                  icon: Icons.add,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => Dialog(
                        child: AspectRatio(
                          aspectRatio: 8 / 7,
                          child: ContactPage(),
                        ),
                      ),
                    );
                  },
                ),
              ),
              _navigationBarItem(
                label: 'Call',
                icon: Icons.call,
                index: 2,
                onTap: handleItemSelected,
                isSelected: (selectedIndex == 2),
              ),
              _navigationBarItem(
                label: 'Contact',
                icon: Icons.contact_page,
                index: 3,
                onTap: handleItemSelected,
                isSelected: (selectedIndex == 3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _navigationBarItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final int index;
  final bool isSelected;
  ValueChanged<int> onTap;

  _navigationBarItem(
      {Key? key,
      required this.label,
      required this.icon,
      required this.index,
      required this.onTap,
      this.isSelected = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        onTap(index);
      },
      child: SizedBox(
        width: 52,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? AppColors.secondary : null,
            ),
            Text(
              label,
              overflow: TextOverflow.ellipsis,
              style: isSelected
                  ? TextStyle(
                      fontSize: 8,
                      fontWeight: FontWeight.bold,
                      color: AppColors.secondary,
                    )
                  : TextStyle(fontSize: 8),
            ),
          ],
        ),
      ),
    );
  }
}
