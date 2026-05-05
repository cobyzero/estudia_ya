import 'dart:io';
import '../entities/chat_message.dart';
import '../entities/chat_room.dart';

abstract class ChatRepository {
  Stream<List<ChatRoom>> getChatRooms(String userId);
  Future<ChatRoom> createChatRoom(String userId, String title, {String? fileUrl, String? fileName});
  Stream<List<ChatMessage>> getMessages(String roomId);
  Future<void> sendMessage(String roomId, ChatMessage message);
  Future<String> uploadFile(File file, String userId);
  Future<void> sendFileMessage(String roomId, String userId, String fileUrl, String fileName);
  Future<String> getAIResponse(String prompt, {String? context});
  Future<String> extractTextFromFile(File file);
}
