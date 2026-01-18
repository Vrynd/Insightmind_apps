# InsightMind App 🧠

**InsightMind** adalah aplikasi Flutter untuk deteksi dini risiko depresi melalui kombinasi kuesioner kesehatan mental dan analisis sensor biometrik real-time menggunakan AI on-device.

## 🎯 Fitur Utama

### 1. **Screening Berbasis Kuesioner** 📋

- Kuesioner terstruktur untuk mengevaluasi kondisi mental pengguna
- Scoring otomatis berdasarkan jawaban
- Risk level classification (Rendah, Sedang, Tinggi)
- Rekomendasi personalized berdasarkan hasil

### 2. **Biometric Sensor Integration** 📱

- **Activity Monitoring**: Menangkap data pergerakan/aktivitas fisik
- **PPG (Photoplethysmography)**: Analisis denyut jantung real-time
- Ekstraksi fitur variabilitas dari sensor data

### 3. **AI On-Device Prediction** 🤖

- Model machine learning on-device (tanpa internet)
- Prediksi risiko depresi real-time
- Feature importance/explainability - pengguna bisa lihat faktor mana yang paling berpengaruh
- Privacy-first: semua data diproses lokal, tidak ada transmisi ke server

### 4. **History & Tracking** 📊

- Riwayat skrining tersimpan lokal
- Tracking tren risiko dari waktu ke waktu
- Komparasi hasil antar sesi screening

### 5. **Smart UI & UX** ✨

- Dark/Light theme support dengan Material Design 3
- Animated transitions & smooth scroll effects
- Responsive layout untuk berbagai ukuran device
- Bottom navigation untuk navigasi antar fitur

## 🏗️ Arsitektur

```
lib/
├── main.dart                    # Entry point aplikasi
├── src/
│   └── app.dart               # App configuration & routing
└── features/
    └── insightmind/
        ├── data/
        │   ├── local/         # Local database (Hive)
        │   ├── models/        # Data models
        │   └── repositories/  # Data layer implementation
        ├── domain/
        │   ├── entities/      # Business entities
        │   ├── repositories/  # Abstract repositories
        │   └── usecases/      # Business logic (Screening, AI Prediction)
        └── presentation/
            ├── providers/     # Riverpod state management
            ├── screens/       # UI screens
            └── widgets/       # Reusable widgets
```

## 📱 Screens/Pages

| Screen               | Fungsi                                 |
| -------------------- | -------------------------------------- |
| **Home Screen**      | Dashboard utama dengan riwayat terbaru |
| **Screening Screen** | Kuesioner mental health interaktif     |
| **Biometric Screen** | Sensor data collection & preview       |
| **Result Screen**    | Hasil screening dengan rekomendasi     |
| **AI Result Screen** | Prediksi AI dengan explainability      |
| **History Screen**   | Daftar lengkap riwayat screening       |

## 🔧 Tech Stack

### Frontend

- **Framework**: Flutter (latest)
- **State Management**: Riverpod
- **UI**: Material Design 3
- **Local Database**: Hive
- **Navigation**: Navigator 2.0

### Backend/AI

- **ML Model**: On-device prediction (no server)
- **Sensor Processing**: Activity & PPG signal analysis
- **Feature Engineering**: Screening score + biometric features

## ⚙️ Setup & Installation

### Prerequisites

```bash
Flutter >= 3.0.0
Dart >= 3.0.0
```

### Clone & Install

```bash
git clone <repository-url>
cd insightmind_app
flutter pub get
```

### Run App

```bash
flutter run
```

### Build APK/AAB

```bash
# APK
flutter build apk --release

# AAB (Google Play)
flutter build appbundle --release
```

## 📦 Dependencies

Key packages:

```yaml
flutter_riverpod: ^2.0.0 # State management
hive: ^2.0.0 # Local database
uuid: ^4.0.0 # Unique ID generation
sensors_plus: ^4.0.0 # Sensor access
camera: ^0.10.0 # Camera for biometrics
```

## 🔐 Privacy & Security

- ✅ **No cloud sync**: Semua data tersimpan lokal di device
- ✅ **On-device AI**: Model processing tanpa kirim data ke server
- ✅ **Encrypted storage**: Data di-enkripsi menggunakan Hive encryption
- ✅ **Privacy-first**: User punya kontrol penuh atas data mereka

## 🚀 Fitur Roadmap

- [ ] Export/Import history data
- [ ] Offline sync ketika internet tersedia
- [ ] Advanced analytics & trend visualization
- [ ] Integration dengan health apps (Google Fit, Apple HealthKit)
- [ ] Multi-language support
- [ ] Progressive Web App (PWA) version

## 📝 Development Notes

### Project Structure Best Practices

- Clean Architecture: Separation of concerns (data, domain, presentation)
- State Management: Riverpod untuk predictable state changes
- Testing: Unit, widget, dan integration tests

### Key Files to Understand

- `lib/features/insightmind/domain/usecases/predict_risk_ai.dart` - AI model logic
- `lib/features/insightmind/presentation/providers/ai_provider.dart` - AI state
- `lib/features/insightmind/data/local/history_repository.dart` - History management

## 🤝 Contributing

Kontribusi welcome! Mohon:

1. Follow Flutter style guide
2. Test sebelum push
3. Buat descriptive commit messages

## 📄 License

[Add your license here]

## 👨‍💻 Author

InsightMind Team

---

**Stay mindful, stay healthy! 💚**
