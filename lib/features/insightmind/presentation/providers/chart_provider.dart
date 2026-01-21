import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Model untuk data point pada chart
class ChartDataPoint {
  final String label;
  final double value;
  final int? timestamp;

  ChartDataPoint({
    required this.label,
    required this.value,
    this.timestamp,
  });
}

/// Model untuk dataset chart
class ChartDataSet {
  final String title;
  final List<ChartDataPoint> data;
  final DateTime date;

  ChartDataSet({
    required this.title,
    required this.data,
    DateTime? date,
  }) : date = date ?? DateTime.now();

  double get maxValue {
    if (data.isEmpty) return 0;
    return data.map((e) => e.value).reduce((a, b) => a > b ? a : b);
  }

  double get minValue {
    if (data.isEmpty) return 0;
    return data.map((e) => e.value).reduce((a, b) => a < b ? a : b);
  }

  double get averageValue {
    if (data.isEmpty) return 0;
    return data.map((e) => e.value).reduce((a, b) => a + b) / data.length;
  }
}

/// Provider untuk sample chart data (mental health screening)
final sampleChartDataProvider = Provider<List<ChartDataSet>>((ref) {
  return [
    // Mood tracking data
    ChartDataSet(
      title: 'Mood Harian',
      data: [
        ChartDataPoint(label: 'Mon', value: 6.5),
        ChartDataPoint(label: 'Tue', value: 7.2),
        ChartDataPoint(label: 'Wed', value: 5.8),
        ChartDataPoint(label: 'Thu', value: 7.5),
        ChartDataPoint(label: 'Fri', value: 8.0),
        ChartDataPoint(label: 'Sat', value: 8.2),
        ChartDataPoint(label: 'Sun', value: 7.8),
      ],
      date: DateTime.now().subtract(const Duration(days: 7)),
    ),
    // Stress level
    ChartDataSet(
      title: 'Level Stres',
      data: [
        ChartDataPoint(label: 'Week 1', value: 6.5),
        ChartDataPoint(label: 'Week 2', value: 5.8),
        ChartDataPoint(label: 'Week 3', value: 6.2),
        ChartDataPoint(label: 'Week 4', value: 5.0),
      ],
      date: DateTime.now(),
    ),
  ];
});

/// Provider untuk screening history statistics
final screeningStatsProvider = Provider<Map<String, dynamic>>((ref) {
  return {
    'totalScreenings': 12,
    'averageScore': 7.4,
    'improvementRate': 15.5, // percentage
    'consistencyDays': 8, // days in a row
    'categories': {
      'Healthy': 5,
      'Mild': 4,
      'Moderate': 2,
      'Severe': 1,
    }
  };
});

/// Provider untuk weekly mood data
final weeklyMoodProvider = Provider<List<ChartDataPoint>>((ref) {
  return [
    ChartDataPoint(label: 'Mon', value: 6.5, timestamp: 0),
    ChartDataPoint(label: 'Tue', value: 7.2, timestamp: 1),
    ChartDataPoint(label: 'Wed', value: 5.8, timestamp: 2),
    ChartDataPoint(label: 'Thu', value: 7.5, timestamp: 3),
    ChartDataPoint(label: 'Fri', value: 8.0, timestamp: 4),
    ChartDataPoint(label: 'Sat', value: 8.2, timestamp: 5),
    ChartDataPoint(label: 'Sun', value: 7.8, timestamp: 6),
  ];
});

/// Provider untuk monthly progress data
final monthlyProgressProvider = Provider<List<ChartDataPoint>>((ref) {
  return [
    ChartDataPoint(label: 'Week 1', value: 6.2),
    ChartDataPoint(label: 'Week 2', value: 6.8),
    ChartDataPoint(label: 'Week 3', value: 7.1),
    ChartDataPoint(label: 'Week 4', value: 7.6),
  ];
});

/// Provider untuk health category distribution
final healthCategoryProvider = Provider<List<({String name, double percentage})>>((ref) {
  return [
    (name: 'Sehat', percentage: 45),
    (name: 'Ringan', percentage: 30),
    (name: 'Sedang', percentage: 20),
    (name: 'Berat', percentage: 5),
  ];
});
