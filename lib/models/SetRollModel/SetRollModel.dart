class SetRollModel {
  SetRollModel({
     this.status,
     this.message,
     this.token,
  });
   bool ?status;
   String ?message;
   String ?token;

  SetRollModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    message = json['message'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['token'] = token;
    return data;
  }
}