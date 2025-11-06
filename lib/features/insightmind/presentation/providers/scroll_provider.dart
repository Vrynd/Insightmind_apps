import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

/// Provider untuk ScrollController
final scrollControllerProvider = Provider<ScrollController>((ref) {
  final controller = ScrollController();

  // Setiap kali scroll berubah, perbarui status isScrolling
  controller.addListener(() {
    final offset = controller.offset;
    final isScrolling = offset > 0;
    ref.read(isScrollingProvider.notifier).state = isScrolling;
  });

  ref.onDispose(() {
    controller.dispose();
  });

  return controller;
});

/// Provider untuk status apakah sedang scroll atau tidak
final isScrollingProvider = StateProvider<bool>((ref) => false);
