class SeekerChoosePositionModel {
  SeekerChoosePositionModel({
     this.status,
     this.message,
    this.step
  });
   bool ?status;
   String ?message;
   int? step ;

  SeekerChoosePositionModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    message = json['message'];
    step = json["step"] ;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['message'] = message;
    return _data;
  }
}