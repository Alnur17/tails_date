class Api {
  /// base url

  static const baseUrl = "http://172.252.13.83:5004/api/v1";
  static const socket = "http://172.252.13.83:4000";


  ///auth
  static const signup = "$baseUrl/auth/sign-up";//done
  static const login = "$baseUrl/auth/login"; //done
  static const forgotPassword = "$baseUrl/auth/send-otp"; //done
  static const otpVerify = "$baseUrl/auth/verify-otp"; //done
  static const verifyAccount = "$baseUrl/auth/verify-otp"; //done
  static const sendOtp = "$baseUrl/auth/send-otp"; //done
  static const resetPassword = "$baseUrl/auth/reset-forgotten-password"; //done
  static const changePassword = "$baseUrl/auth/create-new-password";//done

  ///Category Data
  static const getCategory = "$baseUrl/categories";//done

  ///guest
  static const guestPosts = "$baseUrl/posts/guest";//done

  /// posts
  static const String createPost = "$baseUrl/posts"; //done
  static const String allPosts = "$baseUrl/posts?limit=1000"; //done
  static String postsByUserId(String userId) => "$baseUrl/posts/author/$userId"; //done
  static const String myPosts = "$baseUrl/posts/my"; //done
  static String categoryPosts(categoryId) => "$baseUrl/posts/category/$categoryId"; //done
  static const String addOrRemoveReaction = "$baseUrl/posts/reactions"; //done
  static const String addNotInterested = "$baseUrl/posts/interests"; //done
  static String deletePost(postId) => "$baseUrl/posts/$postId"; //done
  static String editPost(postId) => "$baseUrl/posts/$postId"; //done
  static String removeImagesFromPost(postId) => "$baseUrl/posts/$postId"; //done

  ///profile
  static const String myProfile = "$baseUrl/users/profile"; // done
  static const String editProfile = "$baseUrl/users"; // done
  static const String profileOwnerGallery = "$baseUrl/users/add-to-owner-gallery"; //done
  static const String profilePetGallery = "$baseUrl/users/add-to-pet-gallery"; //done
  static const String removeProfileOwnerGallery = "$baseUrl/users/remove-from-owner-gallery"; //done
  static const String removeProfilePetGallery = "$baseUrl/users/remove-from-pet-gallery"; //done
  static const String conditionsPage = "$baseUrl/settings"; // done
  static const String deleteUser = "$baseUrl/auth/delete-account";
  static const  String cashOut = "$baseUrl/cashout-requests";
  static const  String cashOutStatus = "$baseUrl/cashout-requests/my";
  static const  String friends = "$baseUrl/friends";
  static const  String collections = "$baseUrl/collections";
  static const  String addOrRemoveCollections = "$baseUrl/collections";
  static String othersProfile(String userId) => "$baseUrl/users/single/$userId";

  ///Chats
  static const String createChat = "$baseUrl/chats"; //
  static const String allChat = "$baseUrl/chats"; //done
  static String getMessage(String userId) => "$baseUrl/messages/$userId"; //

  ///Story
  static const String createStory = "$baseUrl/stories"; //
  static const String allAuthorStory = "$baseUrl/stories/story-authors"; //
  //static const String getAllStory = "$baseUrl/stories"; //
  static String getAuthorStoriesById(String authId) => "$baseUrl/stories/$authId"; //

  ///Reels
  static const String createReels = "$baseUrl/reels"; //done
  static const String allReels = "$baseUrl/reels"; //done
  static  String otherReels(String userId) => "$baseUrl/reels/author/$userId"; //done
  static const String myReels = "$baseUrl/reels/my"; //done
  static String addOrRemoveReelsReaction(String reelsId) => "$baseUrl/reels/reactions/$reelsId"; //done


  ///Reports
  static const String reports = "$baseUrl/reports"; // done

  ///Other Pets
  static String petDetails(String petId) => "$baseUrl/pets/$petId"; // done
  static const String addNewPet = "$baseUrl/pets"; // done

  ///Star Plans
  static const String starPlans = "$baseUrl/star-plans"; //done
  static const String sendStars = "$baseUrl/posts/send-star"; //done
  static const String sendStarsFromStory = "$baseUrl/stories/send-star"; //done
  static const String sendStarsHistory = "$baseUrl/stars/sent"; //done
  static const String receivedStarsHistory = "$baseUrl/stars/received"; //done

  ///Notifications
  static const String notifications = "$baseUrl/notifications"; //done
  static const String addFriends = "$baseUrl/friends"; //done
  static const String friendsRequests = "$baseUrl/friends/requests"; //done
  static const String updateFriendsRequests = "$baseUrl/friends"; //done
  static String deleteSendRequests(sendReqId) => "$baseUrl/friends/$sendReqId"; //done
  static const String friendsSuggestions = "$baseUrl/friends/suggestions"; //done
  static String searchFriendsSuggestions(String quarry) => "$baseUrl/friends/suggestions?fields=$quarry"; //done

  ///Subscription Plan
  static const String subscriptionPlan = "$baseUrl/subscription-plans"; //done
  static const String myCurrentSubscriptionPlan = "$baseUrl/subscriptions/my"; //done
  static String buySubscriptionPlan(String subscriptionPlanId) => "$baseUrl/payments/create-session-for-subscription?planId=$subscriptionPlanId"; //done
  static String buyStarPlan(String starPlanId) => "$baseUrl/payments/create-session-for-star?starPlanId=$starPlanId"; //done
}
