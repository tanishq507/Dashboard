import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:garduino_dashboard/responsive.dart';
import 'package:garduino_dashboard/widgets/custom_card.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

String _formatData(Map<String, dynamic> data) {
  return '''
    CPU Cores: ${data['cpu_cores']}
    CPU Frequency: ${data['cpu_freq']}
    CPU Usage: ${data['cpu_usage']}%
    Disk Free: ${data['disk_free']} MB
    Disk Total: ${data['disk_total']} MB
    Disk Used: ${data['disk_used']} MB
    Memory Available: ${data['memory_available']} MB
    Memory Percent: ${data['memory_percent']}%
    Memory Total: ${data['memory_total']} MB
    Memory Used: ${data['memory_used']} MB
    ''';
}

class CircularBuffer<T> {
  final int _maxLength;
  final List<T> _buffer;

  // CircularBuffer(this._maxLength) : _buffer = List<T>.empty();

  CircularBuffer(this._maxLength, [List<T>? initialElements])
      : _buffer = List<T>.from(initialElements ?? []) {
    if (_buffer.length > _maxLength) {
      _buffer.removeRange(0, _buffer.length - _maxLength);
    }
  }

  void add(T element) {
    if (_buffer.length == _maxLength) {
      _buffer.removeAt(0);
    }
    _buffer.add(element);
  }

  List<T> get buffer => _buffer;

  void addd(T element) {
    if (_buffer.isEmpty) {
      _buffer.add(element);
    } else if (_buffer.length == _maxLength) {
      _buffer.removeAt(0);
      _buffer.add(element);
    } else {
      _buffer.add(element);
    }
  }
}

class LineChartCard extends StatefulWidget {
  @override
  _LineChartCardState createState() => _LineChartCardState();
}

class _LineChartCardState extends State<LineChartCard> {
  String _receivedData = 'Fetching data...';

  @override
  void initState() {
    super.initState();
    startFetchingData();
  }

  Future<void> fetchData() async {
    final response =
        await http.get(Uri.parse('http://192.168.38.169:5000/api/sysinfo'));

    if (response.statusCode == 200) {
      // Process the JSON data
      Map<String, dynamic> data = jsonDecode(response.body);
      debugPrint(data['cpu_usage'].toString());
    } else {
      // Handle the error
      debugPrint('Request failed with status: ${response.statusCode}');
    }
  }

  void startFingData() async {
    final url = 'https://your-api-url.com/data'; // Replace with your API URL
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      setState(() {
        _receivedData = _formatData(jsonData);
      });
    } else {
      setState(() {
        _receivedData = 'Failed to load data';
      });
    }
  }

  void startFetchingData() {
    Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      fetchData();
    });
  }
// /////////////////////////////////////////

