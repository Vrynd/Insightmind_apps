# Dark Mode Feature - InsightMind App

## Overview
Fitur dark mode telah ditambahkan ke aplikasi InsightMind dengan menggunakan Flutter Riverpod untuk state management dan Hive untuk persistensi data.

## Fitur yang Ditambahkan

### 1. Theme Provider (`theme_provider.dart`)
Provider untuk mengelola state theme mode dengan fitur:
- ✅ Penyimpanan otomatis ke Hive storage
- ✅ Support untuk Light, Dark, dan System mode
- ✅ Toggle antara theme
- ✅ State persisten (tetap tersimpan setelah app ditutup)

### 2. Theme Toggle Widgets (`theme_toggle_widget.dart`)
4 widget siap pakai untuk toggle dark mode:
- **ThemeToggleSwitch**: Switch dengan icon light/dark
- **ThemeToggleIconButton**: Icon button sederhana untuk AppBar
- **ThemeToggleListTile**: ListTile untuk halaman settings
- **ThemeModeSelector**: Radio button untuk memilih Light/Dark/System

### 3. Settings Screen (`settings_screen.dart`)
Halaman settings dengan opsi dark mode

### 4. Updated App (`app.dart`)
App telah diupdate untuk menggunakan theme provider

## Cara Menggunakan

### Quick Start - Tambahkan Toggle di AppBar
```dart
import 'package:insightmind_app/features/insightmind/presentation/widgets/theme_toggle_widget.dart';

AppBar(
  title: Text('Home'),
  actions: [
    ThemeToggleIconButton(), // Tambahkan ini
  ],
)
```

### Tambahkan di Settings
```dart
import 'package:insightmind_app/features/insightmind/presentation/widgets/theme_toggle_widget.dart';

// Gunakan ListTile
ThemeToggleListTile()

// Atau gunakan selector lengkap
ThemeModeSelector()
```

### Gunakan Switch Custom
```dart
import 'package:insightmind_app/features/insightmind/presentation/widgets/theme_toggle_widget.dart';

ThemeToggleSwitch()
```

### Akses Theme Mode Programmatically
```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insightmind_app/features/insightmind/presentation/providers/theme_provider.dart';

// Di dalam ConsumerWidget atau Consumer
final themeMode = ref.watch(themeModeProvider);

// Set theme mode
ref.read(themeModeProvider.notifier).setThemeMode(ThemeMode.dark);

// Toggle theme
ref.read(themeModeProvider.notifier).toggleTheme();

// Check status
final notifier = ref.read(themeModeProvider.notifier);
bool isDark = notifier.isDarkMode;
bool isLight = notifier.isLightMode;
bool isSystem = notifier.isSystemMode;
```

## Contoh Implementasi Lengkap

### Tambahkan ke Navigation Bar atau Drawer
```dart
// Di dalam Drawer
Drawer(
  child: ListView(
    children: [
      DrawerHeader(
        child: Text('InsightMind'),
      ),
      ListTile(
        leading: Icon(Icons.home),
        title: Text('Home'),
        onTap: () {},
      ),
      ThemeToggleListTile(), // Tambahkan toggle di sini
      ListTile(
        leading: Icon(Icons.settings),
        title: Text('Settings'),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SettingsScreen(),
            ),
          );
        },
      ),
    ],
  ),
)
```

### Navigasi ke Settings Screen
```dart
import 'package:insightmind_app/features/insightmind/presentation/screen/settings_screen.dart';

Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => const SettingsScreen(),
  ),
);
```

## Kustomisasi Theme

Jika ingin mengubah warna atau style theme, edit file:
```dart
lib/features/insightmind/presentation/themes/theme_app.dart
```

Contoh kustomisasi:
```dart
static ThemeData lightTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.blue, // Ganti warna seed
    brightness: Brightness.light,
  ),
  textTheme: _textTheme,
  useMaterial3: true,
);

static ThemeData darkTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.blue,
    brightness: Brightness.dark,
  ),
  textTheme: _textTheme,
  useMaterial3: true,
  // Tambahan kustomisasi
  scaffoldBackgroundColor: Colors.black,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.grey[900],
  ),
);
```

## Testing
Untuk test dark mode:
1. Jalankan aplikasi
2. Tambahkan `ThemeToggleIconButton()` di AppBar screen manapun
3. Klik icon untuk toggle antara light dan dark mode
4. Restart aplikasi - setting akan tetap tersimpan

## Notes
- Theme setting disimpan di Hive box bernama 'settings'
- Default theme adalah System (mengikuti pengaturan sistem)
- Semua widget theme toggle reactive dan otomatis update
