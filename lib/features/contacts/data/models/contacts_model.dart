import 'package:chat_app/features/contacts/domain/entities/contact_entity.dart';

class ContactsModel extends ContactEntity{
  ContactsModel({
    required String id,
    required String username,
    required String email,
    required String profileImage
  }) : super(
    id: id,
    username: username,
    email: email,
    profileImage: profileImage
  );

  factory ContactsModel.fromJson(Map<String, dynamic> json) {
    return ContactsModel(
      id: json['contact_id'],
      username: json['username'],
      email: json['email'],
      profileImage: json['profile_image'] ?? 'https://randomuser.me/api/portraits/men/11.jpg',
    );
  }
  
}