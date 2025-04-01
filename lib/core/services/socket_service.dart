import 'dart:async';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:flutter/foundation.dart';
import '../config/app_config.dart';
import 'shared_prefs.dart';

class SocketService {
  static final SocketService _instance = SocketService._internal();
  factory SocketService() => _instance;
  SocketService._internal();

  io.Socket? _socket;
  bool get isConnected => _socket?.connected ?? false;

  Future<void> initSocket() async {
    final token = SharedPrefs.getToken();
    if (token == null) return;

    try {
      _socket = io.io(
        AppConfig.socketUrl,
        io.OptionBuilder()
            .setTransports(['websocket'])
            .setAuth({'token': 'Bearer $token'})
            .enableAutoConnect()
            .enableReconnection()
            .setReconnectionAttempts(5)
            .setReconnectionDelay(1000)
            .build(),
      );

      _setupSocketListeners();
      _socket?.connect();
    } catch (e) {
      debugPrint('Socket initialization error: $e');
    }
  }

  void _setupSocketListeners() {
    _socket?.onConnect((_) {
      debugPrint('Socket connected: ${_socket?.id}');
    });

    _socket?.onConnectError((data) {
      debugPrint('Socket connection error: $data');
    });

    _socket?.onDisconnect((_) {
      debugPrint('Socket disconnected');
    });

    _socket?.onError((error) {
      debugPrint('Socket error: $error');
    });
  }

  void disconnect() {
    _socket?.disconnect();
    _socket = null;
  }

  void joinConversation(String conversationId) {
    if (!isConnected) return;
    _socket?.emit('join_conversation', {'conversationId': conversationId});
  }

  void leaveConversation(String conversationId) {
    if (!isConnected) return;
    _socket?.emit('leave_conversation', {'conversationId': conversationId});
  }

  void sendMessage(
    String conversationId,
    String content, {
    String contentType = 'text',
  }) {
    if (!isConnected) return;
    _socket?.emit('send_message', {
      'conversationId': conversationId,
      'content': content,
      'contentType': contentType,
    });
  }

  void sendImage(
    String conversationId,
    String imageData, {
    String caption = '',
  }) {
    if (!isConnected) return;
    _socket?.emit('send_image', {
      'conversationId': conversationId,
      'imageData': imageData,
      'caption': caption,
    });
  }

  void sendTypingStatus(String conversationId) {
    if (!isConnected) return;
    _socket?.emit('typing', {'conversationId': conversationId});
  }

  void stopTypingStatus(String conversationId) {
    if (!isConnected) return;
    _socket?.emit('stop_typing', {'conversationId': conversationId});
  }

  void onUserJoined(Function(Map<String, dynamic>) callback) {
    _socket?.on('user_joined', (data) => callback(data));
  }

  void onNewMessage(Function(Map<String, dynamic>) callback) {
    _socket?.on('new_message', (data) {
      if (data is Map<String, dynamic>) {
        callback(data);
      }
    });
  }

  void onTyping(Function(Map<String, dynamic>) callback) {
    _socket?.on('typing', (data) => callback(data));
  }

  void onStopTyping(Function(Map<String, dynamic>) callback) {
    _socket?.on('stop_typing', (data) => callback(data));
  }

  void offEvent(String event) {
    _socket?.off(event);
  }
}
