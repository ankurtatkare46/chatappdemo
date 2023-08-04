import 'package:flutter/material.dart';
class ChatBubble extends StatelessWidget {
  final String message;
  final bool sender;
  const ChatBubble({Key? key, required this.message, required this.sender}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius : BorderRadius.circular(8),
      color: sender?Colors.green:Colors.grey,
    ),
    child: Text(
      message,
      style: TextStyle(
        fontSize: 16,
        color: Colors.white
      ),
    ),);
  }
}
