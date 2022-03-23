class UserModel {
  var userId;
  var email;
  var name;
  var token;

  UserModel({this.userId, this.email, this.name, this.token});

  Map<String, dynamic> toJson() {
    return {
      "userId": this.userId,
      "email": this.email,
      "name": this.name,
      "token": this.token,
    };
  } //factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  // Map<String, dynamic> toJson() => _$UserToJson(this);

  factory UserModel.fromJson(Map<String, dynamic> data) {
    return UserModel(
      userId: data["Id"],
      name: data["Name"],
      email: data["Email"],
      token: data["Token"],
    );
  }
}
