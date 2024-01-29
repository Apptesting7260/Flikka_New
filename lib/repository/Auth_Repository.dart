
import 'package:flikka/data/network/network_api_services.dart';
import 'package:flikka/models/ApplyJobModel/ApplyJobModel.dart';
import 'package:flikka/models/CheckEmailSignUpModel/CheckEmailSignUpModel.dart';
import 'package:flikka/models/EditAboutModel/EditAboutModel.dart';
import 'package:flikka/models/ForgotPasswordModel/ForgotPasswordModel.dart';
import 'package:flikka/models/ForgotPasswordModel/Otp/OtpVerificationModel.dart';
import 'package:flikka/models/LoginModel/LoginModel.dart';
import 'package:flikka/models/RequiredSkillsModel/RequiredSkillsModel.dart';
import 'package:flikka/models/ResetPasswordModel/ResetPasswordModel.dart';
import 'package:flikka/models/SaveBankDetailsModel/SaveBankDetailsModel.dart';
import 'package:flikka/models/SeekerChoosePositionGetModel/SeekerChoosePositionGetModel.dart';
import 'package:flikka/models/SeekerChoosePositionModel/SeekerChoosePositionModel.dart';
import 'package:flikka/models/SeekerReferalModel/SeekerReferalModel.dart';
import 'package:flikka/models/SeenUnSeenWalletMessageModel/SeenUnSeenWalletMessageModel.dart';
import 'package:flikka/models/SeenUnseenPendingInterviewModel/SeenUnSeenPendingInterviewModel.dart';
import 'package:flikka/models/SelectIndustryModel/SelectIndustryModel.dart';
import 'package:flikka/models/SetRollModel/SetRollModel.dart';
import 'package:flikka/models/SkipStepModel/SkipStepModel.dart';
import 'package:flikka/models/SocialLoginModel/SocialLoginModel.dart';
import 'package:flikka/models/ViewLanguageModel/VIewLanguageModel.dart';
import 'package:flikka/models/ViewSeekerProfileModel/ViewSeekerProfileModel.dart';
import 'package:flikka/res/app_url.dart';
import 'package:flutter/foundation.dart';
import '../models/EditMobileNumberModel.dart';
import '../models/JobAlertWiseJobListingModel/JobAlertWiseJobListingModel.dart';
import '../models/NewProfileModelSeeker/NewProfileModelSeeker.dart';
import '../models/OnboardingModel/OnboardingModel.dart';
import '../models/PaymentRequestModel/PaymentRequestModel.dart';
import '../models/RecruiterInboxDataModel/RecruiterInboxDataModel.dart';
import '../models/SeekerGetAllSkillsModel/SeekerGetAllSkillsModel.dart';
import '../models/SeekerJobAlertListModel/SeekerJobAlertListModel.dart';
import '../models/SeekerNotificationDataModel/SeekerNotificationDataModel.dart';
import '../models/SeekerSoftSkillsModel/SeekerSoftSkillsModel.dart';
import '../models/SeekerViewInterviewAll/SeekerViewInterviewAll.dart';
import '../models/SelectOrRejectAfterInterviewModel/SelectOrRejectAfterInterviewModel.dart';
import '../models/SetJobAlertModel/SetJobAlert.dart';
import '../models/ShowBankDetailsModel/ShowBankDetailsModel.dart';
import '../models/ShowReferralByUserSeeker/ShowReferralByUserSeeker.dart';
import '../models/SignUpModel/SignUpModel.dart';
import '../models/ViewRecruiterProfileModel/ViewRecruiterProfileModel.dart';

class AuthRepository {
  int?abcd;
  final _apiService  = NetworkApiServices() ;

  Future<SignUpModel> SignUpApi(var data) async{
    if (kDebugMode) {
      print("object");
    }
    dynamic response = await _apiService.postApi(data, AppUrl.SignUpUrl);
    if (kDebugMode) {
      print('api successssssssssssssssss');
    }
    // print(response);
    return SignUpModel.fromJson(response);
  }

  Future<SetRollModel> SetRollApi(var data) async{
    dynamic response = await _apiService.postApi(data, AppUrl.SetRollUrl);
    return SetRollModel.fromJson(response);
  }

  Future<LoginModel> LoginApi(var data) async{
    dynamic response = await _apiService.postApi(data, AppUrl.LoginUrl);
    return LoginModel.fromJson(response);
  }

  Future<ForgotPasswordModel> ForgotPasswordApi(var data) async{
    dynamic response = await _apiService.postApi(data, AppUrl.ForgotPasswordUrl);
    return ForgotPasswordModel.fromJson(response);
  }

