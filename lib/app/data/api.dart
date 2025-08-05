class Api {
  /// base url

  static const baseUrl = "http://172.252.13.83:5004/api/v1";
  //static const socket = "https://socket.thirdshotslot.co.uk/";


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

  /// posts
  static const String createPost = "$baseUrl/posts"; //done
  static const String allPosts = "$baseUrl/posts"; //done
  static const String myPosts = "$baseUrl/posts/my"; //done
  static String categoryPosts(categoryId) => "$baseUrl/posts/category/$categoryId"; //done
  static const String addOrRemoveReaction = "$baseUrl/posts/reactions"; //done
  static const String addNotInterested = "$baseUrl/posts/interests"; //done
  static String deletePost(postId) => "$baseUrl/posts/$postId"; //done

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
  static const  String friends = "$baseUrl/friends";
  static const  String collections = "$baseUrl/collections";
  static const  String addOrRemoveCollections = "$baseUrl/collections";

  ///Chats
  static const String createChat = "$baseUrl/chats"; //
  static const String allChat = "$baseUrl/chats"; //done
  static String getMessage(String userId) => "$baseUrl/messages/$userId"; //

  ///Story
  static const String createStory = "$baseUrl/stories"; //
  static const String myStory = "$baseUrl/stories/my"; //
  static const String getAllStory = "$baseUrl/stories"; //
  static String getSingleStory(String storyId) => "$baseUrl/stories/$storyId"; //

  ///Reels
  static const String createReels = "$baseUrl/reels"; //done
  static const String allReels = "$baseUrl/reels"; //done
  static const String myReels = "$baseUrl/reels/my"; //done


  ///Reports
  static const String reports = "$baseUrl/reports"; // done

  ///Star Plans
  static const String starPlans = "$baseUrl/star-plans"; //done
  static const String sendStars = "$baseUrl/posts/send-star"; //done

  ///Notifications
  static const String notifications = "$baseUrl/notifications"; //done
  static const String addFriends = "$baseUrl/friends"; //done
  static const String friendsRequests = "$baseUrl/friends/requests"; //done
  static const String updateFriendsRequests = "$baseUrl/friends"; //done
  static const String friendsSuggestions = "$baseUrl/friends/suggestions"; //done

  ///Subscription Plan
  static const String subscriptionPlan = "$baseUrl/subscription-plans"; //done
  static const String myCurrentSubscriptionPlan = "$baseUrl/subscriptions/my"; //done
  static String buySubscriptionPlan(String subscriptionPlanId) => "$baseUrl/payments/create-session-for-subscription?planId=$subscriptionPlanId"; //done
  static String buyStarPlan(String starPlanId) => "$baseUrl/payments/create-session-for-star?starPlanId=$starPlanId"; //done
}
