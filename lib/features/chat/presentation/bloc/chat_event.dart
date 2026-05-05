import 'package:equatable/equatable.dart';
import '../../domain/entities/chat_message.dart';
import '../../domain/entities/chat_room.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object?> get props => [];
}

class LoadRooms extends ChatEvent {
  final String userId;
  const LoadRooms(this.userId);

  @override
  List<Object?> get props => [userId];
}

class LoadMessages extends ChatEvent {
  final String roomId;
  const LoadMessages(this.roomId);

  @override
  List<Object?> get props => [roomId];
}

class SendTextMessage extends ChatEvent {
  final String text;
  final String userId;
  const SendTextMessage(this.text, this.userId);

  @override
  List<Object?> get props => [text, userId];
}

class PickAndUploadFile extends ChatEvent {
  final String userId;
  const PickAndUploadFile(this.userId);

  @override
  List<Object?> get props => [userId];
}

class MessagesUpdated extends ChatEvent {
  final List<ChatMessage> messages;
  const MessagesUpdated(this.messages);

  @override
  List<Object?> get props => [messages];
}

class RoomsUpdated extends ChatEvent {
  final List<ChatRoom> rooms;
  const RoomsUpdated(this.rooms);

  @override
  List<Object?> get props => [rooms];
}

class SwitchRoom extends ChatEvent {
  final ChatRoom room;
  const SwitchRoom(this.room);

  @override
  List<Object?> get props => [room];
}

class StartNewChat extends ChatEvent {}

class ClearFileSelection extends ChatEvent {}
