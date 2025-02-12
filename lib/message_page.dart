import 'dart:math';

import 'package:chat_app/core/theme.dart';
import 'package:flutter/material.dart';

class MessagePage extends StatelessWidget {
  
  const MessagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Messages',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        centerTitle: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 70,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search, color: Colors.white),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              'Recent',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
          Container(
            height: 100,
            padding: const EdgeInsets.all(5),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildRecentContact('1',context),
                _buildRecentContact('2',context),
                _buildRecentContact('3',context),
                _buildRecentContact('4',context),
                _buildRecentContact('TEST',context),
                _buildRecentContact('TEST',context),
                _buildRecentContact('5',context),
              ],
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: DefaultColors.messageListPage,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: ListView(
                children: [
                  _buildMessageTile("Umit C", "umitclk2001@gmail.com", '08:43'),
                  _buildMessageTile("hahao C", "umitclk2001@gmail.com", '08:43'),
                  _buildMessageTile("ahemt C", "umitclk2001@gmail.com", '08:43'),
                  _buildMessageTile("elif C", "umitclk2001@gmail.com", '08:43'),
                  _buildMessageTile("husny C", "umitclk2001@gmail.com", '08:43')
                ],
              ),
            ),
          )
        ],
      )
    );
  }

  Widget _buildMessageTile(String name, String message, String time) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      leading: CircleAvatar(
        radius: 30,
        backgroundImage: NetworkImage('https://gratisography.com/wp-content/uploads/2024/11/gratisography-augmented-reality-800x525.jpg'),
      ),
      title: Text(
        name,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        message,
        style: TextStyle(color: Colors.grey),
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Text(
        time,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildRecentContact(String name, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage('https://gratisography.com/wp-content/uploads/2024/11/gratisography-augmented-reality-800x525.jpg'),
          ),
          const SizedBox(height: 5),
          Text(
            name,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}