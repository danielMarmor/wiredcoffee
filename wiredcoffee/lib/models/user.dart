import 'package:wiredcoffee/shared/constants.dart';

class UserModel {
  late String userId;
  final String email;
  final String userName;
  final String phoneNumber;
  final String gender;
  final String? imageUrl;
  UserModel(
      {required this.userName,
      required this.email,
      required this.phoneNumber,
      required this.gender,
      required this.imageUrl});

  static Map<String, dynamic>? get settings => {
        'email': {'maxLength': 100},
        'userName': {'maxLength': 20},
        'phoneNumber': {'maxLength': 11}
      };

  static UserModel fromJson(Map<String, dynamic>? map) {
    return UserModel(
        userName: map!['userName'],
        email: map['email'],
        phoneNumber: map['phoneNumber'],
        gender: map['gender'],
        imageUrl: map['imageUrl']);
  }

  static Map<String, dynamic> toJson(UserModel model) {
    return {
      'userName': model.userName,
      'email': model.email,
      'phoneNumber': model.phoneNumber,
      'gender': model.gender,
      'imageUrl': model.imageUrl ?? EMPTY
    };
  }
}
