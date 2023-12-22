class CheckEmailSignUpModel {
  CheckEmailSignUpModel({
     this.status,
     this.message,
  });
   bool ?status;
   String ?message;

  CheckEmailSignUpModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    return data;
  }
}