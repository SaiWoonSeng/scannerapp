class UserModel {
  String? userName, userNo, email, uID;

  UserModel({this.userNo, this.userName, this.email, this.uID});

  // get data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      userNo: map['uNo'],
      userName: map['uName'],
      email: map['email'],
      uID: map['uID'],
    );
  }

  // sent data to server
  Map<String, dynamic> toMap() {
    return {'uNo': userNo, 'uName': userName, 'email': email, 'uID': uID};
  }
}
