import 'package:flutter_riverpod/flutter_riverpod.dart';
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

  ChatState({this.messages = const [], this.isLoading = false, this.error});

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
    return ChatState(
      messages: [
        ChatMessage(
          id: _uuid.v4(),
          text:
              "Halo! Saya adalah asisten kesehatan mental Anda. Ada yang bisa saya bantu hari ini?",
          isUser: false,
          timestamp: DateTime.now(),
        ),
      ],
    );
  }

  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) return;

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

    // Simulate network delay for local "AI"
    await Future.delayed(const Duration(seconds: 1));

    try {
      final String botContent = _getLocalResponse(text);

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
        text: "Maaf, terjadi kesalahan internal.",
        isUser: false,
        timestamp: DateTime.now(),
      );

      state = state.copyWith(
        messages: [...state.messages, errorMessage],
        isLoading: false,
      );
    }
  }

  String _getLocalResponse(String input) {
    final lowerInput = input.toLowerCase();

    // 1. Emergency/Crisis
    if (lowerInput.contains('bunuh diri') ||
        lowerInput.contains('akhiri hidup') ||
        lowerInput.contains('mati saja')) {
      return "Saya sangat peduli dengan keselamatanmu. Jika kamu merasa dalam bahaya besar, tolong hubungi layanan darurat atau hotline kesehatan mental (Halo Kemenkes 1500-567). Kamu tidak sendirian, dan ada bantuan yang tersedia.";
    }

    // 2. Anxiety & Panic
    if (lowerInput.contains('cemas') ||
        lowerInput.contains('takut') ||
        lowerInput.contains('panik') ||
        lowerInput.contains('deg-degan')) {
      return "Tarik napas dalam-dalam (4 detik), tahan (4 detik), dan buang perlahan (4 detik). Kecemasan ini adalah respon tubuh yang valid, namun ingatlah bahwa ini akan berlalu. Apa yang paling membebanimu saat ini?";
    }

    // 3. Sadness & Depression
    if (lowerInput.contains('sedih') ||
        lowerInput.contains('nangis') ||
        lowerInput.contains('kecewa') ||
        lowerInput.contains('putus asa') ||
        lowerInput.contains('hampa')) {
      return "Aku di sini bersamamu. Merasa sedih atau hampa adalah bagian dari proses manusiawi. Ceritakan lebih lanjut, apa yang terjadi? Mengeluarkan perasaan bisa membantu meringankan beban.";
    }

    // 4. Sleep & Insomnia
    if (lowerInput.contains('tidur') ||
        lowerInput.contains('insomnia') ||
        lowerInput.contains('begadang') ||
        lowerInput.contains('ngantuk')) {
      return "Kualitas tidur sangat berpengaruh pada kesehatan mental. Cobalah kurangi penggunaan gadget 1 jam sebelum tidur dan buat suasana kamar senyaman mungkin. Apakah ada pikiran yang mengganggu tidurmu?";
    }

    // 5. Relationships & Social
    if (lowerInput.contains('putus') ||
        lowerInput.contains('patah hati') ||
        lowerInput.contains('pacar') ||
        lowerInput.contains('teman') ||
        lowerInput.contains('kesepian') ||
        lowerInput.contains('sendiri')) {
      return "Masalah hubungan atau rasa kesepian memang menyakitkan. Ingatlah bahwa nilai dirimu tidak ditentukan oleh orang lain. Apa yang kamu rasakan saat ini mengenai hubungan sosialmu?";
    }

    // 6. Stress & Work/School
    if (lowerInput.contains('stres') ||
        lowerInput.contains('lelah') ||
        lowerInput.contains('capek') ||
        lowerInput.contains('kerja') ||
        lowerInput.contains('tugas') ||
        lowerInput.contains('kuliah')) {
      return "Kamu sudah berusaha sangat keras. Berikan dirimu izin untuk istirahat sejenak. Apa yang paling membuatmu merasa terbebani akhir-akhir ini?";
    }

    // 7. Motivation & Self-Esteem
    if (lowerInput.contains('gagal') ||
        lowerInput.contains('bodoh') ||
        lowerInput.contains('jelek') ||
        lowerInput.contains('malas') ||
        lowerInput.contains('motivasi')) {
      return "Jangan terlalu keras pada dirimu sendiri. Setiap orang memiliki ritme dan tantangannya masing-masing. Fokuslah pada satu langkah kecil hari ini. Apa satu hal kecil yang ingin kamu capai?";
    }

    // 8. Physical Health & Exercise
    if (lowerInput.contains('olahraga') ||
        lowerInput.contains('makan') ||
        lowerInput.contains('sehat') ||
        lowerInput.contains('tubuh')) {
      return "Koneksi antara tubuh dan pikiran itu nyata. Olahraga ringan atau makanan bernutrisi bisa membantu memperbaiki suasana hati. Sudahkah kamu minum cukup air hari ini?";
    }

    // 9. Greetings & Gratitude
    if (lowerInput.contains('halo') ||
        lowerInput.contains('hi') ||
        lowerInput.contains('apa kabar')) {
      return "Halo! Kabar saya baik sebagai asisten digital. Bagaimana denganmu? Apa yang sedang kamu rasakan hari ini?";
    }
    if (lowerInput.contains('terima kasih') ||
        lowerInput.contains('makasih') ||
        lowerInput.contains('thanks')) {
      return "Sama-sama! Senang bisa menemanimu. Jika ada hal lain yang ingin diceritakan, aku selalu di sini.";
    }

    return "Terima kasih sudah berbagi. Bisakah kamu bercerita lebih spesifik tentang apa yang kamu rasakan? Aku ingin memahami perspektifmu lebih dalam.";
  }
}

final chatProvider = NotifierProvider<ChatNotifier, ChatState>(
  ChatNotifier.new,
);
