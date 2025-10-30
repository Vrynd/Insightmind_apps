import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:insightmind_app/features/insightmind/domain/entities/question.dart';
// Import defaultQuestions dan Question

// State: map id pertanyaan -> skor (0..3)
class QuestionnaireState {
  final Map<String, int> answers;
  
  const QuestionnaireState({this.answers = const {}});

  QuestionnaireState copyWith({Map<String, int>? answers}) {
    return QuestionnaireState(answers: answers ?? this.answers);
  }

  // Apakah semua pertanyaan sudah dijawab?
  bool get isComplete => answers.length >= defaultQuestions.length;

  // Hitung total skor dari semua jawaban
  int get totalScore => answers.values.fold(0, (a, b) => a + b);
}

class QuestionnaireNotifier extends StateNotifier<QuestionnaireState> {
  QuestionnaireNotifier() : super(const QuestionnaireState());

  // Method untuk memilih/mengubah jawaban suatu pertanyaan
  void selectAnswer({required String questionId, required int score}) {
    final newMap = Map<String, int>.from(state.answers);
    newMap[questionId] = score;
    state = state.copyWith(answers: newMap);
  }

  // Method untuk mereset semua jawaban
  void reset() {
    state = const QuestionnaireState();
  }
}

// Provider daftar pertanyaan (konstan)
final questionsProvider = Provider<List<Question>>((ref) {
  // Asumsi defaultQuestions diimpor dari entities/question.dart
  return defaultQuestions;
});

// Provider state form
final questionnaireProvider = 
    StateNotifierProvider<QuestionnaireNotifier, QuestionnaireState>((ref) {
  return QuestionnaireNotifier();
});