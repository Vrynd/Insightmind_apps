# 🌙 Fitur Dark Mode - InsightMind App

Fitur dark mode telah berhasil ditambahkan ke aplikasi InsightMind!

## ✅ Yang Sudah Ditambahkan

### 1. **Theme Provider** 
File: [`theme_provider.dart`](lib/features/insightmind/presentation/providers/theme_provider.dart)
- Mengelola state dark/light mode dengan Riverpod
- Menyimpan preferensi theme secara otomatis ke Hive
- Support 3 mode: Light, Dark, dan System

### 2. **4 Widget Toggle Siap Pakai**
File: [`theme_toggle_widget.dart`](lib/features/insightmind/presentation/widgets/theme_toggle_widget.dart)
- `ThemeToggleSwitch` - Switch dengan icon ☀️/🌙
- `ThemeToggleIconButton` - Icon button untuk AppBar
- `ThemeToggleListTile` - ListTile untuk settings
- `ThemeModeSelector` - Radio button lengkap (Light/Dark/System)

### 3. **Sudah Terintegrasi Di:**
- ✅ [Login Screen](lib/features/insightmind/presentation/screen/login_screen.dart) - Toggle switch di atas
- ✅ [Home Screen](lib/features/insightmind/presentation/screen/home_screen.dart) - Icon button di AppBar
- ✅ [App Root](lib/src/app.dart) - Menggunakan theme provider

### 4. **Screen Demo & Settings**
- [`settings_screen.dart`](lib/features/insightmind/presentation/screen/settings_screen.dart) - Halaman settings lengkap
- [`dark_mode_example_screen.dart`](lib/features/insightmind/presentation/screen/dark_mode_example_screen.dart) - Demo semua widget

## 🚀 Cara Menggunakan

### Quick: Tambahkan di AppBar
```dart
import 'package:insightmind_app/features/insightmind/presentation/widgets/theme_toggle_widget.dart';

AppBar(
  title: Text('My Screen'),
  actions: [
    ThemeToggleIconButton(), // ← Tambahkan ini
  ],
)
```

### Gunakan di Body/Settings
```dart
// Switch dengan icon
ThemeToggleSwitch()

// ListTile (cocok untuk settings)
ThemeToggleListTile()

// Selector lengkap dengan 3 opsi
ThemeModeSelector()
```

## 🎨 Kustomisasi Warna Theme

Edit file: [`theme_app.dart`](lib/features/insightmind/presentation/themes/theme_app.dart)

```dart
static ThemeData lightTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFF3E5F90), // ← Ganti warna
    brightness: Brightness.light,
  ),
  // ... kustomisasi lainnya
);
```

## 📱 Testing

1. Jalankan app: Sudah ada toggle di Login Screen & Home Screen
2. Klik icon/switch untuk ganti theme
3. Tutup dan buka lagi app - preferensi tersimpan!

## 📚 Dokumentasi Lengkap

Lihat: [`DARK_MODE_GUIDE.md`](DARK_MODE_GUIDE.md) untuk dokumentasi detail

---

**Note:** Theme default adalah System (mengikuti pengaturan perangkat). User bisa mengubahnya kapan saja dengan toggle yang tersedia.
