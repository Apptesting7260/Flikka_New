
import 'package:flikka/models/AvtarImageModel/AvtarImageModel.dart';
import 'package:flikka/models/CompanyListModel/CompanyListModel.dart';
import 'package:flikka/models/ForumCommentsModel/ForumCommentsModel.dart';
import 'package:flikka/models/SeekerAppliedJobsModel/SeekerAppliedJobsModel.dart';
import 'package:flikka/models/SeekerEarningModel/SeekerEarningModel.dart';
import 'package:flikka/models/SeekerJobFilterModel/SeekerJobFilterModel.dart';
import 'package:flikka/models/SeekerSavedPostModel/SeekerSavedPostModel.dart';
import 'package:flikka/models/ViewRecruiterProfileModel/ViewRecruiterProfileModel.dart';
import 'package:get_storage/get_storage.dart';

import '../../data/network/network_api_services.dart';
import '../../models/AvtarImageListModel/AvtarImageListModel.dart';
import '../../models/CoverAvtarListRecruiterModel/CoverAvtarListRecruiterModel.dart';
import '../../models/CoverImageModel/CoverImageModel.dart';
import '../../models/EditAboutModel/EditAboutModel.dart';
import '../../models/FilteredJobsModel/FilteredJobsModel.dart';
import '../../models/GetJobsListingModel/GetJobsListingModel.dart';
import '../../models/NewProfileModelSeeker/NewProfileModelSeeker.dart';
import '../../models/ScheduledInterviewListModel/ScheduledInterviewListModel.dart';
import '../../models/SeekerForumDataModel/SeekerForumDataModel.dart';
import '../../models/SeekerForumIndustryListModel/SeekerForumIndustryListModel.dart';
import '../../models/SeekerMapJobsModel/SeekerMapJobsModel.dart';
import '../../models/SeekerViewInterviewAll/SeekerViewInterviewAll.dart';
import '../../models/ShowReferralByUserSeeker/ShowReferralByUserSeeker.dart';
import '../../models/ViewJobFromNotification/ViewJobFromNotification.dart';
import '../../res/app_url.dart';

class SeekerRepository {
  final apiServices = NetworkApiServices();
final box = GetStorage();
  Future<GetJobsListingModel> getJobsListingApi() async {
    
    dynamic response = await apiServices.getApi2(AppUrl.getJobsListing);
   
      box.remove('jobsListing');
        box.write('jobsListing', response);
      var data=  box.read('jobsListing');
       print("responseaaa${data['Jobs'][0]['lat']}");
    return GetJobsListingModel.fromJson(response);
  }

  Future<ShowReferralByUserModel> getWalletApi() async {
    dynamic response = await apiServices.getApi2(AppUrl.seekerEarningDetails);
    return ShowReferralByUserModel.fromJson(response);
  }

  Future<CompanyListModel> companiesListApi() async {
    dynamic response = await apiServices.getApi2(AppUrl.companiesList);
    return CompanyListModel.fromJson(response);
  }

  Future<SeekerSavedJobsListModel> seekerSavedJobsListApi(var data) async {
    dynamic response = await apiServices.postApi2(
        data, AppUrl.seekerSavedJobsList);
    return SeekerSavedJobsListModel.fromJson(response);
  }

  Future<ViewRecruiterProfileModel> seekerViewCompanyDetail(var data) async {
    dynamic response = await apiServices.postApi2(
        data, AppUrl.seekerViewCompanyDetails);
    return ViewRecruiterProfileModel.fromJson(response);
  }

  Future<GetJobsListingModel> seekerJobFilterApi(var data) async {
    dynamic response = await apiServices.postApi2(
        data, AppUrl.getFilteredJobsListing);
    return GetJobsListingModel.fromJson(response);
  }

  Future<EditAboutModel> seekerSaveJobPost(var data) async {
    dynamic response = await apiServices.postApi2(data, AppUrl.seekerSaveJob);
    return EditAboutModel.fromJson(response);
  }

  Future<EditAboutModel> seekerPostReview(var data) async {
    dynamic response = await apiServices.postApi2(
        data, AppUrl.seekerPostReview);
    return EditAboutModel.fromJson(response);
  }

  Future<EditAboutModel> editSeekerSalaryExpectation(var data) async {
    dynamic response = await apiServices.postApi2(
        data, AppUrl.editSeekerSalary);
    return EditAboutModel.fromJson(response);
  }

