import 'package:equatable/equatable.dart';

enum MessageType { text, file }

class ChatMessage extends Equatable {
  final String id;
  final String text;
  final String senderId;
  final DateTime createdAt;
  final MessageType type;
  final String? fileUrl;
  final String? fileName;

  const ChatMessage({
    required this.id,
    required this.text,
    required this.senderId,
    required this.createdAt,
    this.type = MessageType.text,
    this.fileUrl,
    this.fileName,
  });

  @override
  List<Object?> get props => [id, text, senderId, createdAt, type, fileUrl, fileName];
}
