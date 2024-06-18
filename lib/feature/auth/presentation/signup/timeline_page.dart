import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:timelines/timelines.dart';

class TimelinePage extends StatelessWidget {
  final String username;
  final String status;

  const TimelinePage({
    Key? key,
    required this.username,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Timeline'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Welcome, $username',
              style: Theme.of(context).textTheme.headline4?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
            ),
            const SizedBox(height: 16),
            Text(
              'Your current status: $status',
              style: Theme.of(context).textTheme.subtitle1?.copyWith(
                    fontStyle: FontStyle.italic,
                    color: Colors.grey[700],
                  ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Timeline.tileBuilder(
                scrollDirection: Axis.horizontal,
                builder: TimelineTileBuilder.connected(
                  connectionDirection: ConnectionDirection.before,
                  connectorBuilder: (context, index, type) {
                    return SolidLineConnector(
                      color: _getColor(index),
                    );
                  },
                  indicatorBuilder: (context, index) {
                    return DotIndicator(
                      color: _getColor(index),
                    );
                  },
                  contentsBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Text(
                      _getStepLabel(index),
                      style: TextStyle(
                        color: _getColor(index),
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  itemCount: 3,
                ),
              ),
            ),
            const Gap(30),
            Center(
              child: SizedBox(
                width: double.infinity,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 50.0),
                  child: ElevatedButton(
                    onPressed: () {
                      context.go('/home-job-hunter');
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      textStyle: const TextStyle(fontSize: 18),
                    ),
                    child: const Text('Next'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getStepLabel(int index) {
    switch (index) {
      case 0:
        return 'Register';
      case 1:
        return 'Registered';
      case 2:
        return 'ACTIVE';
      case 3:
        return 'Settled';
      default:
        return '';
    }
  }

  Color _getColor(int index) {
    switch (index) {
      case 0:
        return status == 'REGISTER' ? Colors.blue : Colors.grey;
      case 1:
        return status == 'REGISTERED' ? Colors.blue : Colors.grey;
      case 2:
        return status == 'ACTIVE' ? Colors.blue : Colors.grey;
      case 3:
        return status == 'SETTLED' ? Colors.blue : Colors.grey;
      default:
        return Colors.grey;
    }
  }
}
