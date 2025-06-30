class Api {
  /// base url

  static const baseUrl = "http://172.252.13.83:5004/api/v1";
  //static const socket = "https://socket.thirdshotslot.co.uk/";


  ///auth
  static const signup = "$baseUrl/auth/sign-up";
  static const login = "$baseUrl/auth/login"; 
  static const forgotPassword = "$baseUrl/auth/send-otp"; 
  static const otpVerify = "$baseUrl/auth/verify-otp"; 
  static const verifyAccount = "$baseUrl/auth/verify-otp"; 
  static const sendOtp = "$baseUrl/auth/send-otp"; 
  static const resetPassword = "$baseUrl/auth/reset-forgotten-password"; 
  static const changePassword = "$baseUrl/auth/create-new-password"; 

  ///Category Data
  static const getCategory = "$baseUrl/categories";

  ///Trainers Data
  // static trainers(String? query) {
  //   return query?.isNotEmpty ?? false
  //       ? "$baseUrl/trainers?searchTerm=$query"
  //       : "$baseUrl/trainers";
  // } 


  /// get session details by id
 // static getSingleSession(String id) => "$baseUrl/sessions/$id";


}
