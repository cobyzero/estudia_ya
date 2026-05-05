import 'dart:io';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import '../../domain/entities/chat_message.dart';
import '../../domain/entities/chat_room.dart';
import '../../domain/repositories/chat_repository.dart';
import '../datasources/ai_remote_data_source.dart';
import '../datasources/chat_remote_data_source.dart';
import '../models/chat_message_model.dart';
import '../models/chat_room_model.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource remoteDataSource;
  final AIRemoteDataSource aiRemoteDataSource;

  ChatRepositoryImpl({
    required this.remoteDataSource,
    required this.aiRemoteDataSource,
  });

  @override
  Stream<List<ChatRoom>> getChatRooms(String userId) {
    return remoteDataSource.getChatRooms(userId);
  }

  @override
  Future<ChatRoom> createChatRoom(String userId, String title, {String? fileUrl, String? fileName}) async {
    final room = ChatRoomModel(
      id: '',
      userId: userId,
      title: title,
      createdAt: DateTime.now(),
      lastFileUrl: fileUrl,
      lastFileName: fileName,
    );
    return await remoteDataSource.createChatRoom(room);
  }

  @override
  Stream<List<ChatMessage>> getMessages(String roomId) {
    return remoteDataSource.getMessages(roomId);
  }

  @override
  Future<void> sendMessage(String roomId, ChatMessage message) async {
    final model = ChatMessageModel(
      id: message.id,
      text: message.text,
      senderId: message.senderId,
      createdAt: message.createdAt,
      type: message.type,
      fileUrl: message.fileUrl,
      fileName: message.fileName,
    );
    await remoteDataSource.sendMessage(roomId, model);
  }

  @override
  Future<String> uploadFile(File file, String userId) async {
    return await remoteDataSource.uploadFile(file, userId);
  }

  @override
  Future<void> sendFileMessage(String roomId, String userId, String fileUrl, String fileName) async {
    final message = ChatMessageModel(
      id: '',
      text: 'He subido un archivo: $fileName',
      senderId: userId,
      createdAt: DateTime.now(),
      type: MessageType.file,
      fileUrl: fileUrl,
      fileName: fileName,
    );
    await remoteDataSource.sendMessage(roomId, message);
  }

  @override
  Future<String> getAIResponse(String prompt, {String? context}) async {
    return await aiRemoteDataSource.getAIResponse(prompt, context: context);
  }

  @override
  Future<String> extractTextFromFile(File file) async {
    try {
      final String extension = file.path.split('.').last.toLowerCase();
      if (extension == 'pdf') {
        final PdfDocument document = PdfDocument(inputBytes: file.readAsBytesSync());
        final String text = PdfTextExtractor(document).extractText();
        document.dispose();
        return text;
      } else {
        return await file.readAsString();
      }
    } catch (e) {
      return "No se pudo extraer el texto del archivo: $e";
    }
  }
}
