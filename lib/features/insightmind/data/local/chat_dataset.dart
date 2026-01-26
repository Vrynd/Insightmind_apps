import 'dart:math';

/// Struktur data untuk Knowledge Base
class KnowledgeEntry {
  final List<String> keywords; // Kata kunci yang memicu respon ini
  final List<String> responses; // Pilihan jawaban (dipilih secara acak agar natural)
  final String category; // Kategori topik

  KnowledgeEntry({
    required this.keywords,
    required this.responses,
    required this.category,
  });
}

/// Dataset Kesehatan Mental Offline
/// Berisi pengetahuan komprehensif untuk "Consultation Chat" tanpa API eksternal
class ChatDataset {
  
  // ========================================================================
  // ENGINE LOGIC
  // ========================================================================
  
  // Mencari respon terbaik berdasarkan input user
  static String getResponse(String input) {
    String lowerInput = input.toLowerCase();
    
    // 1. Cek Kata Kunci Darurat (Prioritas Utama)
    if (_containsAny(lowerInput, ['bunuh diri', 'mati saja', 'akhiri hidup', 'gantung diri', 'lukai diri', 'silet tangan'])) {
      return _emergencyResponse;
    }

    // 2. Scoring System untuk mencari match terbaik
    KnowledgeEntry? bestMatch;
    int highestScore = 0;

    for (var entry in _knowledgeBase) {
      int score = 0;
      for (var keyword in entry.keywords) {
        if (lowerInput.contains(keyword.toLowerCase())) {
          // Keyword yang lebih panjang diberi bobot lebih tinggi karena lebih spesifik
          score += 1 + (keyword.length ~/ 3); 
        }
      }
      
      if (score > highestScore) {
        highestScore = score;
        bestMatch = entry;
      }
    }

    // 3. Jika score cukup tinggi, kembalikan respon
    if (highestScore > 0 && bestMatch != null) {
      final random = Random();
      return bestMatch.responses[random.nextInt(bestMatch.responses.length)];
    }

    // 4. Jika tidak ada match, kembalikan respon fallback
    final random = Random();
    return _fallbackResponses[random.nextInt(_fallbackResponses.length)];
  }

  static bool _containsAny(String input, List<String> keywords) {
    for (var k in keywords) {
      if (input.contains(k)) return true;
    }
    return false;
  }

  // ========================================================================
  // DATASET (THE "TRAINING" DATA)
  // ========================================================================

  static const String _emergencyResponse = 
      "Saya sangat prihatin mendengar perasaan Anda saat ini. \n\n"
      "Jika Anda merasa dalam bahaya atau ingin melukai diri sendiri, tolong SEGERA hubungi bantuan profesional atau orang terdekat.\n\n"
      "🚨 Nomor Darurat Indonesia: 119\n"
      "🚨 Hotline Kesehatan Jiwa (Kemenkes): 1-500-454\n\n"
      "Anda tidak sendirian. Tolong bertahanlah, bantuan selalu ada.";

  static final List<String> _fallbackResponses = [
    "Saya mengerti. Bisa ceritakan lebih lanjut tentang apa yang Anda rasakan?",
    "Hmm, saya mendengarkan. Bagaimana hal itu mempengaruhi keseharian Anda?",
    "Terima kasih sudah berbagi. Apakah ada hal lain yang membuat Anda merasa seperti ini?",
    "Perasaan itu valid. Apa yang biasanya membantu Anda ketika merasa seperti ini?",
    "Saya di sini untuk mendengarkan. Lanjutkan ceritanya jika Anda nyaman."
  ];