  Future<OtpVerificationModel> otpVerification(var data , bool register) async{
    dynamic response = await _apiService.postApi(data, register ? AppUrl.verifyRegistrationOtpUrl : AppUrl.VerifyOtpUrl);
    return OtpVerificationModel.fromJson(response);
  }

  Future<SeekerReferralModel> seekerReferral(var data) async{
    dynamic response = await _apiService.postApi2(data, AppUrl.seekerReferralCode);
    return SeekerReferralModel.fromJson(response);
  }

  Future<ResetPasswordModel> resetPasswordApi(var data) async{
    dynamic response = await _apiService.postApi2(data, AppUrl.ResetPasswordUrl);
    return ResetPasswordModel.fromJson(response);
  }

  Future<SeekerChoosePositionModel> SeekerChoosePositionApi(var data) async{
    dynamic response = await _apiService.postApi2(data, AppUrl.SeekerChoosePositionUrl);
    return SeekerChoosePositionModel.fromJson(response);
  }

  Future<SkipStepModel> skipStepApi(var data) async{
    dynamic response = await _apiService.postApi2(data, AppUrl.skipStep);
    return SkipStepModel.fromJson(response);
  }

  Future<SeekerSkillsModel> seekerChooseSkillsApi(var data) async{
    dynamic response = await _apiService.postApi2(data, AppUrl.seekerSkills);
    return SeekerSkillsModel.fromJson(response);
  }

  Future<RequiredSkillsModel> requiredSkillsApi(var data) async{
    dynamic response = await _apiService.postApi2(data, AppUrl.addUpdateJobSkills);
    return RequiredSkillsModel.fromJson(response);
  }


  Future<SeekerChoosePositionGetModel> seekerGetPositions() async{
    dynamic response = await _apiService.getApi2(AppUrl.seekerChoosePositionGetUrl);
    return SeekerChoosePositionGetModel.fromJson(response);
  }

  Future<SeekerGetAllSkillsModel?> seekerGetAllSkillsApi() async{
    dynamic response = await _apiService.getApi2(AppUrl.seekerGetAllSkills);
    return SeekerGetAllSkillsModel.fromJson(response);
  }

  Future<SelectIndustryModel> selectIndustryApi() async{
    dynamic response = await _apiService.getApi2(AppUrl.getIndustries);
    return SelectIndustryModel.fromJson(response);
  }

  Future<ViewRecruiterProfileModel> viewRecruiterProfile() async{
    dynamic response = await _apiService.getApi2(AppUrl.editRecruiterProfileGetUrl);
    return ViewRecruiterProfileModel.fromJson(response);
  }


  Future<CheckEmailSignUpModel> checkEmailSignUpApi(var data) async {
    dynamic response = await _apiService.postApi2(
        data, AppUrl.checkEmailSignUpUrl);
    return CheckEmailSignUpModel.fromJson(response);
  }

  Future<EditAboutModel> editSeekerAboutApi(var data) async {
    dynamic response = await _apiService.postApi2(
        data, AppUrl.editAboutSeeker);
    return EditAboutModel.fromJson(response);
  }

  Future<EditAboutModel> editSeekerLanguageApi(var data) async {
    dynamic response = await _apiService.postApi2(data, AppUrl.editSeekerLanguage);
    return EditAboutModel.fromJson(response);
  }

  Future<EditAboutModel> editSeekerExperienceApi(var data) async {
    dynamic response = await _apiService.postApi2(
        data, AppUrl.editSeekerExperience);
    return EditAboutModel.fromJson(response);
  }

  Future<EditAboutModel> editSeekerEducationApi(var data) async {
    dynamic response = await _apiService.postApi2(
        data, AppUrl.editSeekerEducation);
    return EditAboutModel.fromJson(response);
  }

  Future<EditAboutModel> editSeekerAppreciationApi(var data) async {
    dynamic response = await _apiService.postApi2(
        data, AppUrl.editSeekerAppreciation);
    return EditAboutModel.fromJson(response);
  }

  Future<EditAboutModel> editSeekerProfileApi(var data) async {
    dynamic response = await _apiService.postApi2(
        data, AppUrl.editSeekerProfile);
    return EditAboutModel.fromJson(response);
  }

  Future<ApplyJobModel> applyJobApi(var data) async {
    dynamic response = await _apiService.postApi2(
        data, AppUrl.applyJob);
    return ApplyJobModel.fromJson(response);
  }


  Future<EditAboutModel> logoutApi(var data) async {
    dynamic response = await _apiService.postApi2(
        data, AppUrl.logout);
    return EditAboutModel.fromJson(response);
  }


  Future<ViewSeekerProfileModel> viewSeekerProfile() async{
    dynamic response = await _apiService.getApi2(AppUrl.viewSeekerProfile);
    return ViewSeekerProfileModel.fromJson(response);

  }

