import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insightmind_app/features/insightmind/domain/usecases/report_generator.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';



/// Provider untuk usecase ReportGenerator
/// (kalau nanti mau diganti implementasinya, tinggal ganti di sini).
final reportGeneratorProvider = Provider<ReportGenerator>((ref) {
  return ReportGenerator();
});

/// Fungsi helper untuk preview/print PDF.
/// Dibuat provider supaya UI tetap bersih.
final reportPreviewProvider = Provider<ReportPreviewService>((ref) {
  return ReportPreviewService();
});

class ReportPreviewService {
  Future<void> previewPdf({
    required Future<Uint8List> Function(PdfPageFormat format) onLayout,
  }) async {
    await Printing.layoutPdf(onLayout: onLayout);
  }
}
