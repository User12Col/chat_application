import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  final double radius;
  final String url;
  const Avatar({Key? key, required this.radius, required this.url})
      : super(key: key);

  const Avatar.small({Key? key, required this.url})
      : radius = 16,
        super(key: key);
  const Avatar.medium({Key? key, required this.url})
      : radius = 22,
        super(key: key);
  const Avatar.large({Key? key, required this.url})
      : radius = 44,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundImage: CachedNetworkImageProvider(url),
      backgroundColor: Theme.of(context).cardColor,
    );
  }
}
