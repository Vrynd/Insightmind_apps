  import 'package:flutter_riverpod/flutter_riverpod.dart';
  import 'package:insightmind_app/features/insightmind/data/local/chat_dataset.dart';
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
    final _uuid = const Uuid();

    @override
    ChatState build() {
      // Initialize with welcome message
      return ChatState(
        messages: [
          ChatMessage(
            id: _uuid.v4(),
            text: "Halo! Saya adalah asisten kesehatan mental Anda. Saya siap mendengarkan cerita Anda secara privat dan offline. Ada yang bisa saya bantu?",
            isUser: false,
            timestamp: DateTime.now(),
          )
        ],
      );
    }

    Future<void> sendMessage(String text) async {
      if (text.trim().isEmpty) return;

      // 1. Add User Message immediately
      final userMessage = ChatMessage(
        id: _uuid.v4(),
        text: text,
        isUser: true,
        timestamp: DateTime.now(),
      );

      state = state.copyWith(
        messages: [...state.messages, userMessage],
        isLoading: true,
        error: null,
      );

      try {
        // 2. Simulate AI "Thinking" Delay
        // Delay antara 1-2 detik agar terasa natural
        await Future.delayed(Duration(milliseconds: 1000 + (text.length * 20).clamp(0, 1000)));

        // 3. Get Response from Local Dataset
        final botResponse = ChatDataset.getResponse(text);

        final botMessage = ChatMessage(
          id: _uuid.v4(),
          text: botResponse,
          isUser: false,
          timestamp: DateTime.now(),
        );

        // 4. Update UI with Bot Message
        state = state.copyWith(
          messages: [...state.messages, botMessage],
          isLoading: false,
        );
      } catch (e) {
        final errorMessage = ChatMessage(
          id: _uuid.v4(),
          text: "Maaf, sistem sedang mengalami gangguan.",
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
