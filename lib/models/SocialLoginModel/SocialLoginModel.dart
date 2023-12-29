class SocialLoginModel {
  SocialLoginModel({
     this.status,
     this.emailRegistered ,
     this.name,
     this.message,
     this.role,
     this.step,
     this.token,
  });
   bool? status;
   bool? emailRegistered;
   String? name;
   String? message;
   dynamic role;
   dynamic step;
   String? token;

  SocialLoginModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    emailRegistered = json['email_registered'];
    name = json['name'];
    message = json['message'];
    role = json['role'];
    step = json['step'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['name'] = name;
    _data['message'] = message;
    _data['role'] = role;
    _data['step'] = step;
    _data['token'] = token;
    return _data;
  }
}