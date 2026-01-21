# API Configuration Setup

## 🔐 Keamanan API Key

File ini berisi instruksi untuk setup API key dengan aman.

## 📋 Langkah Setup

1. **Copy template file:**
   ```bash
   cp lib/config/api_config.template.dart lib/config/api_config.dart
   ```

2. **Dapatkan API Key:**
   - Kunjungi [Google AI Studio](https://aistudio.google.com/app/apikey)
   - Login dengan akun Google Anda
   - Klik "Create API Key"
   - Copy API key yang dihasilkan

3. **Update api_config.dart:**
   - Buka file `lib/config/api_config.dart`
   - Ganti `YOUR_GEMINI_API_KEY_HERE` dengan API key Anda
   - **JANGAN** commit file ini ke Git

## ⚠️ PENTING

- ✅ File `api_config.dart` sudah ditambahkan ke `.gitignore`
- ✅ File `api_config.template.dart` aman untuk di-commit
- ❌ **JANGAN PERNAH** commit `api_config.dart` ke repository
- ❌ **JANGAN** share API key di screenshot atau public

## 📁 Struktur File

```
lib/config/
├── api_config.dart          # File actual (di-gitignore, JANGAN commit)
└── api_config.template.dart # Template (aman untuk commit)
```

## 🔄 Untuk Developer Baru

Jika Anda clone repository ini:
1. Copy `api_config.template.dart` menjadi `api_config.dart`
2. Dapatkan API key sendiri dari Google AI Studio
3. Update file `api_config.dart` dengan API key Anda

## 🛡️ Best Practices

1. **Jangan hardcode API key** di file lain
2. **Selalu gunakan** `ApiConfig.geminiApiKey` untuk akses API key
3. **Periksa** `.gitignore` sebelum commit
4. **Rotate API key** secara berkala untuk keamanan