  Future<EditAboutModel> editSeekerSoftSkill(var data, int number) async {
    dynamic response = await apiServices.postApi2(data,
        number == 1 ? AppUrl.editSeekerSoftSkills :
        number == 2 ? AppUrl.editSeekerPassion :
        number == 3 ? AppUrl.editSeekerIndustryPreference :
        number == 4 ? AppUrl.editSeekerStrength :
        number == 5 ? AppUrl.editSeekerStartWork :
        AppUrl.editSeekerAvailability);
    return EditAboutModel.fromJson(response);
  }

  Future<SeekerAppliedJobsModel> appliedJobsApi() async {
    dynamic response = await apiServices.getApi2(AppUrl.seekerAppliedJobs);
    return SeekerAppliedJobsModel.fromJson(response);
  }

  Future<SeekerMapJobsModel> getNearByJobs() async {
    dynamic response = await apiServices.getApi2(AppUrl.seekerNearByJobs);
    return SeekerMapJobsModel.fromJson(response);
  }

  Future<EditAboutModel> seekerUpdateRequestedJobStatus(var data) async {
    dynamic response = await apiServices.postApi2(
        data, AppUrl.seekerUpdateRequestedJobStatus);
    return EditAboutModel.fromJson(response);
  }

  Future<SeekerViewInterviewModel> getInterviewList(var data) async {
    dynamic response = await apiServices.postApi2(
        data, AppUrl.seekerInterviewList);
    return SeekerViewInterviewModel.fromJson(response);
  }

  Future<EditAboutModel> unSavePost(var data) async {
    dynamic response = await apiServices.postApi2(
        data, AppUrl.seekerUnSavePost);
    return EditAboutModel.fromJson(response);
  }

  Future<SeekerForumDataModel> seekerForumData(var data) async {
    dynamic response = await apiServices.postApi2(data, AppUrl.seekerForumList);
    return SeekerForumDataModel.fromJson(response);
  }

  Future<EditAboutModel> seekerAddForum(var data) async {
    dynamic response = await apiServices.postApi2(data, AppUrl.seekerAddForum);
    return EditAboutModel.fromJson(response);
  }

  Future<ForumIndustryListModel> forumIndustryList() async {
    dynamic response = await apiServices.getApi2(AppUrl.forumDataIndustryList);
    return ForumIndustryListModel.fromJson(response);
  }

  Future<ForumCommentsModel> forumComments(var data) async {
    dynamic response = await apiServices.postApi2(
        data, AppUrl.forumCommentsList);
    return ForumCommentsModel.fromJson(response);
  }

  Future<EditAboutModel> forumAddComment(var data) async {
    dynamic response = await apiServices.postApi2(data, AppUrl.forumAddComment);
    return EditAboutModel.fromJson(response);
  }

  Future<ViewJobFromNotification> viewJobFromNotification(var data) async {
    dynamic response = await apiServices.postApi2(
        data, AppUrl.viewJobFromNotification);
    return ViewJobFromNotification.fromJson(response);
  }

  Future<AvtarImageModel> avtarImageApi(var data) async {
    dynamic response = await apiServices.postApi2(data, AppUrl.avtarImage);
    return AvtarImageModel.fromJson(response);
  }

  Future<EditAboutModel> addInOngoing(var data) async {
    dynamic response = await apiServices.postApi2(data, AppUrl.addInOngoing);
    return EditAboutModel.fromJson(response);
  }

  Future<AvtarImageListModel> avtarListApi() async {
    dynamic response = await apiServices.getApi2(AppUrl.avtarImageList);
    return AvtarImageListModel.fromJson(response);
  }

  Future<EditAboutModel> notificationSeen(var data) async {
    dynamic response = await apiServices.postApi2(data, AppUrl.notificationSeen);
    return EditAboutModel.fromJson(response);
  }

  Future<CoverAvtarListRecruiter> coverAvtarList() async {
    dynamic response = await apiServices.getApi2(AppUrl.coverAvtarListRecruiter);
    return CoverAvtarListRecruiter.fromJson(response);
  }

  Future<CoverImageModel> coverImageRecruiter(var data) async {
    dynamic response = await apiServices.postApi2(data, AppUrl.coverImageModel);
    return CoverImageModel.fromJson(response);
  }


}