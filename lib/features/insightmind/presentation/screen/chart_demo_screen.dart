import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insightmind_app/features/insightmind/presentation/providers/chart_provider.dart';
import 'package:insightmind_app/features/insightmind/presentation/widgets/chart_widgets.dart';

/// Demo screen untuk menampilkan berbagai tipe chart
class ChartDemoScreen extends ConsumerWidget {
  const ChartDemoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weeklyMood = ref.watch(weeklyMoodProvider);
    final monthlyProgress = ref.watch(monthlyProgressProvider);
    final healthCategory = ref.watch(healthCategoryProvider);
    final screeningStats = ref.watch(screeningStatsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Demo Chart'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Statistics Cards
            Text(
              'Statistics Summary',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            StatisticsCard(
              title: 'Total Screenings',
              value: '${screeningStats['totalScreenings']}',
              icon: Icons.checklist_rtl,
            ),
            const SizedBox(height: 8),
            StatisticsCard(
              title: 'Average Score',
              value: '${screeningStats['averageScore']}',
              icon: Icons.trending_up,
              subtitle: '${screeningStats['improvementRate']}% improvement',
            ),
            const SizedBox(height: 8),
            StatisticsCard(
              title: 'Consistency',
              value: '${screeningStats['consistencyDays']} days',
              icon: Icons.calendar_today,
              subtitle: 'in a row',
            ),
            const SizedBox(height: 32),

            // Line Chart - Weekly Mood
            Text(
              'Line Chart Example',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            Card(
              child: SimpleLineChart(
                title: 'Weekly Mood Trend',
                data: weeklyMood,
              ),
            ),
            const SizedBox(height: 32),

            // Bar Chart - Monthly Progress
            Text(
              'Bar Chart Example',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            Card(
              child: SimpleBarChart(
                title: 'Monthly Progress',
                data: monthlyProgress,
              ),
            ),
            const SizedBox(height: 32),

            // Pie Chart - Health Category Distribution
            Text(
              'Pie Chart Example',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            Card(
              child: SimplePieChart(
                title: 'Health Category Distribution',
                data: healthCategory,
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
