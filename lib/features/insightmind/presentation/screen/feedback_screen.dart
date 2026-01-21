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

    try {
      await FeedbackStorage.saveFeedback(
        id: id,
        timestamp: now,
        featureSuggestion: _featureController.text.trim(),
        bugReport: _bugController.text.trim(),
        satisfactionLevel: _satisfaction,
      );
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Terima kasih atas feedback Anda')),
        );
        _featureController.clear();
        _bugController.clear();
        setState(() => _satisfaction = 5);
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Gagal menyimpan feedback: $e')));
      }
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme;
    final feedbacks = FeedbackStorage.allFeedbacks().reversed.toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Feedback & Survey')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              key: _formKey,
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
                      hintText:
                          'Jelaskan langkah, hasil, dan harapan (opsional)',
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
                ],
              ),
            ),
            const SizedBox(height: 32),
            const Divider(),
            const SizedBox(height: 16),
            Text('Riwayat Feedback', style: textStyle.titleLarge),
            const SizedBox(height: 16),
            feedbacks.isEmpty
                ? const Center(child: Text('Belum ada feedback yang dikirim'))
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: feedbacks.length,
                    itemBuilder: (context, index) {
                      final item = feedbacks[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    DateFormat(
                                      'dd MMM yyyy, HH:mm',
                                    ).format(item.timestamp),
                                    style: textStyle.labelSmall,
                                  ),
                                  Row(
                                    children: List.generate(
                                      5,
                                      (i) => Icon(
                                        Icons.star,
                                        size: 14,
                                        color: i < item.satisfactionLevel
                                            ? Colors.amber
                                            : Colors.grey.shade300,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              if (item.featureSuggestion.isNotEmpty) ...[
                                const SizedBox(height: 8),
                                Text(
                                  'Saran Fitur:',
                                  style: textStyle.labelLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(item.featureSuggestion),
                              ],
                              if (item.bugReport.isNotEmpty) ...[
                                const SizedBox(height: 8),
                                Text(
                                  'Laporan Bug:',
                                  style: textStyle.labelLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(item.bugReport),
                              ],
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
