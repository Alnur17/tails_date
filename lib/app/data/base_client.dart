import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tails_date/app/modules/login/views/login_view.dart';

import '../../common/app_color/app_colors.dart';
import '../../common/app_constant/app_constant.dart';
import '../../common/helper/local_store.dart';
import '../../common/widgets/custom_snack_bar.dart';

class BaseClient {
  static getRequest({required String api, params, headers}) async {
    debugPrint("API Hit: $api");
    debugPrint("Header: $headers");

    http.Response response = await http.get(
      Uri.parse(api).replace(queryParameters: params),
      headers: headers,
    );
    return response;
  }

  static postRequest({required String api, body, headers}) async {
    debugPrint("API Hit: $api");
    debugPrint("body: $body");
    http.Response response = await http.post(
      Uri.parse(api),
      body: body,
      headers: headers,
    );
    debugPrint("<================= response ====== ${response.body} ===========>");
    return response;
  }

  static patchRequest({required String api, body, headers}) async {
    debugPrint("API Hit: $api");
    debugPrint("body: $body");
    http.Response response = await http.patch(
      Uri.parse(api),
      body: body,
      headers: headers,
    );
    return response;
  }

  static putRequest({required String api, body, headers}) async {
    debugPrint("API Hit: $api");
    debugPrint("body: $body");
    http.Response response = await http.put(
      Uri.parse(api),
      body: body,
      headers: headers,
    );
    return response;
  }

  static deleteRequest({required String api, body, headers}) async {
    debugPrint("API Hit: $api");
    debugPrint("body: $body");
    http.Response response = await http.delete(
      Uri.parse(api),
      headers: headers,
    );
    return response;
  }

  // Centralized response handler with auto logout
  static handleResponse(http.Response response) async {
    try {
      debugPrint('Response Code: ${response.statusCode}');
      debugPrint('Response Body: ${response.body}');

      // Handle success responses
      if (response.statusCode >= 200 && response.statusCode <= 210) {
        if (response.body.isNotEmpty) {
          return json.decode(response.body);
        } else {
          return response.body;
        }
      }

      // Automatically handle expired/invalid tokens
      else if (response.statusCode == 401) {
        String msg = "Session expired. Please log in again.";
        if (response.body.isNotEmpty) {
          try {
            final decoded = json.decode(response.body);
            msg = decoded['message'] ?? decoded['errors'] ?? msg;
          } catch (_) {}
        }

        // Show optional snack-bar for user feedback
        kSnackBar(message: msg, bgColor: AppColors.orange);

        // Auto logout
        await logout();
        throw msg;
      }

      // Handle known client-side errors
      else if (response.statusCode == 400 ||
          response.statusCode == 403 ||
          response.statusCode == 406 ||
          response.statusCode == 409 ||
          response.statusCode == 500) {
        final decoded = json.decode(response.body);
        final message = decoded['message'] ?? 'Something went wrong';
        kSnackBar(message: message.toString(), bgColor: AppColors.orange);
        throw message;
      }

      // Handle not found or other unexpected responses
      else {
        String msg = "Unexpected error (${response.statusCode})";
        if (response.body.isNotEmpty) {
          try {
            final decoded = jsonDecode(response.body);
            msg = decoded['message'] ?? msg;
          } catch (_) {}
        }
        throw msg;
      }
    } on SocketException {
      throw "No internet connection";
    } on FormatException catch (e) {
      debugPrint("Format error: $e");
      throw "Bad response format";
    } catch (e) {
      throw e.toString();
    }
  }

  static Future<void> logout() async {
    debugPrint('🔒 Logging out user...');
    await LocalStorage.removeData(key: AppConstant.token);
    Get.offAll(() => LoginView(), transition: Transition.fadeIn);
  }
}
