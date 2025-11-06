import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

class MoodSelector extends StatefulWidget {
  final String title;
  const MoodSelector({super.key, required this.title});

  @override
  State<MoodSelector> createState() => _MoodSelectorState();
}

class _MoodSelectorState extends State<MoodSelector> {
  int? selectedEmoji;
  final List<Map<String, String>> emojis = [
    {'emoji': '😞', 'label': 'Sedih'},
    {'emoji': '😐', 'label': 'Biasa saja'},
    {'emoji': '🙂', 'label': 'Cukup baik'},
    {'emoji': '😊', 'label': 'Senang'},
    {'emoji': '🤩', 'label': 'Luar biasa'},
  ];

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            widget.title,
            style: textStyle.titleMedium?.copyWith(
              color: color.outline.withValues(alpha: 0.8),
              fontWeight: FontWeight.w600,
              height: 1.2,
              fontSize: 18.8,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: emojis.mapIndexed((index, item) {
              final isSelected = selectedEmoji == index;
              return GestureDetector(
                onTap: () => setState(() => selectedEmoji = index),
                child: Column(
                  children: [
                    AnimatedScale(
                      duration: const Duration(milliseconds: 150),
                      scale: isSelected ? 1.1 : 1.0,
                      child: ColorFiltered(
                        colorFilter: isSelected
                            ? const ColorFilter.mode(
                                Colors.transparent,
                                BlendMode.multiply,
                              )
                            : const ColorFilter.matrix(<double>[
                                0.2126,
                                0.7152,
                                0.0722,
                                0,
                                0,
                                0.2126,
                                0.7152,
                                0.0722,
                                0,
                                0,
                                0.2126,
                                0.7152,
                                0.0722,
                                0,
                                0,
                                0,
                                0,
                                0,
                                1,
                                0,
                              ]),
                        child: Text(
                          item['emoji']!,
                          style: const TextStyle(fontSize: 38),
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item['label']!,
                      style: textStyle.bodyMedium?.copyWith(
                        color: isSelected
                            ? color.primary
                            : color.outline.withValues(alpha: 0.6),
                        fontWeight: isSelected
                            ? FontWeight.w600
                            : FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
