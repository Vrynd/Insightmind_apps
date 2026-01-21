# 📊 Chart Feature - Complete Guide

## Overview

Fitur chart/grafik sederhana telah ditambahkan ke aplikasi InsightMind. Grafik ini memudahkan visualisasi data screening mental health dan tracking mood.

## ✨ Fitur yang Ditambahkan

### 3 Tipe Grafik
1. **Line Chart** - Menampilkan tren data (mood, skor)
2. **Bar Chart** - Menampilkan perbandingan kategori
3. **Pie Chart** - Menampilkan distribusi/proporsi

### 2 Widget Baru
1. **SimpleLineChart** - Interactive line chart dengan gradient
2. **SimpleBarChart** - Bar chart untuk kategori
3. **SimplePieChart** - Pie chart dengan legend
4. **StatisticsCard** - Card untuk menampilkan statistik ringkas

## 📁 File yang Dibuat

```
lib/features/insightmind/presentation/
├── providers/
│   └── chart_provider.dart              ← Data provider
├── widgets/
│   └── chart_widgets.dart               ← Chart widgets
└── screen/
    └── chart_demo_screen.dart           ← Demo screen
```

## 📊 Sudah Terintegrasi

✅ **Statistics Screen** - Ditambah:
- Summary statistics cards (Total, Rata-rata, Kategori)
- Weekly mood line chart
- Distribution pie chart

## 🚀 Cara Menggunakan

### 1. Line Chart - untuk tren data

```dart
import 'package:insightmind_app/features/insightmind/presentation/widgets/chart_widgets.dart';

SimpleLineChart(
  title: 'Weekly Mood',
  data: [
    ChartDataPoint(label: 'Mon', value: 6.5),
    ChartDataPoint(label: 'Tue', value: 7.2),
    // ... lebih banyak data
  ],
)
```

### 2. Bar Chart - untuk perbandingan

```dart
SimpleBarChart(
  title: 'Monthly Progress',
  data: [
    ChartDataPoint(label: 'Week 1', value: 6.2),
    ChartDataPoint(label: 'Week 2', value: 6.8),
    ChartDataPoint(label: 'Week 3', value: 7.1),
    ChartDataPoint(label: 'Week 4', value: 7.6),
  ],
)
```

### 3. Pie Chart - untuk distribusi

```dart
SimplePieChart(
  title: 'Health Distribution',
  data: [
    (name: 'Healthy', percentage: 45),
    (name: 'Mild', percentage: 30),
    (name: 'Moderate', percentage: 20),
    (name: 'Severe', percentage: 5),
  ],
)
```

### 4. Statistics Card - untuk ringkas

```dart
StatisticsCard(
  title: 'Average Score',
  value: '7.5',
  icon: Icons.trending_up,
  subtitle: '+15% improvement',
  backgroundColor: Colors.blue,
)
```

## 🎨 Customization

### Ubah Warna

```dart
SimpleLineChart(
  title: 'My Chart',
  data: data,
  // Warna otomatis mengikuti theme (primary color)
)
```

### Tampilkan/Sembunyikan Grid

```dart
SimpleLineChart(
  data: data,
  showGrid: false,  // ← Sembunyikan grid
)
```

## 📚 Data Provider

Semua provider ada di `chart_provider.dart`:

```dart
// Sample chart data
final sampleChartDataProvider = Provider<List<ChartDataSet>>((ref) { ... });

// Weekly mood data
final weeklyMoodProvider = Provider<List<ChartDataPoint>>((ref) { ... });

// Monthly progress
final monthlyProgressProvider = Provider<List<ChartDataPoint>>((ref) { ... });

// Health category distribution
final healthCategoryProvider = Provider<List<({String name, double percentage})>>((ref) { ... });

// Screening statistics
final screeningStatsProvider = Provider<Map<String, dynamic>>((ref) { ... });
```

## 🧪 Demo Screen

Untuk melihat semua chart dalam aksi, buka:
```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => const ChartDemoScreen(),
  ),
);
```

## 📐 Model Data

### ChartDataPoint
```dart
class ChartDataPoint {
  final String label;      // Label di X-axis
  final double value;      // Nilai di Y-axis
  final int? timestamp;    // Optional timestamp
}
```

### ChartDataSet
```dart
class ChartDataSet {
  final String title;
  final List<ChartDataPoint> data;
  final DateTime date;
  
  // Helper methods
  double get maxValue;        // Nilai max di dataset
  double get minValue;        // Nilai min di dataset
  double get averageValue;    // Rata-rata
}
```

## 💡 Use Cases

### 1. Mood Tracking
Gunakan line chart untuk menampilkan perkembangan mood harian/mingguan
```dart
SimpleLineChart(
  title: 'Mood Tracking',
  data: moodData,
)
```

### 2. Progress Comparison
Gunakan bar chart untuk bandingkan progress antar periode
```dart
SimpleBarChart(
  title: 'Monthly Progress',
  data: progressData,
)
```

### 3. Risk Distribution
Gunakan pie chart untuk tampilkan proporsi kategori risiko
```dart
SimplePieChart(
  title: 'Risk Distribution',
  data: riskData,
)
```

### 4. Quick Stats
Gunakan statistics card untuk ringkasan
```dart
StatisticsCard(
  title: 'Total Screenings',
  value: '12',
  icon: Icons.checklist,
)
```

## 🔄 Update Data Dinamis

Untuk update chart dengan data real dari database:

```dart
// Dari history provider (sudah ada)
final historyAsync = ref.watch(historyListProvider);

// Convert ke chart data
final chartData = historyAsync.when(
  data: (records) {
    return records.map((r) {
      return ChartDataPoint(
        label: r.timestamp.toString(),
        value: r.score.toDouble(),
      );
    }).toList();
  },
  loading: () => [],
  error: (_, __) => [],
);
```

## 🎯 Integration Points

Sudah terintegrasi di:
- ✅ Statistics Screen - dengan summary cards dan charts
- ✅ Chart Demo Screen - untuk testing dan preview

Bisa ditambahkan di:
- Home Screen - quick stats
- History Screen - trend analysis
- Settings - data visualization options

## ⚙️ Dependencies

Sudah ada di pubspec.yaml:
- `fl_chart: ^1.1.1` - Chart library (lightweight)

## 📊 Performance

- ✅ Lightweight - menggunakan fl_chart yang efficient
- ✅ Reactive - otomatis rebuild saat data berubah (via Riverpod)
- ✅ Smooth - animasi builtin
- ✅ Responsive - auto scale sesuai screen size

## 🧪 Testing

Lihat chart demo di chart_demo_screen.dart dengan berbagai tipe data:
- Weekly mood (line chart)
- Monthly progress (bar chart)
- Health category (pie chart)
- Statistics cards

## 📝 Tips

1. **Gunakan ChartDataPoint untuk data simple**
   - label: String
   - value: double (0-10 recommended)

2. **Gunakan ChartDataSet untuk data kompleks**
   - Includes title, date, max/min/average helpers

3. **Warna otomatis dari theme**
   - Primary untuk line charts
   - Secondary/tertiary untuk variants

4. **Grid untuk readability**
   - Tampilkan grid untuk data yang kompleks
   - Sembunyikan untuk tampilan lebih clean

## 🚀 Next Steps

1. **Connect to real data** - Update providers dengan data dari database
2. **Add more analytics** - Tambah trend analysis, predictions
3. **Custom colors** - Option untuk custom color schemes
4. **Export data** - Combine dengan PDF export yang sudah ada

---

**Status:** ✅ Production Ready  
**Library:** fl_chart (included in pubspec.yaml)  
**Last Updated:** 2026-01-21
