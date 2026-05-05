import 'dart:async';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/chat_message.dart';
import '../../domain/repositories/chat_repository.dart';
import 'chat_event.dart';
import 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepository _chatRepository;
  StreamSubscription? _messagesSubscription;
  StreamSubscription? _roomsSubscription;

  ChatBloc(this._chatRepository) : super(const ChatState()) {
    on<LoadRooms>(_onLoadRooms);
    on<RoomsUpdated>(_onRoomsUpdated);
    on<LoadMessages>(_onLoadMessages);
    on<MessagesUpdated>(_onMessagesUpdated);
    on<SendTextMessage>(_onSendTextMessage);
    on<PickAndUploadFile>(_onPickAndUploadFile);
    on<SwitchRoom>(_onSwitchRoom);
    on<StartNewChat>(_onStartNewChat);
    on<ClearFileSelection>(_onClearFileSelection);
  }

  void _onLoadRooms(LoadRooms event, Emitter<ChatState> emit) {
    _roomsSubscription?.cancel();
    _roomsSubscription = _chatRepository.getChatRooms(event.userId).listen((rooms) {
      add(RoomsUpdated(rooms));
    });
  }

  void _onRoomsUpdated(RoomsUpdated event, Emitter<ChatState> emit) {
    emit(state.copyWith(rooms: event.rooms));
  }

  void _onLoadMessages(LoadMessages event, Emitter<ChatState> emit) {
    _messagesSubscription?.cancel();
    _messagesSubscription = _chatRepository.getMessages(event.roomId).listen((messages) {
      add(MessagesUpdated(messages));
    });
  }

  void _onMessagesUpdated(MessagesUpdated event, Emitter<ChatState> emit) {
    emit(state.copyWith(status: ChatStatus.loaded, messages: event.messages));
  }

  Future<void> _onSendTextMessage(SendTextMessage event, Emitter<ChatState> emit) async {
    if (state.currentRoom == null) return;

    try {
      final userMessage = ChatMessage(
        id: '',
        text: event.text,
        senderId: event.userId,
        createdAt: DateTime.now(),
      );
      await _chatRepository.sendMessage(state.currentRoom!.id, userMessage);

      emit(state.copyWith(status: ChatStatus.loading));
      
      final aiResponseText = await _chatRepository.getAIResponse(
        event.text,
        context: state.extractedText,
      );

      final aiMessage = ChatMessage(
        id: '',
        text: aiResponseText,
        senderId: 'ai_tutor',
        createdAt: DateTime.now(),
      );
      
      await _chatRepository.sendMessage(state.currentRoom!.id, aiMessage);
      emit(state.copyWith(status: ChatStatus.loaded));
    } catch (e) {
      emit(state.copyWith(status: ChatStatus.error, errorMessage: 'Error de IA: $e'));
    }
  }

  Future<void> _onPickAndUploadFile(PickAndUploadFile event, Emitter<ChatState> emit) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx', 'jpg', 'png', 'txt'],
      );

      if (result != null && result.files.single.path != null) {
        emit(state.copyWith(status: ChatStatus.uploading));
        final file = File(result.files.single.path!);
        final fileName = result.files.single.name;
        
        // 1. Extraer texto
        final extractedText = await _chatRepository.extractTextFromFile(file);
        
        // 2. Subir archivo
        final fileUrl = await _chatRepository.uploadFile(file, event.userId);
        
        // 3. Crear SALA si no existe una activa o si queremos una nueva
        // Por defecto, creamos una nueva sala por cada archivo subido "nuevo"
        final room = await _chatRepository.createChatRoom(
          event.userId, 
          'Estudio: $fileName',
          fileUrl: fileUrl,
          fileName: fileName,
        );

        // 4. Actualizar estado y suscribirse a mensajes
        emit(state.copyWith(
          status: ChatStatus.loaded,
          currentRoom: room,
          selectedFileName: fileName,
          selectedFileUrl: fileUrl,
          extractedText: extractedText,
        ));

        add(LoadMessages(room.id));

        // 5. Enviar mensaje inicial de archivo y saludo IA
        await _chatRepository.sendFileMessage(room.id, event.userId, fileUrl, fileName);
        
        final aiMessage = ChatMessage(
          id: '',
          text: 'He recibido tu archivo "$fileName". He analizado su contenido y estoy listo para ayudarte. ¿Qué te gustaría saber?',
          senderId: 'ai_tutor',
          createdAt: DateTime.now(),
        );
        await _chatRepository.sendMessage(room.id, aiMessage);
      }
    } catch (e) {
      emit(state.copyWith(status: ChatStatus.error, errorMessage: e.toString()));
    }
  }

  void _onSwitchRoom(SwitchRoom event, Emitter<ChatState> emit) async {
    emit(state.copyWith(
      currentRoom: event.room,
      selectedFileName: event.room.lastFileName,
      selectedFileUrl: event.room.lastFileUrl,
      status: ChatStatus.loading,
    ));
    
    // Aquí podrías re-extraer el texto si fuera necesario, 
    // pero idealmente el texto extraído debería estar en la sala o caché.
    
    add(LoadMessages(event.room.id));
  }

  void _onStartNewChat(StartNewChat event, Emitter<ChatState> emit) {
    _messagesSubscription?.cancel();
    emit(state.copyWith(
      clearCurrentRoom: true,
      messages: [],
      selectedFileName: null,
      selectedFileUrl: null,
      extractedText: null,
      status: ChatStatus.initial,
    ));
  }

  void _onClearFileSelection(ClearFileSelection event, Emitter<ChatState> emit) {
    emit(state.copyWith(
      selectedFileName: null,
      selectedFileUrl: null,
      extractedText: null,
    ));
  }

  @override
  Future<void> close() {
    _messagesSubscription?.cancel();
    _roomsSubscription?.cancel();
    return super.close();
  }
}
