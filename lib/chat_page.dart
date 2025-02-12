import 'package:chat_app/core/theme.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage('https://gratisography.com/wp-content/uploads/2024/11/gratisography-augmented-reality-800x525.jpg'),
            ),
            SizedBox(width: 10),
            Text('Umit Celik', style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search, color: Colors.white),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(20),
              children: [
                _buildReceivedMessage(context, "Hello, how are you?"),
                _buildSentMessage(context, "Fine, thank you!"),
                _buildReceivedMessage(context, "Hello, how are you?"),
                _buildSentMessage(context, "Fine, thank you!"),
              ],
            )
          ),
          _buildMessageInput(context),
        ],
      )
    );
  }

  Widget _buildReceivedMessage(BuildContext context, String message) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(right: 30, top: 5,bottom: 5),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: DefaultColors.receiverMessage,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          message,
          style: Theme.of(context).textTheme.bodyMedium
        ),
      ),
    );
  }

  Widget _buildSentMessage(BuildContext context, String message) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.only(left: 30, top: 5,bottom: 5),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: DefaultColors.senderMessage,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          message,
          style: Theme.of(context).textTheme.bodyMedium
        ),
      ),
    );
  }

  Widget _buildMessageInput(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          color: DefaultColors.sentMessageInput,
          borderRadius: BorderRadius.circular(25),
        ),
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {},
              child: Icon(Icons.camera_alt, color: Colors.grey),
            ),
            SizedBox(width: 10),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Message...',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(width: 10),
            GestureDetector(
              onTap: () {},
              child: Icon(Icons.send, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}