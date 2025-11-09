class Recommendation {
  static List<String> getRecommendations(String riskLevel) {
    switch (riskLevel.toLowerCase()) {
      case 'minimal':
        return [
          'Pertahankan rutinitas positif seperti olahraga dan tidur cukup.',
          'Teruskan menjaga keseimbangan antara aktivitas dan waktu istirahat.',
          'Luangkan waktu untuk kegiatan yang menyenangkan dan menenangkan.',
          'Tetap jaga interaksi sosial agar suasana hati stabil.',
        ];

      case 'ringan':
        return [
          'Mulailah mengenali sumber stres ringan yang mungkin kamu alami.',
          'Lakukan aktivitas relaksasi seperti meditasi, jalan santai, atau journaling.',
          'Tetap jaga pola makan dan tidur yang teratur.',
          'Bicarakan perasaanmu dengan orang terdekat untuk meringankan beban emosional.',
        ];

      case 'sedang':
        return [
          'Lakukan aktivitas relaksasi seperti napas dalam, yoga atau meditasi.',
          'Atur waktu antara kuliah/kerja dan istirahat dengan lebih seimbang.',
          'Luangkan waktu untuk melakukan kegiatan yang kamu nikmati.',
          'Pertimbangkan berbicara dengan konselor jika merasa stres sering muncul.',
        ];

      case 'cukup berat':
        return [
          'Disarankan berkonsultasi dengan konselor atau psikolog profesional.',
          'Kurangi tekanan aktivitas yang berlebihan agar tidak kelelahan mental.',
          'Fokus pada pemulihan dengan tidur cukup dan pola makan bergizi.',
          'Carilah dukungan emosional dari teman, keluarga, atau layanan kampus.',
        ];

      case 'berat':
        return [
          'Segera hubungi tenaga profesional seperti psikolog atau psikiater.',
          'Jangan menghadapi tekanan sendirian, libatkan orang terdekat.',
          'Batasi aktivitas berat dan berikan waktu untuk pemulihan mental.',
          'Gunakan layanan konseling kampus atau hotline kesehatan mental bila diperlukan.',
        ];

      default:
        return [
          'Pertahankan rutinitas positif seperti tidur teratur dan olahraga ringan.',
          'Jaga pola makan seimbang dan waktu istirahat cukup.',
          'Terus berinteraksi dengan lingkungan sosial yang positif.',
          'Lakukan kegiatan yang meningkatkan suasana hati secara konsisten.',
        ];
    }
  }
}
