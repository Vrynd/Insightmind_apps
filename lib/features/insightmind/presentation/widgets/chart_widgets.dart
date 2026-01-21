import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:insightmind_app/features/insightmind/presentation/providers/chart_provider.dart';

/// Simple Line Chart - Mood Tracking
class SimpleLineChart extends StatelessWidget {
  final List<ChartDataPoint> data;
  final String title;
  final bool showGrid;

  const SimpleLineChart({
    super.key,
    required this.data,
    this.title = 'Chart',
    this.showGrid = true,
  });

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    if (data.isEmpty) {
      return Center(
        child: Text(
          'No data available',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
            child: Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        SizedBox(
          height: 300,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: showGrid,
                  drawVerticalLine: true,
                  horizontalInterval: 2,
                  verticalInterval: 1,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: color.outlineVariant.withOpacity(0.5),
                      strokeWidth: 1,
                    );
                  },
                  getDrawingVerticalLine: (value) {
                    return FlLine(
                      color: color.outlineVariant.withOpacity(0.5),
                      strokeWidth: 1,
                    );
                  },
                ),
                titlesData: FlTitlesData(
                  show: true,
                  rightTitles: const AxisTitles(),
                  topTitles: const AxisTitles(),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 1,
                      getTitlesWidget: (value, meta) {
                        if (value.toInt() >= data.length) {
                          return const Text('');
                        }
                        return Text(
                          data[value.toInt()].label,
                          style: Theme.of(context).textTheme.labelSmall,
                        );
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 2,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          '${value.toInt()}',
                          style: Theme.of(context).textTheme.labelSmall,
                        );
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(show: true),
                minX: 0,
                maxX: (data.length - 1).toDouble(),
                minY: 0,
                maxY: 10,
                lineBarsData: [
                  LineChartBarData(
                    spots: List.generate(
                      data.length,
                      (index) => FlSpot(index.toDouble(), data[index].value),
                    ),
                    isCurved: true,
                    gradient: LinearGradient(
                      colors: [
                        color.primary.withOpacity(0.8),
                        color.primary.withOpacity(0.3),
                      ],
                    ),
                    barWidth: 3,
                    isStrokeCapRound: true,
                    dotData: FlDotData(
                      show: true,
                      getDotPainter: (spot, percent, barData, index) {
                        return FlDotCirclePainter(
                          radius: 4,
                          color: color.primary,
                          strokeWidth: 2,
                          strokeColor: Colors.white,
                        );
                      },
                    ),
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        colors: [
                          color.primary.withOpacity(0.3),
                          color.primary.withOpacity(0.0),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// Bar Chart - Category Distribution
class SimpleBarChart extends StatelessWidget {
  final List<ChartDataPoint> data;
  final String title;

  const SimpleBarChart({
    super.key,
    required this.data,
    this.title = 'Chart',
  });

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    if (data.isEmpty) {
      return Center(
        child: Text(
          'No data available',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
            child: Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        SizedBox(
          height: 300,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: data.map((e) => e.value).reduce((a, b) => a > b ? a : b) + 1,
                barGroups: List.generate(
                  data.length,
                  (index) => BarChartGroupData(
                    x: index,
                    barRods: [
                      BarChartRodData(
                        toY: data[index].value,
                        color: color.primary,
                        width: 16,
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(6),
                        ),
                      ),
                    ],
                  ),
                ),
                titlesData: FlTitlesData(
                  show: true,
                  topTitles: const AxisTitles(),
                  rightTitles: const AxisTitles(),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          data[value.toInt()].label,
                          style: Theme.of(context).textTheme.labelSmall,
                        );
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 1,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          '${value.toInt()}',
                          style: Theme.of(context).textTheme.labelSmall,
                        );
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(show: false),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// Pie Chart - Distribution
class SimplePieChart extends StatefulWidget {
  final List<({String name, double percentage})> data;
  final String title;

  const SimplePieChart({
    super.key,
    required this.data,
    this.title = 'Chart',
  });

  @override
  State<SimplePieChart> createState() => _SimplePieChartState();
}

class _SimplePieChartState extends State<SimplePieChart> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    if (widget.data.isEmpty) {
      return Center(
        child: Text(
          'No data available',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      );
    }

    final colors = [
      color.primary,
      color.secondary,
      color.tertiary,
      color.error,
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 16.0, bottom: 8.0),
            child: Text(
              widget.title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        SizedBox(
          height: 280,
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: PieChart(
                  PieChartData(
                    sections: List.generate(
                      widget.data.length,
                      (index) {
                        final isSelected = touchedIndex == index;
                        return PieChartSectionData(
                          value: widget.data[index].percentage,
                          color: colors[index % colors.length],
                          radius: isSelected ? 60 : 50,
                          titleStyle: Theme.of(context).textTheme.labelSmall?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                          title: '${widget.data[index].percentage.toStringAsFixed(1)}%',
                        );
                      },
                    ),
                    pieTouchData: PieTouchData(
                      touchCallback: (FlTouchEvent event, pieTouchResponse) {
                        setState(() {
                          if (pieTouchResponse == null) {
                            touchedIndex = -1;
                            return;
                          }
                          touchedIndex = pieTouchResponse.touchedSection?.touchedSectionIndex ?? -1;
                        });
                      },
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(
                      widget.data.length,
                      (index) => Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                          children: [
                            Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                color: colors[index % colors.length],
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                widget.data[index].name,
                                style: Theme.of(context).textTheme.labelSmall,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Statistics Card - Summary Info
class StatisticsCard extends StatelessWidget {
  final String title;
  final String value;
  final String? subtitle;
  final IconData icon;
  final Color? backgroundColor;

  const StatisticsCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    this.subtitle,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: backgroundColor ?? color.primaryContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: backgroundColor != null
                    ? Colors.white
                    : color.onPrimaryContainer,
                size: 28,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: color.onSurfaceVariant,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      subtitle!,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: color.primary,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ]
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
