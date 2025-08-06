// import 'dart:convert';
// import 'package:get/get.dart';
// import 'package:socket_io_client/socket_io_client.dart' as IO;
// import 'package:tails_date/common/app_constant/app_constant.dart';
// import 'package:tails_date/common/helper/local_store.dart';
// import 'package:tails_date/app/data/api.dart';
// import '../../app/modules/chats/model/message_body_model.dart';
//
// class SocketService extends GetxService {
//   late IO.Socket? _socket;
//   final RxList<MessageBodyDatum> messageBody = <MessageBodyDatum>[].obs;
//   final _updateLastMessage = Rx<Map<String, dynamic>>({});
//
//   SocketService() {
//     _connectSocket();
//   }
//
//   void _connectSocket() {
//     String? token = LocalStorage.getData(key: AppConstant.token);
//     String? userId = LocalStorage.getData(key: AppConstant.userId);
//
//     if (token != null && userId != null) {
//       try {
//         _socket = IO.io(Api.socket, <String, dynamic>{
//           'transports': ['websocket'],
//           'extraHeaders': {'token': 'Bearer $token'},
//           'autoConnect': false,
//         });
//
//         _socket?.connect();
//
//         _socket?.onConnect((_) {
//           print('✅ Connected to socket at ${DateTime.now()}');
//           _socket?.emit('join', userId);
//         });
//
//         _socket?.on('receive-message', (data) {
//           print('📨 Received socket message: $data');
//
//           try {
//             Map<String, dynamic> messageData;
//
//             if (data is String) {
//               messageData = jsonDecode(data);
//             } else if (data is Map<String, dynamic>) {
//               messageData = data;
//             } else {
//               print('⚠️ Unrecognized socket data format: $data');
//               return;
//             }
//
//             var fallbackId = messageData['_id'] ?? DateTime.now().millisecondsSinceEpoch.toString();
//
//             var message = MessageBodyDatum(
//               id: fallbackId,
//               sender: messageData['sender'],
//               receiver: messageData['receiver'],
//               chat: messageData['chat'],
//               text: messageData['text'],
//               seen: messageData['seen'],
//               createdAt: DateTime.tryParse(messageData['createdAt'] ?? '') ?? DateTime.now(),
//               updatedAt: DateTime.tryParse(messageData['updatedAt'] ?? '') ?? DateTime.now(),
//               v: messageData['__v'] ?? 0,
//             );
//
//             bool isDuplicate = messageBody.any((m) =>
//             m.text == message.text &&
//                 m.chat == message.chat &&
//                 m.sender == message.sender &&
//                 (m.createdAt?.difference(message.createdAt ?? DateTime.now()).inSeconds.abs() ?? 0) < 2
//             );
//
//             if (!isDuplicate) {
//               print('➕ Adding message to messageBody: ${message.text}');
//               messageBody.add(message);
//             } else {
//               print('⚠️ Duplicate message skipped: ${message.text}');
//             }
//
//             _updateLastMessage.value = {
//               'chatId': message.chat,
//               'message': message,
//             };
//           } catch (e) {
//             print('🚨 Error handling socket message: $e');
//           }
//         });
//
//         _socket?.onDisconnect((_) => print('❌ Disconnected at ${DateTime.now()}'));
//
//         _socket?.onConnectError((error) {
//           print('🚨 Connection error: $error');
//           Future.delayed(Duration(seconds: 5), () {
//             if (_socket?.connected == false) {
//               _socket?.connect();
//             }
//           });
//         });
//
//       } catch (e) {
//         print('🔥 Error initializing socket: $e');
//       }
//     } else {
//       print('🚫 Token or UserId is null, cannot connect to socket');
//     }
//   }
//
//   void sendMessage(String chatId, String messageText, String receiverId) {
//     if (_socket != null && _socket!.connected) {
//       String? userId = LocalStorage.getData(key: AppConstant.userId);
//       if (userId != null) {
//         final message = {
//           "receiver": receiverId,
//           "chat": chatId,
//           "text": messageText,
//           "sender": userId,
//           "seen": false,
//         };
//         _socket?.emit('send-message', message);
//       } else {
//         print('⚠️ UserId is null, cannot send message');
//       }
//     } else {
//       print('⚠️ Socket is not connected, cannot send message');
//     }
//   }
//
//   Rx<Map<String, dynamic>> get updateLastMessage => _updateLastMessage;
//
//   @override
//   void onClose() {
//     _socket?.disconnect();
//     _socket?.dispose();
//     super.onClose();
//   }
// }

 import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:tails_date/app/data/api.dart';
import 'package:tails_date/common/app_constant/app_constant.dart';
import 'package:tails_date/common/helper/local_store.dart';
import 'package:tails_date/app/modules/chats/model/message_body_model.dart';

class SocketService {
  late IO.Socket socket;
  //final String serverUrl = 'http://172.252.13.83:4000';
  void Function(MessageBodyDatum) onNewMessage;

  SocketService({required this.onNewMessage});

  Future<void> initialize() async {
    String token = LocalStorage.getData(key: AppConstant.token);
    socket = IO.io(Api.socket, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
      'extraHeaders': {'token': 'Bearer $token'},
    });

    // Connect to the socket (async operation)
    socket.connect();
    await Future.delayed(Duration(milliseconds: 500)); // Optional: Small delay to ensure connection

    socket.onConnect((_) {
      print('Socket connected');
    });

    socket.onDisconnect((_) {
      print('Socket disconnected');
    });

    socket.on('receive-message', (data) {
      try {
        final message = MessageBodyDatum.fromJson(data);
        onNewMessage(message);
      } catch (e) {
        print('Error parsing receive-message: $e');
      }
    });

    socket.onError((error) {
      print('Socket error: $error');
    });
  }

  void sendMessage(String chatId, String text, String receiverId) {
    String senderId = LocalStorage.getData(key: AppConstant.userId) ?? '';
    socket.emit('send-message', {
      'receiver': receiverId,
      'chat': chatId,
      'text': text,
    });
    print('Sent message: $chatId, $text to $receiverId');
  }

  void dispose() {
    socket.disconnect();
    socket.dispose();
  }
}