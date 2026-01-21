# 🎓 Dark Mode Feature - Developer Guide

## 📌 File Locations Reference

### Core Files
| File | Purpose | Location |
|------|---------|----------|
| Theme Provider | State management | `lib/features/insightmind/presentation/providers/theme_provider.dart` |
| Toggle Widgets | 4 ready-to-use widgets | `lib/features/insightmind/presentation/widgets/theme_toggle_widget.dart` |
| Theme Config | Light/Dark theme colors | `lib/features/insightmind/presentation/themes/theme_app.dart` |

### Screen Files
| Screen | Update | Location |
|--------|--------|----------|
| App Root | Uses provider | `lib/src/app.dart` |
| Login | Toggle switch added | `lib/features/insightmind/presentation/screen/login_screen.dart` |
| Home | Toggle icon added | `lib/features/insightmind/presentation/screen/home_screen.dart` |
| Settings | New settings page | `lib/features/insightmind/presentation/screen/settings_screen.dart` |
| Demo | Demo all widgets | `lib/features/insightmind/presentation/screen/dark_mode_example_screen.dart` |

---

## 🔨 Common Implementation Patterns

### Pattern 1: Add Toggle to AppBar
```dart
import 'package:insightmind_app/features/insightmind/presentation/widgets/theme_toggle_widget.dart';

class MyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Screen'),
        actions: const [
          ThemeToggleIconButton(), // ← Minimal space, perfect for AppBar
        ],
      ),
      body: const Center(child: Text('Content')),
    );
  }
}
```

### Pattern 2: Add Toggle to Settings List
```dart
import 'package:insightmind_app/features/insightmind/presentation/widgets/theme_toggle_widget.dart';

class MySettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          // ... other settings
          const ThemeToggleListTile(), // ← Full width, perfect for list
          // ... other settings
        ],
      ),
    );
  }
}
```

### Pattern 3: Add Complete Theme Selector
```dart
import 'package:insightmind_app/features/insightmind/presentation/widgets/theme_toggle_widget.dart';

class MyAdvancedSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Card(
              child: ThemeModeSelector(), // ← Radio buttons with 3 options
            ),
          ],
        ),
      ),
    );
  }
}
```

### Pattern 4: Simple Switch Toggle
```dart
import 'package:insightmind_app/features/insightmind/presentation/widgets/theme_toggle_widget.dart';

class MyLoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const ThemeToggleSwitch(), // ← Light on left, dark on right
            // ... login form
          ],
        ),
      ),
    );
  }
}
```

### Pattern 5: Programmatic Theme Change
```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insightmind_app/features/insightmind/presentation/providers/theme_provider.dart';

// Di dalam ConsumerWidget
class MyConsumerWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(themeModeProvider);
    
    return Column(
      children: [
        Text('Current: ${currentTheme.name}'),
        
        ElevatedButton(
          onPressed: () {
            // Set ke dark mode
            ref.read(themeModeProvider.notifier)
                .setThemeMode(ThemeMode.dark);
          },
          child: const Text('Go Dark'),
        ),
        
        ElevatedButton(
          onPressed: () {
            // Toggle ke mode lain
            ref.read(themeModeProvider.notifier)
                .toggleTheme();
          },
          child: const Text('Toggle'),
        ),
      ],
    );
  }
}
```

---

## 🎯 Workflow Examples

### Example 1: Add Dark Mode to Existing Screen
```dart
// Step 1: Add import
import 'package:insightmind_app/features/insightmind/presentation/widgets/theme_toggle_widget.dart';

// Step 2: Add widget to AppBar
AppBar(
  actions: const [
    ThemeToggleIconButton(),
  ],
)

// Done! ✓
```

### Example 2: Create Settings Screen with Dark Mode
```dart
import 'package:flutter/material.dart';
import 'package:insightmind_app/features/insightmind/presentation/widgets/theme_toggle_widget.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          // Option A: Simple toggle
          const ThemeToggleListTile(),
          
          // Or Option B: Complete selector (uncomment one)
          // const ThemeModeSelector(),
        ],
      ),
    );
  }
}
```

