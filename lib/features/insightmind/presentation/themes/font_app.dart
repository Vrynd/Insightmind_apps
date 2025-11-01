import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FontApp {
  static final TextStyle _baseStyle = GoogleFonts.albertSans();

  /// displayLarge — untuk hero title
  static TextStyle displayLarge = _baseStyle.copyWith(
    fontSize: 57,
    fontWeight: FontWeight.w600,
    height: 1.1,
    letterSpacing: -0.5,
  );

  /// displayMedium — untuk section title besar
  static TextStyle displayMedium = _baseStyle.copyWith(
    fontSize: 45,
    fontWeight: FontWeight.w500,
    height: 1.15,
    letterSpacing: -0.25,
  );

  /// displaySmall — subheading besar
  static TextStyle displaySmall = _baseStyle.copyWith(
    fontSize: 36,
    fontWeight: FontWeight.w500,
    height: 1.2,
  );

  /// headlineLarge — judul halaman
  static TextStyle headlineLarge = _baseStyle.copyWith(
    fontSize: 32,
    fontWeight: FontWeight.w600,
    height: 1.25,
  );

  /// headlineMedium — subjudul konten
  static TextStyle headlineMedium = _baseStyle.copyWith(
    fontSize: 28,
    fontWeight: FontWeight.w500,
    height: 1.3,
  );

  /// headlineSmall — konten heading kecil
  static TextStyle headlineSmall = _baseStyle.copyWith(
    fontSize: 24,
    fontWeight: FontWeight.w500,
    height: 1.3,
  );

  /// titleLarge — judul card atau dialog
  static TextStyle titleLarge = _baseStyle.copyWith(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    height: 1.3,
  );

  /// titleMedium — subjudul card
  static TextStyle titleMedium = _baseStyle.copyWith(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    height: 1.4,
    letterSpacing: 0.1,
  );

  /// titleSmall — teks heading kecil
  static TextStyle titleSmall = _baseStyle.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.4,
    letterSpacing: 0.1,
  );

  /// bodyLarge — teks paragraf utama
  static TextStyle bodyLarge = _baseStyle.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.6,
    letterSpacing: 0.2,
  );

  /// bodyMedium — teks sekunder
  static TextStyle bodyMedium = _baseStyle.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.6,
    letterSpacing: 0.15,
  );

  /// bodySmall — catatan atau deskripsi kecil
  static TextStyle bodySmall = _baseStyle.copyWith(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.45,
    letterSpacing: 0.3,
  );

  /// labelLarge — tombol besar
  static TextStyle labelLarge = _baseStyle.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 1.4,
    letterSpacing: 0.5,
  );

  /// labelMedium — tombol kecil, badge
  static TextStyle labelMedium = _baseStyle.copyWith(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    height: 1.3,
    letterSpacing: 0.5,
  );

  /// labelSmall — hint text
  static TextStyle labelSmall = _baseStyle.copyWith(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    height: 1.2,
    letterSpacing: 0.4,
  );
}
