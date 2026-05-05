import 'package:equatable/equatable.dart';

class ChatRoom extends Equatable {
  final String id;
  final String userId;
  final String title;
  final DateTime createdAt;
  final String? lastFileUrl;
  final String? lastFileName;

  const ChatRoom({
    required this.id,
    required this.userId,
    required this.title,
    required this.createdAt,
    this.lastFileUrl,
    this.lastFileName,
  });

  @override
  List<Object?> get props => [id, userId, title, createdAt, lastFileUrl, lastFileName];
}