### Example 3: Listen to Theme Changes
```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insightmind_app/features/insightmind/presentation/providers/theme_provider.dart';

// In a ConsumerWidget
class MyWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch theme changes
    ref.listen(themeModeProvider, (previous, next) {
      if (next == ThemeMode.dark) {
        print('Switched to dark mode');
      } else if (next == ThemeMode.light) {
        print('Switched to light mode');
      }
    });
    
    return const SizedBox();
  }
}
```

---

## 🧪 Testing Checklist

Before deploying, verify:

- [ ] **UI Integration**
  - [ ] Toggle appears correctly in all screens
  - [ ] No layout overflow or alignment issues
  - [ ] Icons display correctly (moon/sun)

- [ ] **Functionality**
  - [ ] Toggle switches between light/dark
  - [ ] System mode respects device settings
  - [ ] Preference persists after app restart
  - [ ] No errors in console

- [ ] **Visual**
  - [ ] Light theme colors look good
  - [ ] Dark theme colors look good
  - [ ] Text contrast is sufficient in both modes
  - [ ] No UI elements become invisible

- [ ] **Performance**
  - [ ] Theme switch happens without lag
  - [ ] No memory leaks detected
  - [ ] Storage size is reasonable (~100 bytes for setting)

---

## 🐛 Troubleshooting

### Problem: Toggle button not appearing
**Solution:**
```dart
// Make sure you've imported the widget
import 'package:insightmind_app/features/insightmind/presentation/widgets/theme_toggle_widget.dart';

// And added it to the widget tree
ThemeToggleIconButton() // or other variant
```

### Problem: Theme not persisting after restart
**Solution:**
```dart
// Check that Hive box is initialized in main.dart before using app
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  // ... other initialization
  runApp(const InsightMindApp());
}
```

### Problem: Dark theme not applying to all elements
**Solution:**
```dart
// Use Theme.of(context) to get colors, don't hardcode colors
Color myColor = Theme.of(context).colorScheme.primary;

// Avoid:
Color myColor = const Color(0xFF3E5F90); // Won't change with theme
```

### Problem: Widget not rebuilding when theme changes
**Solution:**
```dart
// Use ConsumerWidget instead of StatelessWidget
class MyWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider); // Watch for changes
    // Widget will rebuild when theme changes
  }
}
```

---

## 📖 Source Code Overview

### `theme_provider.dart` - Key Methods
```dart
// Set specific theme mode
await ref.read(themeModeProvider.notifier)
    .setThemeMode(ThemeMode.dark);

// Toggle between modes
await ref.read(themeModeProvider.notifier)
    .toggleTheme();

// Check current mode
bool isDark = ref.read(themeModeProvider.notifier).isDarkMode;
```

### `theme_app.dart` - Customize Colors
```dart
static ThemeData lightTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFF3E5F90), // ← Change primary color
    brightness: Brightness.light,
  ),
  // ... more customization
);
```

---

## 🚀 Advanced Usage

### Listen and Respond to Theme Changes
```dart
ref.listen(themeModeProvider, (previous, next) {
  // Do something when theme changes
  if (next == ThemeMode.dark) {
    // Analytics, logging, etc.
  }
});
```

### Combine with Other Providers
```dart
// Create a provider that depends on theme
final myDataProvider = StateProvider((ref) {
  final theme = ref.watch(themeModeProvider);
  // Use theme to determine data
  return myData;
});
```

### Override Theme at Runtime
```dart
// Force light theme for specific screen
MaterialApp(
  themeMode: ThemeMode.light,
  theme: ThemeApp.lightTheme,
  darkTheme: ThemeApp.darkTheme,
  home: MyScreen(),
)
```

---

## 📚 Related Files

- App initialization: `lib/main.dart`
- App root: `lib/src/app.dart`
- Theme definition: `lib/features/insightmind/presentation/themes/theme_app.dart`
- Font configuration: `lib/features/insightmind/presentation/themes/font_app.dart`

---

**Last Updated:** 2026-01-21  
**Status:** ✅ Production Ready
