# Dark Mode Installation & Setup Guide

## ✅ Prerequisites

The dark mode feature has been **automatically installed**. No additional setup needed!

### Requirements Met ✓
- ✅ Flutter SDK (3.x+)
- ✅ flutter_riverpod (existing dependency)
- ✅ hive_flutter (existing dependency)
- ✅ Dart 3.x+

---

## 🚀 Get Started in 3 Steps

### Step 1: Pull Latest Code
```bash
cd d:\pixel\Insightmind_apps
git pull origin main  # or your branch
flutter pub get
```

### Step 2: Run the App
```bash
flutter run
```

### Step 3: Test Dark Mode
**At Login Screen:**
- Look for toggle switch at the top (☀️ and 🌙)
- Click to toggle between light and dark

**At Home Screen (after login):**
- Look for moon/sun icon in AppBar (right side)
- Click icon to toggle theme

---

## 📝 What You Get

### Automatically Integrated

✅ **Dark Mode Toggle** - Already visible in:
- Login Screen (switch at top)
- Home Screen (icon in AppBar)

✅ **Automatic Persistence** - Your preference is saved:
- Closes and reopens - theme persists
- Stored in Hive database

✅ **Ready-to-Use Widgets** - Use in any screen:
- `ThemeToggleSwitch` - Visual switch
- `ThemeToggleIconButton` - Compact icon
- `ThemeToggleListTile` - Settings list
- `ThemeModeSelector` - Complete options

---

## 🎯 Quick Usage Examples

### Use in AppBar (Minimal)
```dart
import 'package:insightmind_app/features/insightmind/presentation/widgets/theme_toggle_widget.dart';

AppBar(
  title: Text('My Screen'),
  actions: const [
    ThemeToggleIconButton(), // ← Add this
  ],
)
```

### Use in Body (Visual)
```dart
import 'package:insightmind_app/features/insightmind/presentation/widgets/theme_toggle_widget.dart';

body: Column(
  children: [
    const ThemeToggleSwitch(), // ← Add this
    // ... rest of body
  ],
)
```

### Use in Settings
```dart
import 'package:insightmind_app/features/insightmind/presentation/widgets/theme_toggle_widget.dart';

ListView(
  children: [
    const ThemeToggleListTile(), // ← Option 1
    // or
    const ThemeModeSelector(),   // ← Option 2
  ],
)
```

---

## 📂 File Organization

All files are properly organized:

```
lib/features/insightmind/presentation/
├── providers/
│   └── theme_provider.dart          ← Provider (don't edit usually)
├── widgets/
│   └── theme_toggle_widget.dart     ← Widgets (import from here)
├── themes/
│   └── theme_app.dart               ← Colors (edit for customization)
└── screen/
    ├── login_screen.dart            ← Already has toggle
    ├── home_screen.dart             ← Already has toggle
    ├── settings_screen.dart         ← Template for settings
    └── dark_mode_example_screen.dart ← Demo/testing
```

---

## 🔍 Verify Installation

### Check 1: Run the App
```bash
flutter run
# Should show no errors
# Toggle should appear on login screen
```

