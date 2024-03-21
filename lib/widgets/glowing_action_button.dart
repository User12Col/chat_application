import 'package:flutter/material.dart';
class GlowingActionButton extends StatelessWidget {
  final Color color;
  final IconData icon;
  final double size;
  final VoidCallback onPressed;

  const GlowingActionButton({Key? key, required this.color, required this.icon, this.size = 54, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 24,
            offset: const Offset(-22,0),
          ),
          BoxShadow(
            color: color.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 24,
            offset: const Offset(22,0),
          ),
          BoxShadow(
            color: color.withOpacity(0.1),
            spreadRadius: 8,
            blurRadius: 42,
            offset: const Offset(-22,0),
          ),
          BoxShadow(
            color: color.withOpacity(0.1),
            spreadRadius: 8,
            blurRadius: 42,
            offset: const Offset(22,0),
          )
        ],
      ),
      child: ClipOval(
        child: Material(
          color: color,
          child: InkWell(
            onTap: onPressed,
            child: SizedBox(
              width: size,
              height: size,
              child: Icon(
                icon,
                size: 26,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
