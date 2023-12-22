
import '../SeekerAppliedJobsModel/SeekerAppliedJobsModel.dart';

class SeekerMapJobsModel {
  bool? status;
  dynamic lat ;
  dynamic long ;
  List<AppliedJobsList>? jobs;

  SeekerMapJobsModel({
    this.status,
    this.lat ,
    this.long ,
    this.jobs
}) ;

  factory SeekerMapJobsModel.fromJson(Map<String, dynamic> json) => SeekerMapJobsModel(
    status: json["status"],
    lat: json["lat"],
    long: json["long"],
    jobs: json["jobs"] == null ? json["jobs"] : List<AppliedJobsList>.from(json["jobs"].map((x) => AppliedJobsList.fromJson(x))),
  );

}