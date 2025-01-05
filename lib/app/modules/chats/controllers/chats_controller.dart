import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ChatsController extends GetxController {
  var users = <dynamic>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    try {
      final response = await http.get(Uri.parse('https://randomuser.me/api/?results=10'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        users.value = data['results'];
      } else {
        Get.snackbar('Error', 'Failed to fetch users');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
}
