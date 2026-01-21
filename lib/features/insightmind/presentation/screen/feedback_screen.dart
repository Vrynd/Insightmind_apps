import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math';

import 'package:insightmind_app/features/insightmind/data/local/feedback_storage.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final _formKey = GlobalKey<FormState>();
  final _featureController = TextEditingController();
  final _bugController = TextEditingController();
  int _satisfaction = 5;
  bool _submitting = false;

  @override
  void dispose() {
    _featureController.dispose();
    _bugController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _submitting = true);

    final now = DateTime.now();
    final id = '${now.millisecondsSinceEpoch}${Random().nextInt(9999)}';

    final payload = {
      'id': id,
      'timestamp': DateFormat('yyyy-MM-dd HH:mm:ss').format(now),
      'feature_suggestion': _featureController.text.trim(),
      'bug_report': _bugController.text.trim(),
      'satisfaction': _satisfaction,
    };

    try {
      await FeedbackStorage.saveFeedback(payload);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Terima kasih atas feedback Anda')),
        );
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal menyimpan feedback: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Feedback & Survey')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Saran Fitur', style: textStyle.titleMedium),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _featureController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    hintText: 'Tuliskan saran fitur (opsional)',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),

                Text('Laporan Bug', style: textStyle.titleMedium),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _bugController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    hintText: 'Jelaskan langkah, hasil, dan harapan (opsional)',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),

                Text('Tingkat Kepuasan', style: textStyle.titleMedium),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(5, (i) {
                    final v = i + 1;
                    return ChoiceChip(
                      label: Text('$v'),
                      selected: _satisfaction == v,
                      onSelected: (_) => setState(() => _satisfaction = v),
                    );
                  }),
                ),
                const SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _submitting ? null : _submit,
                    child: _submitting
                        ? const SizedBox(
                            height: 18,
                            width: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('Kirim Feedback'),
                  ),
                ),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () async {
                    final all = await FeedbackStorage.allFeedbacks();
                    if (!mounted) return;
                    showDialog(
                      context: context,
                      builder: (c) => AlertDialog(
                        title: const Text('Contoh Data Tersimpan'),
                        content: SizedBox(
                          width: double.maxFinite,
                          child: SingleChildScrollView(
                            child: Text(all.isEmpty ? 'Belum ada' : all.reversed.take(5).map((e) => e.toString()).join('\n\n')),
                          ),
                        ),
                        actions: [
                          TextButton(onPressed: () => Navigator.pop(c), child: const Text('Tutup')),
                        ],
                      ),
                    );
                  },
                  child: const Text('Lihat sampel data tersimpan'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