  Future<ViewLanguageModel> viewLanguageApi() async{
    dynamic response = await _apiService.getApi2(AppUrl.viewLanguage);
    return ViewLanguageModel.fromJson(response);
  }

  Future<PaymentRequestModel> paymentRequestApi(var data) async {
    dynamic response = await _apiService.postApi2(
        data, AppUrl.paymentRequestUrl);
    return PaymentRequestModel.fromJson(response);
  }

  Future<SaveBankDetailsModel> SaveBankDetailsApi(var data) async {
    dynamic response = await _apiService.postApi2(
        data, AppUrl.saveBankDetailsUrl);
    return SaveBankDetailsModel.fromJson(response);
  }

  Future<ShowBankDetailsModel> showBankDetails() async{
    dynamic response = await _apiService.getApi2(AppUrl.showBankDetailsUrl);
    return ShowBankDetailsModel.fromJson(response);

  }

  Future<EditMobileNumberModel> editSeekerMobileNumberApi(var data) async {
    dynamic response = await _apiService.postApi2(
        data, AppUrl.editMobileNumberSeeker);
    return EditMobileNumberModel.fromJson(response);
  }

  Future<EditAboutModel> deleteUser(var data) async {
    dynamic response = await _apiService.postApi2(data, AppUrl.deleteUser);
    return EditAboutModel.fromJson(response);
  }

  Future<SeekerViewInterviewModel> seekerInterViewList(var data) async{
    dynamic response = await _apiService.postApi2(data,AppUrl.seekerViewInterviewAllUrl);
    return SeekerViewInterviewModel.fromJson(response);
  }

  Future<RecruiterInboxDataModel> viewInboxData() async{
    dynamic response = await _apiService.getApi2(AppUrl.recruiterInboxData);
    return RecruiterInboxDataModel.fromJson(response);
  }

  Future<void> interViewCancleApi(var data) async {
    dynamic response = await _apiService.postApi2(
        data, AppUrl.recruiterInterviewCancle);
  }

  Future<SetJobAlertModel> setJobAlertApi(var data) async{
    dynamic response = await _apiService.postApi2(data,AppUrl.setJobAlert);
    return SetJobAlertModel.fromJson(response);
  }

  Future<SeekerNotificationDataModel> viewSeekerNotificationDataApi() async{
    dynamic response = await _apiService.getApi2(AppUrl.viewSeekerNotificationData);
    return SeekerNotificationDataModel.fromJson(response);
  }

  Future<ProfileModelSeeker> viewSeekerProfilerr() async{
    dynamic response = await _apiService.getApi2(AppUrl.viewSeekerProfile);
    return ProfileModelSeeker.fromJson(response);
  }

  Future<EditAboutModel> interViewConfirmationApi(var data) async {
    dynamic response = await _apiService.postApi2(
        data, AppUrl.interViewConfirmation);
    return EditAboutModel.fromJson(response);
  }

  Future<SocialLoginModel> socialLoginApi(var data) async{
    dynamic response = await _apiService.postApi2(data,AppUrl.socialLogin);
    return SocialLoginModel.fromJson(response);
  }

  Future<OnboardingModel> onboardingApi(var data) async{
    dynamic response = await _apiService.postApi2(data,AppUrl.onboarding);
    return OnboardingModel.fromJson(response);
  }

  Future<SelectOrRejectAfterInterviewModel> selectOrRejectInterviewApi(var data) async{
    dynamic response = await _apiService.postApi2(data,AppUrl.selectOrRejectAfterInterview);
    return SelectOrRejectAfterInterviewModel.fromJson(response);
  }

  Future<SeenUnseenPendingInterviewModel> seenUnseenInterviewApi(var data) async{
    dynamic response = await _apiService.postApi2(data,AppUrl.seenUnseenPendingInterviewUrl);
    return SeenUnseenPendingInterviewModel.fromJson(response);
  }

  Future<SeenUnSeenWalletMessageModel> seenUnSeenWalletApi(var data) async{
    dynamic response = await _apiService.postApi2(data,AppUrl.seenUnSeenWalletMessage);
    return SeenUnSeenWalletMessageModel.fromJson(response);
  }

  Future<SeekerJobAlertListModel> jobAlertListDataApi() async{
    dynamic response = await _apiService.getApi2(AppUrl.jobAlertListUrl);
    return SeekerJobAlertListModel.fromJson(response);
  }

  Future<JobAlertWiseJobListingModel> jobAlertWiseJobListApi(var data) async {
    dynamic response = await _apiService.postApi2(data,AppUrl.jobAlertWiseJobListingUrl);
    return JobAlertWiseJobListingModel.fromJson(response);
  }

}