import 'package:equatable/equatable.dart';
import '../../domain/entities/chat_message.dart';
import '../../domain/entities/chat_room.dart';

enum ChatStatus { initial, loading, loaded, uploading, error }

class ChatState extends Equatable {
  final ChatStatus status;
  final List<ChatMessage> messages;
  final List<ChatRoom> rooms;
  final ChatRoom? currentRoom;
  final String? errorMessage;
  final String? selectedFileName;
  final String? selectedFileUrl;
  final String? extractedText;

  const ChatState({
    this.status = ChatStatus.initial,
    this.messages = const [],
    this.rooms = const [],
    this.currentRoom,
    this.errorMessage,
    this.selectedFileName,
    this.selectedFileUrl,
    this.extractedText,
  });

  ChatState copyWith({
    ChatStatus? status,
    List<ChatMessage>? messages,
    List<ChatRoom>? rooms,
    ChatRoom? currentRoom,
    String? errorMessage,
    String? selectedFileName,
    String? selectedFileUrl,
    String? extractedText,
    bool clearCurrentRoom = false,
  }) {
    return ChatState(
      status: status ?? this.status,
      messages: messages ?? this.messages,
      rooms: rooms ?? this.rooms,
      currentRoom: clearCurrentRoom ? null : (currentRoom ?? this.currentRoom),
      errorMessage: errorMessage ?? this.errorMessage,
      selectedFileName: selectedFileName ?? this.selectedFileName,
      selectedFileUrl: selectedFileUrl ?? this.selectedFileUrl,
      extractedText: extractedText ?? this.extractedText,
    );
  }

  @override
  List<Object?> get props => [
        status,
        messages,
        rooms,
        currentRoom,
        errorMessage,
        selectedFileName,
        selectedFileUrl,
        extractedText,
      ];
}
