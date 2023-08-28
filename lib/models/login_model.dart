
class UserLoginModel {
  bool status = false;
  String message = "Default Message";
  UserData? data;

  Map<String ,dynamic> defaultJson = {
  "id" : 0,
  "name" : "default",
  "email" : "default",
  "phone" : "1234567890",
  "image" : "",
  "points" : 0,
  "credit" : 0,
  "token" : ""
};

  UserLoginModel(Map<String, dynamic> json) {
    status =json["status"];
    message =json["message"] ?? "";
    data = UserData(json['data'] ?? defaultJson) ;
  }
}

class UserData {
  int id = 0;
  String name = "Default name";
  String email = "Default email";
  String phone = "Default phone";
  String image = "Default image";
  int points = 0;
  int credit = 0;
  String token = "Default token";

  UserData(Map<String, dynamic> json) {
    id = json["id"] ?? 0;
    name = json["name"];
    email = json["email"];
    phone = json["phone"];
    image = json["image"];
    points = json["points"] ?? 0;
    credit = json["credit"] ?? 0;
    token = json["token"];
  }
}
