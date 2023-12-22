class ResetPasswordModel {
  ResetPasswordModel({
     this.status,
     this.message,
    this.role
  });
   bool ?status;
   String ?message;
   int? role ;

  ResetPasswordModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    message = json['message'];
    role = json["role"] ;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data["role"] = role ;
    return data;
  }
}