### Check 2: Try Toggling
1. On Login Screen - click toggle switch at top
2. Colors should change immediately
3. Close app (don't logout)
4. Reopen - theme should persist

### Check 3: Check Logs
```bash
flutter logs
# Should NOT show any dark mode related errors
```

---

## ⚙️ Configuration (Optional)

### Change Primary Color
Edit: `lib/features/insightmind/presentation/themes/theme_app.dart`

```dart
static ThemeData lightTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFF3E5F90), // ← Change this color
    brightness: Brightness.light,
  ),
  // ...
);
```

### Change Default Theme Mode
Edit: `lib/features/insightmind/presentation/providers/theme_provider.dart`

```dart
class ThemeModeNotifier extends StateNotifier<ThemeMode> {
  ThemeModeNotifier() : super(ThemeMode.system) { // ← Change 'system' to 'light' or 'dark'
    _loadThemeMode();
  }
}
```

---

## 🐛 Troubleshooting

### Q: Toggle button doesn't appear
**A:** Make sure you imported the widget:
```dart
import 'package:insightmind_app/features/insightmind/presentation/widgets/theme_toggle_widget.dart';
```

### Q: Theme doesn't persist after restart
**A:** This is rare but check:
1. Hive is initialized in `main.dart`
2. User has permission to write to local storage
3. Try reinstalling: `flutter clean && flutter pub get`

### Q: Colors don't change
**A:** 
1. Make sure using `Theme.of(context).colorScheme.*` instead of hardcoded colors
2. Verify app is using ConsumerWidget if accessing provider
3. Check that MaterialApp is receiving `themeMode` from provider

### Q: App crashes when toggling
**A:** 
1. Check console for error messages
2. Verify theme_provider.dart has no syntax errors
3. Ensure Riverpod version matches pubspec.yaml

---

## 📱 Device Testing

### Test on Different Devices
```bash
# List available devices
flutter devices

# Run on specific device
flutter run -d device_id
```

### Test with System Dark Mode
1. Go to device Settings
2. Turn on Dark Mode / Dark Theme
3. Select "System" option in app toggle
4. Verify app follows device theme

---

## 🚀 Deploy to Production

### Before Release Checklist
- [ ] Run `flutter analyze` - no warnings
- [ ] Run `flutter test` - all tests pass
- [ ] Test on multiple devices
- [ ] Test theme persistence
- [ ] Test system mode with device settings
- [ ] Verify no performance issues

### Build Commands
```bash
# Android
flutter build apk --release

# iOS
flutter build ios --release

# Web
flutter build web --release
```

---

## 📚 Documentation

After setup, read these docs in order:

1. **README_DARK_MODE.md** (5 min)
   - Overview of features

2. **DARK_MODE_GUIDE.md** (20 min)
   - API documentation & examples

3. **DARK_MODE_DEVELOPER_GUIDE.md** (30 min)
   - Patterns & best practices

4. **DARK_MODE_CHECKLIST.md** (10 min)
   - Implementation checklist

---

## 🎓 Learning Path

For developers new to this feature:

### Day 1: Understand
- Read README_DARK_MODE.md
- Try toggling on Login/Home screens
- Explore the code in theme_provider.dart

### Day 2: Implement
- Add toggle to 1 more screen (follow example)
- Read DARK_MODE_DEVELOPER_GUIDE.md
- Try programmatic theme change

### Day 3: Customize
- Change color scheme in theme_app.dart
- Create custom toggle widget (optional)
- Add theme scheduling (optional)

---

## 🆘 Getting Help

| Issue | Resource |
|-------|----------|
| Quick overview | README_DARK_MODE.md |
| How to use | DARK_MODE_GUIDE.md |
| Code patterns | DARK_MODE_DEVELOPER_GUIDE.md |
| Implementation | DARK_MODE_CHECKLIST.md |
| Troubleshooting | DARK_MODE_DEVELOPER_GUIDE.md |
| Visual guide | DARK_MODE_SUMMARY.txt |
| All files | DARK_MODE_INDEX.md |

---

## ✨ Summary

**Installation Status:** ✅ Complete  
**Setup Required:** None (already integrated)  
**Time to Start Using:** < 1 minute  
**Complexity:** Beginner friendly  

The dark mode feature is **ready to use immediately**. Just run the app and click the toggle!

---

## 🎉 Next Steps

1. ✅ Run the app
2. ✅ Try the toggle
3. ✅ Close and reopen (verify persistence)
4. ✅ Read DARK_MODE_GUIDE.md for more features
5. ✅ Add to more screens as needed

---

**Last Updated:** 2026-01-21  
**Status:** ✅ Ready to Use  
**Support:** See documentation files
