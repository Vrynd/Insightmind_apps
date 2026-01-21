import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:insightmind_app/config/api_config.dart';
import 'package:uuid/uuid.dart';

class ChatMessage {
  final String id;
  final String text;
  final bool isUser;
  final DateTime timestamp;

  ChatMessage({
    required this.id,
    required this.text,
    required this.isUser,
    required this.timestamp,
  });
}

class ChatState {
  final List<ChatMessage> messages;
  final bool isLoading;
  final String? error;

  ChatState({
    this.messages = const [],
    this.isLoading = false,
    this.error,
  });

  ChatState copyWith({
    List<ChatMessage>? messages,
    bool? isLoading,
    String? error,
  }) {
    return ChatState(
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class ChatNotifier extends Notifier<ChatState> {
  GenerativeModel? _model;
  ChatSession? _chatSession;
  final _uuid = const Uuid();

  @override
  ChatState build() {
    try {
      _model = GenerativeModel(
        model: 'gemini-2.5-flash',
        apiKey: ApiConfig.geminiApiKey,
      );
      _chatSession = _model?.startChat();
      
      return ChatState(
        messages: [
          ChatMessage(
            id: _uuid.v4(),
            text: "Halo! Saya adalah asisten kesehatan mental Anda. Ada yang bisa saya bantu hari ini?",
            isUser: false,
            timestamp: DateTime.now(),
          )
        ],
      );
    } catch (e) {
      return ChatState(error: "Gagal menginisialisasi AI: $e");
    }
  }

  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) return;
    
    if (_chatSession == null) {
       state = state.copyWith(error: "Sesi AI belum siap.");
       return;
    }

    final userMessage = ChatMessage(
      id: _uuid.v4(),
      text: text,
      isUser: true,
      timestamp: DateTime.now(),
    );

    // Update state to show user message and loading
    state = state.copyWith(
      messages: [...state.messages, userMessage],
      isLoading: true,
      error: null,
    );

    try {
      final response = await _chatSession!.sendMessage(Content.text(text));
      
      final botContent = response.text;
      
      if (botContent == null) {
        throw Exception("Respon kosong dari AI");
      }

      final botMessage = ChatMessage(
        id: _uuid.v4(),
        text: botContent,
        isUser: false,
        timestamp: DateTime.now(),
      );

      state = state.copyWith(
        messages: [...state.messages, botMessage],
        isLoading: false,
      );
    } catch (e) {
      final errorMessage = ChatMessage(
        id: _uuid.v4(),
        text: "Maaf, terjadi kesalahan: $e",
        isUser: false,
        timestamp: DateTime.now(),
      );
      
      state = state.copyWith(
        messages: [...state.messages, errorMessage],
        isLoading: false,
        error: e.toString(),
      );
    }
  }
}

final chatProvider = NotifierProvider<ChatNotifier, ChatState>(ChatNotifier.new);
