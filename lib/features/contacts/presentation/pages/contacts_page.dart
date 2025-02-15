import 'package:chat_app/core/theme.dart';
import 'package:chat_app/features/chat/presentation/pages/chat_page.dart';
import 'package:chat_app/features/contacts/presentation/bloc/contacts_bloc.dart';
import 'package:chat_app/features/contacts/presentation/bloc/contacts_event.dart';
import 'package:chat_app/features/contacts/presentation/bloc/contacts_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ContactsBloc>(context).add(FetchContacts());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts', style: Theme.of(context).textTheme.titleLarge),
      ),
      body: BlocListener<ContactsBloc, ContactsState>(      
        listener: (context, state) async {
          final contactsBloc = BlocProvider.of<ContactsBloc>(context);
          if (state is ConversationReady) {
            var res = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatPage(
                  conversationId: state.conversationId,
                  mate: state.contact.username,
                  profileImage: state.contact.profileImage,
                ),
              ),
            );
            if (res == null) {
              contactsBloc.add(FetchContacts());
            }
          }
        },
        child: BlocBuilder<ContactsBloc, ContactsState>(
          builder: (context, state) {
            if (state is ContactsLoading){
              return Center(child: CircularProgressIndicator(),);
            } else if (state is ContactsLoaded) {
              return ListView.builder(
                itemCount: state.contacts.length,
                itemBuilder: (context, index) {
                  final contact = state.contacts[index];
                  return ListTile(
                    title: Text(contact.username, style: TextStyle(color: DefaultColors.whiteText, fontSize: 20),),
                    subtitle: Text(contact.email, style: TextStyle(color: DefaultColors.greyText, fontSize: 14),),
                    onTap: () {
                      // Navigator.pop(context, contact);
                      BlocProvider.of<ContactsBloc>(context).add(
                        CheckOrCreateConversation(contactId: contact.id, contact: contact),
                      );
                      print("a");
                    },
                  );
                },
              );
            } else if (state is ContactsError) {
              return Center(child: Text(state.message),);
            } else {
              return Center(child: Text('No contacts found'),);
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddContactDialog(context),
        backgroundColor: DefaultColors.buttonColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

void _showAddContactDialog(BuildContext context) {
  final emailController = TextEditingController();

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Add Contact', style: Theme.of(context).textTheme.titleMedium),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        content: TextField(
          controller: emailController,
          decoration: InputDecoration(
            hintText: 'Enter contact email',
            hintStyle: Theme.of(context).textTheme.bodyLarge),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: Theme.of(context).textTheme.bodySmall),
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(DefaultColors.buttonColor),
            ),
            onPressed: () {
              final email = emailController.text;
              if (email.isNotEmpty) {
                BlocProvider.of<ContactsBloc>(context).add(AddContact(email: email));
                Navigator.pop(context);
              }
            },
            child: Text('Add', style: Theme.of(context).textTheme.bodyLarge),
          ),
        ],
      );
    },
  );
}