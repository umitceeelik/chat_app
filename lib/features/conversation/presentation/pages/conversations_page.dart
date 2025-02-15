import 'package:chat_app/core/theme.dart';
import 'package:chat_app/features/chat/presentation/pages/chat_page.dart';
import 'package:chat_app/features/contacts/presentation/bloc/contacts_bloc.dart';
import 'package:chat_app/features/contacts/presentation/bloc/contacts_event.dart';
import 'package:chat_app/features/contacts/presentation/bloc/contacts_state.dart';
import 'package:chat_app/features/contacts/presentation/pages/contacts_page.dart';
import 'package:chat_app/features/conversation/presentation/bloc/conversations_bloc.dart';
import 'package:chat_app/features/conversation/presentation/bloc/conversations_event.dart';
import 'package:chat_app/features/conversation/presentation/bloc/conversations_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConversationsPage extends StatefulWidget {
  
  const ConversationsPage({Key? key}) : super(key: key);

  @override
  State<ConversationsPage> createState() => _ConversationsPageState();
}

class _ConversationsPageState extends State<ConversationsPage> {

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ConversationsBloc>(context).add(FetchConversations());
    BlocProvider.of<ContactsBloc>(context).add(LoadRecentContacts());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Messages',
          style: Theme.of(context).textTheme.titleLarge,
        ),
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
          BlocBuilder<ContactsBloc, ContactsState>(
            builder: (context, state) {
              if(state is RecentContactsLoaded) {
                return  Container(
                  height: 100,
                  padding: EdgeInsets.all(5),
                  child: ListView.builder(
                      itemCount: state.recentContacts.length,
                      physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final contact = state.recentContacts[index];
                        return _buildRecentContact(contact.username, contact.profileImage, context);
                      }
                  ),
                );
              } else if (state is ContactsLoading) {
                return Center(child: CircularProgressIndicator());
              }
              return Center(child: Text('No recent contacts found'));
            }
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
              child: BlocBuilder<ConversationsBloc, ConversationsState>(
                builder: (context, state) {
                  if(state is ConversationsLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is ConversationsLoaded) {
                    return ListView.builder(
                      itemCount: state.conversations.length,
                      itemBuilder: (context, index) {
                        final conversation = state.conversations[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) =>
                              ChatPage(
                                conversationId: conversation.id,
                                mate: conversation.participantName,
                                profileImage: conversation.participantImage)
                            ));
                          },
                          child: _buildMessageTile(
                            conversation.participantName,
                            conversation.participantImage,
                            conversation.lastMessage,
                            conversation.lastMessageTime.toString()
                          ),
                        );
                      },
                    );
                  } else if(state is ConversationError) {
                    return Center(child: Text(state.message));
                  }
                  return Center(child: Text('No conversations found'));                 
                },
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          final contactsBloc = BlocProvider.of<ContactsBloc>(context);
          var res = await Navigator.push(
            context, 
            MaterialPageRoute(builder: (context) => ContactsPage())
          );
          if(res == null) {
            contactsBloc.add(LoadRecentContacts());
          }
        },
        backgroundColor: DefaultColors.buttonColor,
        child: const Icon(Icons.contacts, color: Colors.white),
      ),
    );
  }

  Widget _buildMessageTile(String name, String image, String message, String time) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      leading: CircleAvatar(
        radius: 30,
        backgroundImage: NetworkImage(image),
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

  Widget _buildRecentContact(String name, String image, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(image) ,
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