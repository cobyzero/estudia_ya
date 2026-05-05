import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../models/chat_message_model.dart';
import '../models/chat_room_model.dart';

abstract class ChatRemoteDataSource {
  Stream<List<ChatRoomModel>> getChatRooms(String userId);
  Future<ChatRoomModel> createChatRoom(ChatRoomModel room);
  Stream<List<ChatMessageModel>> getMessages(String roomId);
  Future<void> sendMessage(String roomId, ChatMessageModel message);
  Future<String> uploadFile(File file, String userId);
}

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;

  ChatRemoteDataSourceImpl(this._firestore, this._storage);

  @override
  Stream<List<ChatRoomModel>> getChatRooms(String userId) {
    return _firestore
        .collection('chat_rooms')
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => ChatRoomModel.fromFirestore(doc)).toList();
    });
  }

  @override
  Future<ChatRoomModel> createChatRoom(ChatRoomModel room) async {
    final docRef = await _firestore.collection('chat_rooms').add(room.toFirestore());
    final doc = await docRef.get();
    return ChatRoomModel.fromFirestore(doc);
  }

  @override
  Stream<List<ChatMessageModel>> getMessages(String roomId) {
    return _firestore
        .collection('chat_rooms')
        .doc(roomId)
        .collection('messages')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => ChatMessageModel.fromFirestore(doc)).toList();
    });
  }

  @override
  Future<void> sendMessage(String roomId, ChatMessageModel message) async {
    await _firestore
        .collection('chat_rooms')
        .doc(roomId)
        .collection('messages')
        .add(message.toFirestore());
  }

  @override
  Future<String> uploadFile(File file, String userId) async {
    final fileName = '${DateTime.now().millisecondsSinceEpoch}_${file.path.split('/').last}';
    final ref = _storage.ref().child('users').child(userId).child('files').child(fileName);
    final uploadTask = await ref.putFile(file);
    return await uploadTask.ref.getDownloadURL();
  }
}
