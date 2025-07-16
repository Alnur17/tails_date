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
  static const String allPosts = "$baseUrl/posts"; //done
  static String categoryPosts(categoryId) => "$baseUrl/posts/category/$categoryId"; //done

  ///profile
  static const String myProfile = "$baseUrl/users/profile"; // done
  static const String profileOwnerGallery = "$baseUrl/users/add-to-owner-gallery"; //done
  static const String profilePetGallery = "$baseUrl/users/add-to-pet-gallery"; //done
  static const String removeProfileOwnerGallery = "$baseUrl/users/remove-from-owner-gallery"; //done
  static const String removeProfilePetGallery = "$baseUrl/users/remove-from-pet-gallery"; //done
  static const String conditionsPage = "$baseUrl/settings"; // done
  static const String deleteUser = "$baseUrl/auth/delete-account";
  static const  String cashOut = "$baseUrl/cashout-requests";
  static const  String friends = "$baseUrl/friends";
  static const  String collections = "$baseUrl/collections";

///Reels
  static const String allReels = "$baseUrl/reels"; //done
  static const String myReels = "$baseUrl/reels/my"; //

  ///Reports
  static const String reports = "$baseUrl/reports"; // done

  ///Star Plans
  static const String starPlans = "$baseUrl/star-plans"; //done

  ///Subscription Plan
  static const String subscriptionPlan = "$baseUrl/subscription-plans"; //done
  static const String myCurrentSubscriptionPlan = "$baseUrl/subscriptions/my"; //done
  static String buySubscriptionPlan(String subscriptionPlanId) => "$baseUrl/payments/create-session-for-subscription?planId=$subscriptionPlanId"; //done
  static String buyStarPlan(String starPlanId) => "$baseUrl/payments/create-session-for-star?starPlanId=$starPlanId"; //done
}