  static final List<KnowledgeEntry> _knowledgeBase = [
    // --- GREETINGS & INTRO ---
    KnowledgeEntry(
      category: 'greeting',
      keywords: ['halo', 'hi', 'hai', 'pagi', 'siang', 'sore', 'malam', 'assalamualaikum'],
      responses: [
        "Halo! Saya InsightMind Assistant. Apa yang sedang Anda pikiran atau rasakan hari ini?",
        "Hai! Senang bertemu Anda. Bagaimana perasaan Anda hari ini?",
        "Halo, saya di sini untuk mendengarkan. Ada yang ingin diceritakan?",
      ],
    ),
    KnowledgeEntry(
      category: 'identity',
      keywords: ['siapa kamu', 'apa kamu', 'asisten', 'bot', 'robot'],
      responses: [
        "Saya adalah asisten kesehatan mental virtual Anda. Meskipun saya sistem cerdas offline, saya dilatih untuk mendengarkan dan memberikan saran psikologis dasar.",
        "Saya teman virtual Anda di InsightMind. Tugas saya adalah menemani Anda memproses perasaan dan pikiran.",
      ],
    ),
    KnowledgeEntry(
      category: 'thank_you',
      keywords: ['makasih', 'terima kasih', 'thanks', 'tq', 'membantu'],
      responses: [
        "Sama-sama! Senang bisa membantu Anda.",
        "Terima kasih kembali. Ingat, saya selalu di sini jika Anda butuh teman bicara.",
        "Sama-sama. Jaga diri Anda baik-baik, ya.",
      ],
    ),

    // --- ANXIETY (KECEMASAN) ---
    KnowledgeEntry(
      category: 'anxiety_general',
      keywords: ['cemas', 'khawatir', 'takut', 'gelisah', 'was-was', 'deg-degan', 'gugup'],
      responses: [
        "Rasa cemas itu wajar, tapi pasti tidak nyaman ya. Coba teknik 'Grounding 5-4-3-2-1': Sebutkan 5 hal yang bisa Anda lihat, 4 diraba, 3 didengar, 2 dicium, dan 1 dirasa. Ini membantu menenangkan pikiran.",
        "Tarik napas dalam-dalam... Tahan sebentar... Lalu hembuskan perlahan. Kecemasan seringkali adalah cara tubuh bersiaga. Apakah ada pemicu spesifik yang membuat Anda cemas?",
        "Saat cemas, otak kita sering memikirkan hal terburuk. Coba tanya pada diri sendiri: 'Apakah bukti ketakutan saya ini nyata?'",
      ],
    ),
    KnowledgeEntry(
      category: 'panic_attack',
      keywords: ['panik', 'sesak napas', 'jantung berdebar', 'gemetar', 'serangan panik'],
      responses: [
        "Ini terdengar seperti serangan panik. Anda aman. Ini akan berlalu. Fokus pada napas Anda sekarang. Tarik napas 4 detik, tahan 4 detik, lepaskan 4 detik. Lakukan perlahan.",
        "Anda tidak dalam bahaya fisik, meskipun rasanya menakutkan. Duduklah, rasakan kaki Anda menyentuh lantai. Anda memegang kendali.",
      ],
    ),

    // --- DEPRESSION (DEPRESI) ---
    KnowledgeEntry(
      category: 'sadness',
      keywords: ['sedih', 'nangis', 'menangis', 'duka', 'kecewa', 'sakit hati'],
      responses: [
        "Menangis itu sehat, itu cara tubuh melepaskan emosi. Tidak apa-apa untuk merasa sedih. Jangan memaksakan diri untuk 'baik-baik saja' sekarang.",
        "Saya turut merasakan kesedihan Anda. Terkadang, hal terbaik yang bisa kita lakukan adalah membiarkan diri kita merasakannya, bukan melawannya.",
      ],
    ),
    KnowledgeEntry(
      category: 'hopeless',
      keywords: ['putus asa', 'hampa', 'kosong', 'tidak berharga', 'gagal', 'benci diri', 'tidak berguna'],
      responses: [
        "Perasaan hampa atau putus asa adalah beban yang berat. Tapi ingat, perasaan adalah cuaca, bukan langit. Cuaca buruk akan berlalu, langit (diri Anda) akan tetap ada.",
        "Anda berharga, bahkan di saat Anda merasa tidak produktif atau 'gagal'. Nilai Anda sebagai manusia tidak ditentukan oleh pencapaian Anda.",
        "Depresi sering berbohong pada kita, mengatakan kita sendirian atau tidak berguna. Itu tidak benar. Langkah kecil apa yang bisa Anda ambil hari ini? Sekadar bangun dari tempat tidur pun adalah kemenangan.",
      ],
    ),

    // --- STRESS & BURNOUT ---
    KnowledgeEntry(
      category: 'stress',
      keywords: ['stres', 'pusing', 'beban', 'banyak pikiran', 'pening', 'tekanan'],
      responses: [
        "Sepertinya beban Anda sedang berat sekali. Sudahkah beristirahat sejenak hari ini? Otak butuh jeda untuk bisa berfungsi kembali.",
        "Stres adalah sinyal bahwa Anda peduli pada apa yang Anda kerjakan. Tapi kesehatan Anda lebih prioritas. Coba buat daftar prioritas dan kerjakan satu per satu.",
      ],
    ),
    KnowledgeEntry(
      category: 'burnout',
      keywords: ['lelah', 'capek', 'lemes', 'burnout', 'tidak semangat', 'malas', 'energi habis'],
      responses: [
        "Kelelahan emosional (burnout) itu nyata. Tidur saja mungkin tidak cukup. Anda butuh 'istirahat rekreasi' atau 'istirahat sosial'. Apa hal kecil yang biasanya membuat Anda senang?",
        "Jangan terlalu keras pada diri sendiri. Produktivitas bukan satu-satunya tujuan hidup. Izinkan diri Anda untuk tidak melakukan apa-apa sejenak.",
      ],
    ),

    // --- SLEEP (TIDUR) ---
    KnowledgeEntry(
      category: 'insomnia',
      keywords: ['susah tidur', 'tidak bisa tidur', 'insomnia', 'melek', 'bergadang'],
      responses: [
        "Susah tidur seringkali karena pikiran yang masih aktif. Coba teknik 'Brain Dump': Tuliskan semua yang Anda pikirkan di kertas, lalu katakan pada diri sendiri 'Saya akan memikirkannya besok'.",
        "Hindari layar HP setidaknya 30 menit sebelum tidur. Cahaya biru bisa menipu otak Anda untuk berpikir ini masih siang.",
        "Coba latihan relaksasi otot progresif. Kencangkan otot kaki, lalu lemaskan. Naik ke paha, perut, hingga wajah. Rasakan bedanya tegang dan rileks.",
      ],
    ),
    KnowledgeEntry(
      category: 'nightmare',
      keywords: ['mimpi buruk', 'mimpi seram', 'terbangun'],
      responses: [
        "Mimpi buruk memang menakutkan dan bisa membuat jantung berdebar. Saat terbangun, ingatkan diri Anda: 'Itu cuma mimpi, saya sekarang aman di tempat tidur'.",
        "Jika mimpi buruk terus berulang, menuliskan mimpi itu dan mengubah akhir ceritanya menjadi positif saat bangun (Imagery Rehearsal Therapy) bisa membantu.",
      ],
    ),

    // --- RELATIONSHIPS (HUBUNGAN) ---
    KnowledgeEntry(
      category: 'lonely',
      keywords: ['kesepian', 'sendirian', 'tidak punya teman', 'dicuekin'],
      responses: [
        "Kesepian bukan berarti ada yang salah dengan Anda. Itu adalah sinyal kebutuhan akan koneksi. Apakah ada teman lama atau keluarga yang bisa Anda sapa hari ini?",
        "Terkadang kita bisa merasa sepi di tengah keramaian. Cobalah fokus pada kualitas hubungan, bukan kuantitas. Hubungan dengan diri sendiri juga penting.",
      ],
    ),
    KnowledgeEntry(
      category: 'breakup',
      keywords: ['putus', 'mantan', 'patah hati', 'selingkuh', 'dikhianati'],
      responses: [
        "Patah hati adalah salah satu rasa sakit emosional terkuat. Beri waktu diri Anda berduka layaknya kehilangan seseorang. Jangan terburu-buru 'move on'.",
        "Fokus pada diri sendiri sekarang. Lakukan hobi lama yang mungkin sempat terlupakan. Anda utuh sebelum dia datang, dan Anda akan tetap utuh sekarang.",
      ],
    ),

    KnowledgeEntry(
      category: 'study_work_stress',
      keywords: ['tugas', 'skripsi', 'kuliah', 'sekolah', 'kerja', 'kantor', 'deadline', 'bos', 'dosen'],
      responses: [
        "Tekanan akademik atau pekerjaan bisa sangat menguras energi. Jangan lupa bahwa Anda lebih dari sekadar nilai atau pencapaian kerja Anda.",
        "Jika merasa kewalahan dengan tugas/pekerjaan, coba teknik Pomodoro: fokus 25 menit, istirahat 5 menit. Tubuh dan pikiran Anda butuh waktu untuk recharge.",
        "Ingatlah untuk mengambil napas. Satu langkah kecil lebih baik daripada diam karena takut salah.",
      ],
    ),

    // --- RELATIONSHIPS & FAMILY ---
    KnowledgeEntry(
      category: 'family_issues',
      keywords: ['orang tua', 'mama', 'papa', 'ayah', 'ibu', 'adik', 'kakak', 'keluarga', 'rumah'],
      responses: [
        "Masalah keluarga seringkali menjadi hal yang paling menguras emosi karena mereka adalah orang terdekat kita. Apa yang terjadi di rumah yang membuat Anda tidak nyaman?",
        "Terkadang rumah bukan tempat yang tenang bagi semua orang. Menjaga batasan (boundaries) demi kesehatan mental Anda sendiri itu diperbolehkan.",
      ],
    ),

    // --- SELF ESTEEM & GRIEF ---
    KnowledgeEntry(
      category: 'self_esteem',
      keywords: ['jelek', 'bodoh', 'malu', 'minder', 'insecure', 'bandingkan', 'iri'],
      responses: [
        "Insecurity sering muncul saat kita membandingkan 'halaman belakang' kita dengan 'halaman depan' orang lain. Setiap orang punya prosesnya masing-masing.",
        "Anda memiliki keunikan yang tidak dimiliki orang lain. Coba sebutkan tiga hal kecil yang Anda syukuri dari diri Anda hari ini.",
      ],
    ),
    KnowledgeEntry(
      category: 'grief',
      keywords: ['kehilangan', 'meninggal', 'berduka', 'wafat', 'pergi'],
      responses: [
        "Saya turut berduka sedalam-dalamnya. Kehilangan seseorang yang berharga adalah proses yang sangat berat. Berikan diri Anda waktu untuk berduka, tidak ada cara 'benar' untuk melakukannya.",
        "Kesedihan karena kehilangan tidak hilang, tapi kita belajar untuk hidup bersamanya. Jangan ragu mencari dukungan dari orang-orang yang Anda percayai.",
      ],
    ),

    // --- SOCIAL ANXIETY ---
    KnowledgeEntry(
      category: 'social_anxiety',
      keywords: ['keramaian', 'orang banyak', 'panggung', 'presentasi', 'malu bicara', 'dilihat orang', 'sosial', 'introvert'],
      responses: [
        "Kecemasan sosial bisa membuat kita merasa terus-menerus dihakimi. Ingatlah bahwa kebanyakan orang lebih fokus pada diri mereka sendiri daripada kesalahan kecil kita.",
        "Sebelum masuk ke situasi sosial, coba afirmasi diri: 'Saya berhak berada di sini, dan saya aman'. Mulailah dengan interaksi kecil.",
      ],
    ),

    // --- FINANCIAL STRESS ---
    KnowledgeEntry(
      category: 'financial_stress',
      keywords: ['uang', 'duit', 'ekonomi', 'miskin', 'hutang', 'cicilan', 'biaya', 'tagihan', 'tabungan'],
      responses: [
        "Stres karena masalah keuangan sangatlah nyata dan berat. Jangan memikulnya sendirian. Jika memungkinkan, coba buat perencanaan anggaran yang sangat sederhana untuk memberi rasa kendali.",
        "Kekhawatiran finansial sering memicu kecemasan yang mendalam. Fokuslah pada apa yang bisa Anda kendalikan hari ini, bukan ketidakpastian masa depan yang jauh.",
      ],
    ),

    // --- LIFESTYLE & HABITS ---
    KnowledgeEntry(
      category: 'eating_disorders',
      keywords: ['makan', 'diet', 'gemuk', 'kurus', 'berat badan', 'kelaparan', 'muntah'],
      responses: [
        "Hubungan kita dengan makanan seringkali mencerminkan hubungan kita dengan emosi. Cobalah untuk makan secara sadar (mindful eating) dan jangan menghukum diri sendiri atas apa yang Anda makan.",
        "Tubuh Anda adalah rumah Anda. Berikan nutrisi yang baik bukan karena hukuman, tapi karena Anda layak untuk sehat.",
      ],
    ),
    KnowledgeEntry(
      category: 'exercise_mental_health',
      keywords: ['olahraga', 'gerak', 'jalan kaki', 'fisik', 'gym', 'sehat'],
      responses: [
        "Aktivitas fisik adalah antidepresan alami. Jalan kaki 10 menit saja bisa meningkatkan mood karena pelepasan hormon endorfin.",
        "Tidak perlu olahraga berat. Sekadar meregangkan tubuh atau jalan santai di pagi hari bisa membantu menjernihkan pikiran yang ruwet.",
      ],
    ),
    KnowledgeEntry(
      category: 'addiction_digital',
      keywords: ['hp terus', 'gadget', 'sosmed', 'scroll', 'instagram', 'tiktok', 'kecanduan'],
      responses: [
        "Doomscrolling bisa memperburuk kecemasan. Coba lakukan 'Digital Detox' selama satu jam sebelum tidur atau setelah bangun pagi.",
        "Media sosial seringkali hanya menampilkan 'best of' orang lain. Jangan biarkan itu membuat Anda merasa kurang. Dunia nyata jauh lebih luas dari layar HP Anda.",
      ],
    ),

    // --- SELF IMPROVEMENT ---
    KnowledgeEntry(
      category: 'procrastination',
      keywords: ['nunda', 'menunda', 'malas ngerjain', 'nanti-nanti', 'prokrastinasi'],
      responses: [
        "Menunda-nunda biasanya bukan karena malas, tapi karena rasa takut gagal atau rasa kewalahan. Coba kerjakan tugas yang paling mudah selama 2 menit dulu.",
        "Lawan rasa enggan dengan 'Aturan 5 Detik': Hitung mundur 5-4-3-2-1 dan langsung bergerak sebelum otak Anda mulai memberi alasan untuk berhenti.",
      ],
    ),
    KnowledgeEntry(
      category: 'goal_setting',
      keywords: ['tujuan hidup', 'cita-cita', 'masa depan', 'bingung mau apa', 'karir'],
      responses: [
        "Tidak apa-apa jika saat ini Anda belum tahu tujuan hidup yang besar. Fokuslah untuk menjadi versi terbaik diri Anda hari ini.",
        "Masa depan dibangun dari apa yang kita lakukan sekarang. Mulailah dengan target kecil yang bisa dicapai dalam satu minggu ke depan.",
      ],
    ),

    // --- EMOTIONS ---
    KnowledgeEntry(
      category: 'anger',
      keywords: ['marah', 'emosi', 'kesal', 'jengkel', 'ngamuk', 'benci'],
      responses: [
        "Marah adalah emosi yang valid, tapi jangan biarkan kemarahan mengendalikan tindakan Anda. Coba salurkan energi marah ke hal fisik seperti memeras bantal atau merobek kertas.",
        "Di balik kemarahan, biasanya ada rasa sakit atau ketidakadilan yang dirasakan. Apa sebenarnya yang membuat Anda merasa terluka?",
      ],
    ),
    KnowledgeEntry(
      category: 'guilt_shame',
      keywords: ['menyesal', 'salah banget', 'dosa', 'rasa bersalah', 'malu banget'],
      responses: [
        "Kita semua pernah melakukan kesalahan. Rasa bersalah gunanya untuk belajar, bukan untuk menghukum diri selamanya. Maafkanlah versi diri Anda yang dulu.",
        "Anda bukan kesalahan Anda. Anda adalah orang yang sedang bertumbuh dan belajar dari kesalahan tersebut.",
      ],
    ),

    // --- PROFESSIONAL HELP ---
    KnowledgeEntry(
      category: 'seeking_therapy',
      keywords: ['psikolog', 'psikiater', 'dokter jiwa', 'terapi', 'konseling professional'],
      responses: [
        "Mencari bantuan profesional adalah tanda kekuatan, bukan kelemahan. Jika perasaan Anda sudah sangat mengganggu fungsi harian, berkonsultasi dengan psikolog adalah langkah yang tepat.",
        "Seorang terapis bisa memberikan perspektif objektif dan alat yang Anda butuhkan untuk pulih. Banyak platform online sekarang yang menyediakan layanan konseling terjangkau.",
      ],
    ),

    // --- POSITIVE VIBES ---
    KnowledgeEntry(
      category: 'positive_vibes',
      keywords: ['senang', 'bahagia', 'bagus', 'keren', 'mantap', 'oke', 'syukur', 'alhamdulillah'],
      responses: [
        "Senang mendengarnya! Pertahankan energi positif ini. Apa yang membuat hari Anda terasa menyenangkan?",
        "Luar biasa! Merayakan kemenangan kecil sangat penting untuk kesehatan mental kita.",
        "Semoga hari-hari Anda ke depan terus dipenuhi hal baik. Ceritakan terus jika ada kabar gembira ya!",
      ],
    ),

    // --- TECHNIQUES ---
    KnowledgeEntry(
      category: 'meditation',
      keywords: ['meditasi', 'cara tenang', 'relaksasi', 'yoga', 'napas', 'mindfulness', 'tenang'],
      responses: [
        "Mari kita coba pernapasan kotak (Box Breathing): Tarik napas 4 hitungan, tahan 4 hitungan, buang 4 hitungan, tahan kosong 4 hitungan. Ulangi 3 kali.",
        "Meditasi bukan berarti mengosongkan pikiran, tapi menyadari pikiran tanpa menghakiminya. Biarkan pikiran datang dan pergi seperti awan di langit.",
        "Coba 'Pernapasan Diafragma': Letakkan tangan di perut, pastikan perut Anda mengembang saat menghirup napas melalui hidung.",
      ],
    ),
  ];
}
