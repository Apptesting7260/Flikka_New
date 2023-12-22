import 'package:flikka/data/network/network_api_services.dart';
import 'package:flikka/models/EditAboutModel/EditAboutModel.dart';
import 'package:flikka/models/RecruiterHomeModel/RecruiterHomeModel.dart';
import 'package:flikka/models/RecruiterHomePageJobsModel/RecruiterHomePageJobsModel.dart';
import 'package:flikka/models/RecuiterJobTitleModel/RecruiterJobTitleModel.dart';
import 'package:flikka/models/ScheduledInterviewListModel/ScheduledInterviewListModel.dart';
import 'package:flikka/models/TalentPoolModel/TalentPoolModel.dart';
import 'package:flikka/models/ViewParticularCandidateModel/ViewParticularCandidateModel.dart';
import '../../models/ApplicantTrackingDataModel/ApplicantTrackingDataModel.dart';
import '../../models/RecruiterHomePageModel/RecruiterHomePageModel.dart';
import '../../models/RecruiterReportModel/RecruiterReportModel.dart';
import '../../res/app_url.dart';

class RecruiterRepository {
  final apiServices = NetworkApiServices() ;

  Future<EditAboutModel> deleteJob(var data) async{
    dynamic response = await apiServices.postApi2( data,AppUrl.recruiterDeleteJob);
    return EditAboutModel.fromJson(response);
  }


  Future<ApplicantTrackingDataModel> applicantTrackingData(var data) async{
    dynamic response = await apiServices.postApi2( data,AppUrl.applicantTrackingData);
    return ApplicantTrackingDataModel.fromJson(response);
  }

  Future<ViewParticularCandidateModel> viewParticularCandidate(var data) async{
    dynamic response = await apiServices.postApi2( data,AppUrl.viewParticularCandidate);
    return ViewParticularCandidateModel.fromJson(response);
  }

  Future<EditAboutModel> scheduleInterview(var data) async{
    dynamic response = await apiServices.postApi2( data,AppUrl.scheduleInterview);
    return EditAboutModel.fromJson(response);
  }

  Future<EditAboutModel> candidateJobStatus(var data) async{
    dynamic response = await apiServices.postApi2( data,AppUrl.candidateJobStatus);
    return EditAboutModel.fromJson(response);
  }

  Future<RecruiterJobTitleModel> getJobTitleApi() async{
    dynamic response = await apiServices.getApi2(AppUrl.recruiterJobTitle);
    return RecruiterJobTitleModel.fromJson(response);
  }

  Future<RecruiterHomePageJobsModel> getHomePageJobsApi() async{
    dynamic response = await apiServices.getApi2(AppUrl.newRecruiterHomePageJobs);
    return RecruiterHomePageJobsModel.fromJson(response);
  }

  Future<ScheduledInterviewListModel> getInterviewList(var data) async{
    dynamic response = await apiServices.postApi2(data,AppUrl.scheduledInterviewList);
    return ScheduledInterviewListModel.fromJson(response);
  }

  Future<ScheduledInterviewListModel> getRequestedSeekersList() async{
    dynamic response = await apiServices.getApi2(AppUrl.requestedSeekers);
    return ScheduledInterviewListModel.fromJson(response);
  }

  Future<RecruiterHomePageModel> recruiterHomeApi(var data) async{
    dynamic response = await apiServices.postApi2( data,AppUrl.newRecruiterHomePage);
    return RecruiterHomePageModel.fromJson(response);
  }

  Future<TalentPoolModel> talentPoolApi() async{
    dynamic response = await apiServices.getApi2(AppUrl.talentPoolList);
    return TalentPoolModel.fromJson(response);
  }

  Future<EditAboutModel> addToPool(var data) async{
    dynamic response = await apiServices.postApi2( data,AppUrl.talentPoolSeeker);
    return EditAboutModel.fromJson(response);
  }

  Future<EditAboutModel> removeFromPool(var data) async{
    dynamic response = await apiServices.postApi2( data,AppUrl.removeFromTalentPool);
    return EditAboutModel.fromJson(response);
  }

  Future<RecruiterReportModel> reportApi() async{
    dynamic response = await apiServices.getApi2(AppUrl.recruiterReportApi);
    return RecruiterReportModel.fromJson(response);
  }
}