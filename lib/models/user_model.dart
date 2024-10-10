class UserModel {
  String id;
  String firstName;
  String lastName;
  String fatherName;
  String email;
  String profileImageUrl;
  String phoneNumber;
  String password;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.fatherName,
    required this.email,
    required this.profileImageUrl,
    required this.phoneNumber,
    required this.password,
  });

  /// To Upload User to FireStore
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'fatherName': fatherName,
      'email': email,
      'profileImageUrl': profileImageUrl,
      'phoneNumber': phoneNumber,
      'password': password,
    };
  }

  /// To Get User from FireStore
  factory UserModel.fromSnapshot(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      fatherName: map['fatherName'] ?? '',
      email: map['email'] ?? '',
      profileImageUrl: map['profileImageUrl'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      password: map['password'] ?? '',
    );
  }
}
