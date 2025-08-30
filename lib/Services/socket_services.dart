
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:tails_date/common/app_constant/app_constant.dart';
import 'package:tails_date/common/helper/local_store.dart';


import '../../app/data/api.dart';

class SocketService extends GetxController {
  late IO.Socket _socket;

  RxBool isLoading = false.obs;

  final _messageList = <Map<String, dynamic>>[].obs;
  final _socketFriendList = <Map<String, dynamic>>[].obs;
  final _notificationsList = <Map<String, dynamic>>[].obs;

  RxList<Map<String, dynamic>> get messageList => _messageList;
  RxList<Map<String, dynamic>> get socketFriendList => _socketFriendList;
  RxList<Map<String, dynamic>> get notificationsList => _notificationsList;

  IO.Socket get socket => _socket;

  Future<SocketService> init() async {
    final token = LocalStorage.getData(key: AppConstant.token) ?? '';
    final userId = LocalStorage.getData(key: AppConstant.userId) ?? '';

    _socket = IO.io(Api.socket, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
      'extraHeaders': {'token': "Bearer $token"},
    });

    _socket.on('connect', (_) {
      print('✅ Connected to the server');
      _socket.emit("connection", userId);
    });

    _socket.onConnect((_) async {
      print('🟢 Socket connected');
      _socket.emit("connection", userId);
    });

    _socket.on('checking_notification', (data) {
      print('Check in data from socket');
      print(data);
    });

    _socket.onDisconnect((_) {
      print('🔴 Socket disconnected');
    });



    return this;
  }

  void disconnect() {
    _socket.disconnect();
  }
}