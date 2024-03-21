import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  final double radius;
  final String? url;
  final VoidCallback? onTap;
  const Avatar({Key? key, required this.radius, this.url, this.onTap})
      : super(key: key);

  const Avatar.small({Key? key, this.url, this.onTap})
      : radius = 16,
        super(key: key);
  const Avatar.medium({Key? key, this.url, this.onTap})
      : radius = 22,
        super(key: key);
  const Avatar.large({Key? key, this.url, this.onTap})
      : radius = 44,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: _avatar(context),
    );
  }

  Widget _avatar(BuildContext context){
    if(url!=null){
      return CircleAvatar(
        radius: radius,
        backgroundImage: CachedNetworkImageProvider(url!),
        backgroundColor: Theme.of(context).cardColor,
      );
    } else{
      return CircleAvatar(
        radius: radius,
        backgroundColor: Theme.of(context).cardColor,
        child: Center(
          child: Text(
            '?',
            style: TextStyle(fontSize: radius),
          ),
        ),
      );
    }
  }
}