// class LineChartCard extends StatelessWidget {
//   LineChartCard({super.key});

  CircularBuffer<FlSpot> spots = CircularBuffer<FlSpot>(
    43,
    [
      FlSpot(1.68, 21.04),
      FlSpot(2.84, 26.23),
      FlSpot(5.19, 19.82),
      FlSpot(6.01, 24.49),
      FlSpot(7.81, 19.82),
      FlSpot(9.49, 23.50),
      FlSpot(12.26, 19.57),
      FlSpot(15.63, 20.90),
      FlSpot(20.39, 39.20),
      FlSpot(23.69, 75.62),
      FlSpot(26.21, 46.58),
      FlSpot(29.87, 42.97),
      FlSpot(32.49, 46.54),
      FlSpot(35.09, 40.72),
      FlSpot(38.74, 43.18),
      FlSpot(41.47, 59.91),
      FlSpot(43.12, 53.18),
      FlSpot(46.30, 90.10),
      FlSpot(47.88, 81.59),
      FlSpot(51.71, 75.53),
      FlSpot(54.21, 78.95),
      FlSpot(55.23, 86.94),
      FlSpot(57.40, 78.98),
      FlSpot(60.49, 74.38),
      FlSpot(64.30, 48.34),
      FlSpot(67.17, 70.74),
      FlSpot(70.35, 75.43),
      FlSpot(73.39, 69.88),
      FlSpot(75.87, 80.04),
      FlSpot(77.32, 74.38),
      FlSpot(81.43, 68.43),
      FlSpot(86.12, 69.45),
      FlSpot(90.06, 78.60),
      FlSpot(94.68, 46.05),
      FlSpot(98.35, 42.80),
      FlSpot(101.25, 53.05),
      FlSpot(103.07, 46.06),
      FlSpot(106.65, 42.31),
      FlSpot(108.20, 32.64),
      FlSpot(110.40, 45.14),
      FlSpot(114.24, 53.27),
      FlSpot(116.60, 42.13),
      FlSpot(118.52, 57.60),
    ],
  );

  List<FlSpot> spots1 = const [
    FlSpot(1.68, 21.04),
    FlSpot(2.84, 26.23),
    FlSpot(5.19, 19.82),
    FlSpot(6.01, 24.49),
    FlSpot(7.81, 19.82),
    FlSpot(9.49, 23.50),
    FlSpot(12.26, 19.57),
    FlSpot(15.63, 20.90),
    FlSpot(20.39, 39.20),
    FlSpot(23.69, 75.62),
    FlSpot(26.21, 46.58),
    FlSpot(29.87, 42.97),
    FlSpot(32.49, 46.54),
    FlSpot(35.09, 40.72),
    FlSpot(38.74, 43.18),
    FlSpot(41.47, 59.91),
    FlSpot(43.12, 53.18),
    FlSpot(46.30, 90.10),
    FlSpot(47.88, 81.59),
    FlSpot(51.71, 75.53),
    FlSpot(54.21, 78.95),
    FlSpot(55.23, 86.94),
    FlSpot(57.40, 78.98),
    FlSpot(60.49, 74.38),
    FlSpot(64.30, 48.34),
    FlSpot(67.17, 70.74),
    FlSpot(70.35, 75.43),
    FlSpot(73.39, 69.88),
    FlSpot(75.87, 80.04),
    FlSpot(77.32, 74.38),
    FlSpot(81.43, 68.43),
    FlSpot(86.12, 69.45),
    FlSpot(90.06, 78.60),
    FlSpot(94.68, 46.05),
    FlSpot(98.35, 42.80),
    FlSpot(101.25, 53.05),
    FlSpot(103.07, 46.06),
    FlSpot(106.65, 42.31),
    FlSpot(108.20, 32.64),
    FlSpot(110.40, 45.14),
    FlSpot(114.24, 53.27),
    FlSpot(116.60, 42.13),
    FlSpot(118.52, 57.60),
  ];

  final leftTitle = {
    0: '34.0°C',
    20: '34.5°C',
    40: '35.2°C',
    60: '36.5°C',
    80: '37°C',
    100: '39.3°C'
  };
  final bottomTitle = {
    0: 'Jan',
    10: 'Feb',
    20: 'Mar',
    30: 'Apr',
    40: 'May',
    50: 'Jun',
    60: 'Jul',
    70: 'Aug',
    80: 'Sep',
    90: 'Oct',
    100: 'Nov',
    110: 'Dec',
  };

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Garden Temperature Overview",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 20,
          ),
          AspectRatio(
            aspectRatio: Responsive.isMobile(context) ? 9 / 4 : 16 / 6,
            child: LineChart(
              LineChartData(
                lineTouchData: LineTouchData(
                  handleBuiltInTouches: true,
                ),
                gridData: FlGridData(show: false),
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 32,
                      interval: 1,
                      getTitlesWidget: (double value, TitleMeta meta) {
                        return bottomTitle[value.toInt()] != null
                            ? SideTitleWidget(
                                axisSide: meta.axisSide,
                                space: 10,
                                child: Text(
                                    bottomTitle[value.toInt()].toString(),
                                    style: TextStyle(
                                        fontSize: Responsive.isMobile(context)
                                            ? 9
                                            : 12,
                                        color: Colors.grey[400])),
                              )
                            : const SizedBox();
                      },
                    ),
                  ),
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      getTitlesWidget: (double value, TitleMeta meta) {
                        return leftTitle[value.toInt()] != null
                            ? Text(leftTitle[value.toInt()].toString(),
                                style: TextStyle(
                                    fontSize:
                                        Responsive.isMobile(context) ? 9 : 12,
                                    color: Colors.grey[400]))
                            : const SizedBox();
                      },
                      showTitles: true,
                      interval: 1,
                      reservedSize: 40,
                    ),
                  ),
                ),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                      isCurved: true,
                      curveSmoothness: 0,
                      color: Theme.of(context).primaryColor,
                      barWidth: 2.5,
                      isStrokeCapRound: true,
                      belowBarData: BarAreaData(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Theme.of(context).primaryColor.withOpacity(0.5),
                            Colors.transparent
                          ],
                        ),
                        show: true,
                        color: Theme.of(context).primaryColor.withOpacity(0.5),
                      ),
                      dotData: FlDotData(show: false),
                      spots: spots.buffer)
                ],
                minX: 0,
                maxX: 120,
                maxY: 105,
                minY: -5,
              ),
              swapAnimationDuration: const Duration(milliseconds: 250),
            ),
          ),
        ],
      ),
    );
  }
}
