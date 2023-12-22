class SignUpModel {
  SignUpModel({
     this.status,
    this.message,
    this.id,
    this.token
  });
 var status;
 var message;
 var id;
 var token ;

  SignUpModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    message = json['message'];
    id = json['id'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['id'] = id;
    data['token'] = token;
    return data;
  }
}