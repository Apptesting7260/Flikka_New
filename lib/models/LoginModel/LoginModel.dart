class LoginModel {
  LoginModel({this.status, this.message, this.token, this.name , this.role, this.step});
  bool? status;
  String? message;
  String? token;
  String? name;
  var role;
  var step;

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    token = json['token'];
    name = json['name'];
    role = json['role'];
    step = json['step'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['token'] = token;
    data['name'] = name;
    data['role'] = role;
    data['step'] = step;
    return data;
  }
}
