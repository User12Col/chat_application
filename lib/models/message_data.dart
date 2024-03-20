
import 'package:flutter/material.dart';

@immutable
class MessageData{
  final String senderName;
  final String message;
  final DateTime dateTime;
  final String dateMessage;
  final String profilePic;

  MessageData({required this.senderName, required this.message, required this.dateTime, required this.profilePic, required this.dateMessage});
}