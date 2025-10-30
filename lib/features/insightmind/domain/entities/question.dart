// Struktur untuk Opsi Jawaban
class AnswerOption {
  final String label; // contoh: "Tidak Pernah", "Beberapa Hari"
  final int score; // contoh: 0, 3

  const AnswerOption({required this.label, required this.score});
}

// Struktur untuk Pertanyaan
class Question {
  final String id;
  final String text;
  final List<AnswerOption> options;

  const Question({
    required this.id,
    required this.text,
    required this.options,
  });
}

// Opsi Jawaban Standar
const _standardOptions = [
  AnswerOption(label: 'Tidak Pernah', score: 0),
  AnswerOption(label: 'Beberapa Hari', score: 1),
  AnswerOption(label: 'Lebih dari Separuh Hari', score: 2),
  AnswerOption(label: 'Hampir Setiap Hari', score: 3),
];


// Contoh 9 pertanyaan gaya PHQ/DASS (parafrase; bukan kutipan verbatim)
const defaultQuestions = <Question>[
  Question(
    id: 'q1',
    text: 'Dalam 2 minggu terakhir, seberapa sering Anda merasa sedih atau murung?',
    options: _standardOptions,
  ),
  Question(
    id: 'q2',
    text: 'Kesulitan menikmati hal-hal yang biasanya menyenangkan?',
    options: _standardOptions,
  ),
  
  // --- PERTANYAAN TAMBAHAN (Q3 - Q8) ---
  
  Question(
    id: 'q3',
    text: 'Mengalami masalah tidur; seperti sulit tidur, tidur terlalu banyak, atau bangun terlalu cepat?',
    options: _standardOptions,
  ),
  Question(
    id: 'q4',
    text: 'Merasa lelah atau kurang energi?',
    options: _standardOptions,
  ),
  Question(
    id: 'q5',
    text: 'Kesulitan makan, nafsu makan berkurang, atau makan berlebihan?',
    options: _standardOptions,
  ),
  Question(
    id: 'q6',
    text: 'Merasa tidak berharga atau merasa diri Anda mengecewakan?',
    options: _standardOptions,
  ),
  Question(
    id: 'q7',
    text: 'Sulit berkonsentrasi pada hal-hal, seperti membaca koran atau menonton TV?',
    options: _standardOptions,
  ),
  Question(
    id: 'q8',
    text: 'Bergerak atau berbicara sangat lambat sehingga orang lain memperhatikannya, atau gelisah/terlalu aktif?',
    options: _standardOptions,
  ),
  
  // --- PERTANYAAN AKHIR (Q9) ---
  
  Question(
    id: 'q9',
    text: 'Merasa sangat lelah/kurang energi dalam aktivitas sehari-hari?',
    options: _standardOptions,
  ),
];