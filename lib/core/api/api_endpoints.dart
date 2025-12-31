class ApiEndpoints {
  // Base URL
  // static const String baseUrl ="https://am-34kc.onrender.com/api/v1";
  static const String baseUrl = "http://localhost:8000/api/v1";
  // static SectionEndpoints get section => SectionEndpoints();
////////////////////////// IMAGE UPLOAD//////////////////////
//// Cloudinary Image Upload URL
  static const String  UploadUrl = "$baseUrl/uploads/image";
///
  static const String registerUser = "$baseUrl/auth/register";
  static const String loginUser = "$baseUrl/auth/login";

  static const verifyOtp = "$baseUrl/auth/verifyOtp";
  static const sendResetPasswordOtp = "$baseUrl/auth/resendOtp";
  static const resendOtp = "$baseUrl/auth/resendOtp";
  static const resetPassword = "$baseUrl/auth/reset-password";

  //profile personal and public profile search
  static const String createProfile = "$baseUrl/profile";
 ////////////////////////////////////////////////////////
 ///ClubEndpoints
 
  static const String clubDetailsUrl = "$baseUrl/club";
  static const String createClub = "$baseUrl/club/";
  static String getClubDetails(String clubId) => "$clubDetailsUrl/$clubId";
 ////////////////////////////////////////////////////////

  static const String myprofileurl = "$baseUrl/profile";
  static String myProfile() => "$myprofileurl/me";

  static const String profileSearchUrl = "$baseUrl/profile/public/search";
  static const String clubSearchUrl = "$baseUrl/club/search";
  static const String clubAvailabilityUrl = "$baseUrl/club/check/";
  static String checkclubAvailability(String clubName) =>
      "$clubAvailabilityUrl$clubName";
  static String searchProfiles({
    required String query,
    int page = 1,
  }) =>
      "$profileSearchUrl?q=$query&page=$page";
  static String searchClubs({
    required String query,
    int page = 1,
  }) =>
      "$clubSearchUrl?q=$query&page=$page";
  static const String storyurl = "$baseUrl/story";
  static String story(storyId) => storyurl;
}
