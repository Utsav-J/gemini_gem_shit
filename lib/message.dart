import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Message extends StatelessWidget {
  final bool isUser;
  final String message;
  final String date;
  const Message({
    super.key,
    required this.isUser,
    required this.message,
    required this.date,
  });

  Map<String, dynamic> toJson() {
    return {
      'isUser': isUser,
      'message': message,
      'date': date,
    };
  }

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      isUser: json['isUser'],
      message: json['message'],
      date: json['date'],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.symmetric(vertical: 15).copyWith(
        left: isUser ? 100 : 10,
        right: isUser ? 10 : 100,
      ),
      decoration: BoxDecoration(
        color: isUser ? Colors.purple.shade400 : Colors.grey.withOpacity(0.5),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.r),
          topRight: Radius.circular(10.r),
          bottomLeft: isUser ? Radius.circular(10.r) : Radius.zero,
          bottomRight: isUser ? Radius.zero : Radius.circular(10.r),
        ),
      ),
      child: Text(message),
    );
  }
}
