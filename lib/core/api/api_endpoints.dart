class ApiEndpoints {
  // ===================== BASE URL =====================
  static const String baseUrl = "https://akalpit.penverse.in/api/v1";
  //static const String baseUrl = "http://localhost:8000/api/v1";
// 
  // ===================== IMAGE UPLOAD =====================
  //// Cloudinary Image Upload URL
  static const String UploadUrl = "$baseUrl/uploads/image";
static String getClubStories({
  required String clubId,
  required int page,
  required int limit,
}) {
  return "$baseUrl/stories/club/$clubId?page=$page&limit=$limit";
}



  // ===================== AUTH =====================

  static const String registerUser = "$baseUrl/auth/register";
  static const String loginUser = "$baseUrl/auth/login";
  static const verifyOtp = "$baseUrl/auth/verifyOtp";
  static const resendOtp = "$baseUrl/auth/resendOtp";
  static const updateFcmToken = "$baseUrl/auth/deviceToken";
   static String checkusernameAvailability(String username) =>
      "$baseUrl/auth/checkusername/$username";

// 🔐 Protected (JWT required)
  static const String completeProfile = "$baseUrl/auth/completeprofile";

///==================categories and citites=======================>>>>>>
// ===================== FUTURE AUTH (COMMENTED) =====================
static const String sendResetPasswordOtp = "$baseUrl/auth/resendOtp";
static const String resetPassword = "$baseUrl/auth/reset-password";
static const String logoutUser = "$baseUrl/auth/logout";
static const String changeCurrentPassword = "$baseUrl/auth/change-password";
static const String updateAvatar = "$baseUrl/auth/avatar";
static const String updateCoverImage = "$baseUrl/auth/cover-image";
  static const String fetchCategories = "$baseUrl/categories/root";
// ===================== PROFILE =====================

// Create profile (POST /profile)
  static const String createProfile = "$baseUrl/profile";

// My profile (GET /profile/me)
  static const String myprofileurl = "$baseUrl/profile";
  static String myProfile() => "$myprofileurl/me";

// Update my profile (PATCH /profile/me)
  static String updateMyProfile() => "$myprofileurl/me";

// View another user's public profile (GET /profile/users/:userId)
  static String getPublicUserProfile(String userId) =>
      "$baseUrl/profile/public/users/$userId";

// Search public profiles (GET /profile/search)
  static const String profileSearchUrl = "$baseUrl/profile/public/search";
  static String searchProfiles({
    required String query,
    int page = 1,
  }) =>
      "$profileSearchUrl?q=$query&page=$page";

// ===================== CLUB APIs =====================

  /// 1️⃣ Create Club (POST /club) [JWT]
  static const String createClub = "$baseUrl/club";

  /// 2️⃣ Update Club (PATCH /club/:clubId) [JWT + Admin]
  static String updateClub(String clubId) => "$baseUrl/club/$clubId";

  /// 3️⃣ Delete Club (DELETE /club/:clubId) [JWT]
  static String deleteClub(String clubId) => "$baseUrl/club/$clubId";

  /// 4️⃣ Check Club ID Availability (GET /club/check/:clubId)
  static String checkclubAvailability(String clubId) =>
      "$baseUrl/club/check/$clubId";
  static String fetchClubPostsByDate(String clubId, String date) =>
      "$baseUrl/club/posts/club/$clubId/date/$date";
  /// 5️⃣ Search Clubs (GET /club/search)
  static const String clubSearchUrl = "$baseUrl/club/search";
  static String searchClubs({
    required String query,
    int page = 1,
  }) =>
      "$clubSearchUrl?q=$query&page=$page";

  /// 6️⃣ Get Club by ClubId (GET /club/:clubId)
  static String getClubDetails(String Id) => "$baseUrl/club/id/$Id";

  /// 7️⃣ Get Clubs by User (GET /club/user/:userId)
  static String getClubsByUser(String userId) => "$baseUrl/club/user/$userId";

  /// 8️⃣ Get Deleted Clubs by Admin User (GET /club/admin/user/:userId/history)
  static String getDeletedClubsByUser(String userId) =>
      "$baseUrl/club/admin/user/$userId/history";

  /// 9️⃣ Get All Clubs (GET /club)
  static const String getAllClubs = "$baseUrl/club";

  /// 🔟 Get Clubs by Category (GET /club/category/:categoryId)
  static String getClubsByCategory(String categoryId) =>
      "$baseUrl/club/category/$categoryId";

  /// 1️⃣1️⃣ Get Clubs by Council (GET /club/council/:councilId)
  static String getClubsByCouncil(String councilId) =>
      "$baseUrl/club/council/$councilId";

  /// 1️⃣2️⃣ Get Clubs by Institution (GET /club/institution/:institutionId)
  static String getClubsByInstitution(String institutionId) =>
      "$baseUrl/club/institution/$institutionId";

  /// 1️⃣3️⃣ Discover Clubs (GET /club/discover)
  static const String discoverClubs = "$baseUrl/club/discover";

  /// 1️⃣4️⃣ Change Club Privacy (PATCH /club/:clubId/privacy) [JWT + Admin]
  static String changeClubPrivacy(String clubId) =>
      "$baseUrl/club/$clubId/privacy";

  /// 1️⃣5️⃣ Get Club Stats (GET /club/:clubId/stats) [JWT]
  static String getClubStats(String clubId) => "$baseUrl/club/$clubId/stats";

  /// 1️⃣6️⃣ Get My Joined Clubs (GET /club/me/joined) [JWT]
  static const String myJoinedClubs = "$baseUrl/club/me/joined";

  /// 1️⃣7️⃣ Get My Admin Clubs (GET /club/me/admin) [JWT]
  static const String myAdminClubs = "$baseUrl/club/me/admin";

  /// 1️⃣8️⃣ Upload Club Image (POST /club/:clubId/image) [JWT + Admin]
  static String uploadClubImage(String clubId) => "$baseUrl/club/$clubId/image";

  static const String fetchClubByUserId = "$baseUrl/club/user/myclub";
  static const String createClubPost = "$baseUrl/club/posts";


// ===================== MEMBERSHIP APIs =====================

  /// 1️⃣9️⃣ Join Club (POST /membership/:clubId/join)
  static String joinClub(String clubId) => "$baseUrl/membership/$clubId/join";

  /// 2️⃣0️⃣ Request to Join Club (POST /membership/:clubId/request)
  static String requestToJoinClub(String clubId) =>
      "$baseUrl/membership/$clubId/request";

  /// 2️⃣1️⃣ Leave Club (POST /club/:clubId/leave)
  static String leaveClub(String clubId) => "$baseUrl/club/$clubId/leave";

  /// 2️⃣2️⃣ Accept Join Request (POST /club/request/:membershipId/accept)
  static String acceptJoinRequest(String membershipId) =>
      "$baseUrl/membership/request/$membershipId/accept";

  /// 2️⃣3️⃣ Reject Join Request (POST /club/request/:membershipId/reject)
  static String rejectJoinRequest(String membershipId) =>
      "$baseUrl/membership/request/$membershipId/reject";

  /// 2️⃣4️⃣ Promote Member to Admin (POST /club/member/:membershipId/promote)
  static String promoteToAdmin(String membershipId) =>
      "$baseUrl/club/member/$membershipId/promote";

  /// 2️⃣5️⃣ Remove Admin (POST /club/admin/:membershipId/remove)
  static String removeAdmin(String membershipId) =>
      "$baseUrl/club/admin/$membershipId/remove";

  /// 2️⃣6️⃣ Remove Member (POST /club/member/:membershipId/remove)
  static String removeMember(String membershipId) =>
      "$baseUrl/club/member/$membershipId/remove";

  /// 2️⃣7️⃣ Get Club Members (GET /club/:clubId/members)
  static String getClubMembers(String clubId) =>
      "$baseUrl/membership/$clubId/members";
  static String getClubAdmins(String clubId) =>
      "$baseUrl/membership/$clubId/admins";

  /// 2️⃣8️⃣ Get Pending Join Requests (GET /club/:clubId/requests/pending)
  static String getPendingJoinRequests(String clubId) =>
      "$baseUrl/membership/$clubId/requests/pending";

  /// 2️⃣9️⃣ Get Club Members Count (GET /club/:clubId/members/count)
  static String getClubMemberCount(String clubId) =>
      "$baseUrl/club/$clubId/members/count";

  /// 3️⃣0️⃣ Get My Role in Club (GET /club/:clubId/my-role)
  static String getMyRoleInClub(String clubId) =>
      "$baseUrl/club/$clubId/my-role";

  /// 3️⃣1️⃣ Get My Clubs (GET /club/my/clubs) [JWT]
  static const String getMyClubs = "$baseUrl/club/my/clubs";

// ===================== EVENTS APIs =====================

  /// 1️⃣ Create Event (POST /events)
  static const String createEvent = "$baseUrl/events";

  /// 2️⃣ Get Events (List / Filters) (GET /events)
  static String getEvents(String clubId) => "$baseUrl/events/club/$clubId";
  static String getEventsUpComing(String clubId) =>
      "$baseUrl/events/club/$clubId/upcoming";

  /// 3️⃣ Get Single Event by ID (GET /events/:eventId)
  static String getEventById(String eventId) => "$baseUrl/events/$eventId";

  /// 4️⃣ Update Event (PATCH /events/:eventId)
  static String updateEvent(String eventId) => "$baseUrl/events/$eventId";

  /// 5️⃣ Delete Event (DELETE /events/:eventId)
  static String deleteEvent(String eventId) => "$baseUrl/events/$eventId";

  /// 6️⃣ Publish Event (PATCH /events/:eventId/publish)
  static String publishEvent(String eventId) =>
      "$baseUrl/events/$eventId/publish";

// ===================== EVENT DAYS APIs =====================

  /// 1️⃣ Create Event Day (POST /events/:eventId/days)
  static String createEventDay(String eventId) =>
      "$baseUrl/events/$eventId/days";

  /// 2️⃣ Get All Days of an Event (GET /events/:eventId/days)
  static String getEventDaysByEvent(String eventId) =>
      "$baseUrl/events/$eventId/days";

  /// 3️⃣ Get Single Event Day (GET /events/:eventId/days/:dayId)
  static String getEventDayById(String eventId, String dayId) =>
      "$baseUrl/events/$eventId/days/$dayId";

  /// 4️⃣ Update Event Day (PATCH /events/:eventId/days/:dayId)
  static String updateEventDay(String eventId, String dayId) =>
      "$baseUrl/events/$eventId/days/$dayId";

  /// 5️⃣ Delete Event Day (DELETE /events/:eventId/days/:dayId)
  static String deleteEventDay(String eventId, String dayId) =>
      "$baseUrl/events/$eventId/days/$dayId";

  static String fetchSchedule(String eventId) =>
      "$baseUrl/events/activity/$eventId/schedule";
// ===================== CONNECTIONS / FRIENDS APIs =====================

  /// 1️⃣ Send Friend Request (POST /connections/request/:userId)
  static String sendFriendRequest(String userId) =>
      "$baseUrl/connections/request/$userId";

  /// 2️⃣ Accept Friend Request (POST /connections/accept/:requestId)
  static String acceptFriendRequest(String requestId) =>
      "$baseUrl/connections/accept/$requestId";

  /// 3️⃣ Reject Friend Request (POST /connections/reject/:requestId)
  static String rejectFriendRequest(String requestId) =>
      "$baseUrl/connections/reject/$requestId";

  /// 4️⃣ Cancel Sent Friend Request (DELETE /connections/cancel/:requestId)
  static String cancelFriendRequest(String requestId) =>
      "$baseUrl/connections/cancel/$requestId";

  /// 5️⃣ Remove Friend (DELETE /connections/remove/:userId)
  static String removeFriend(String userId) =>
      "$baseUrl/connections/remove/$userId";

  /// ===================== FRIEND LIST & REQUESTS =====================

  /// 6️⃣ Get My Friends (GET /connections/my)
  static const String getMyFriends = "$baseUrl/connections/myfriends";

  /// 7️⃣ Get Incoming Friend Requests (GET /connections/requests/incoming)
  static const String getIncomingRequests =
      "$baseUrl/connections/requests/incoming";

  /// 8️⃣ Get Outgoing Friend Requests (GET /connections/requests/outgoing)
  static const String getOutgoingRequests =
      "$baseUrl/connections/requests/outgoing";

  /// ===================== FRIEND STATUS & STATS =====================

  /// 9️⃣ Get Friendship Status with User (GET /connections/status/:userId)
  static String getFriendshipStatus(String userId) =>
      "$baseUrl/connections/status/$userId";

  /// 🔟 Get Friend Count of User (GET /connections/count/:userId)
  static String getFriendCount(String userId) =>
      "$baseUrl/connections/count/$userId";

// ===================== STORIES APIs =====================

  /// 1️⃣ Create Story (POST /story) [JWT]
  static const String storyurl = "$baseUrl/story";

  /// 2️⃣ Get Story by Story ID (GET /story/:storyId) [JWT]
  static String getStoryByStoryId(String storyId) =>
      "$baseUrl/stories/$storyId";

  /// 3️⃣ Get Stories by User ID (GET /story/user/:userId) [JWT]
  static String getStoryByUserId(String userId) =>
      "$baseUrl/story/user/$userId";

  /// 4️⃣ Update Story (PUT /story/:topicId) [JWT]
  static String updateStory(String topicId) => "$baseUrl/story/$topicId";

  /// 5️⃣ Patch Story (PATCH /story/:topicId) [JWT]
  static String patchStory(String topicId) => "$baseUrl/story/$topicId";

  /// 6️⃣ Delete Story (DELETE /story/:topicId) [JWT]
  static String deleteStory(String topicId) => "$baseUrl/story/$topicId";

  // ===================== FUTURE APIS =====================
  // static const String eventsUrl = "$baseUrl/events";
  // static const String membershipUrl = "$baseUrl/membership";
  // static const String connectionsUrl = "$baseUrl/connections";
}
