import 'package:flutter/material.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

const streamKey = 'kgv94djqagbb';
extension StreamChatContext on BuildContext{
  String? get currentUserImage =>currentUser?.image;
  User? get currentUser =>StreamChatCore.of(this).currentUser;
}