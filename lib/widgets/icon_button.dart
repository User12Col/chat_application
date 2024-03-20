import 'package:chat_app/theme.dart';
import 'package:flutter/material.dart';
class IconBackground extends StatelessWidget {
  final VoidCallback onTap;
  final IconData icon;
  const IconBackground({Key? key, required this.icon, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).cardColor,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        splashColor: AppColors.secondary,
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Icon(icon,),
        ),
      ),
    );
  }
}

class IconBorder extends StatelessWidget {
  final VoidCallback onTap;
  final IconData icon;
  const IconBorder({Key? key, required this.icon, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      splashColor: AppColors.secondary,
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            width: 2,
            color: Theme.of(context).cardColor,
          )
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Icon(icon, size: 16,),
        ),
      ),
    );
  }
}


