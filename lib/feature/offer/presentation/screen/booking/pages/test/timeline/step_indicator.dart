import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:timelines/timelines.dart';
import 'bezier_painter.dart';

const completeColor = Color(0xff5e6172);
const inProgressColor = Color(0xff5ec792);
const todoColor = Color(0xffd1d2d7);

class StepIndicator extends StatelessWidget {
  final int processIndex;
  final bool isLoading;
  final String title;
  final VoidCallback onPress;

  const StepIndicator({
    Key? key,
    required this.processIndex,
    required this.isLoading,
    required this.onPress,
    required this.title,
  }) : super(key: key);

  Color getColor(int index) {
    if (index < processIndex) {
      return completeColor;
    } else if (index == processIndex) {
      return inProgressColor;
    } else {
      return todoColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero, // Remove margin to make the Card touch the edges
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(
            10), // Remove padding to make Timeline touch the edges
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LayoutBuilder(
              builder: (context, constraints) {
                double itemWidth = constraints.maxWidth / _processes.length;
                return IntrinsicHeight(
                  child: FixedTimeline.tileBuilder(
                    direction: Axis.horizontal,
                    builder: TimelineTileBuilder.connected(
                      connectionDirection: ConnectionDirection.before,
                      itemCount: _processes.length,
                      itemExtent: itemWidth,
                      contentsBuilder: (context, index) {
                        return Center(
                          child: Text(
                            _processes[index],
                            style: TextStyle(
                              fontSize: 12,
                              color: getColor(index),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        );
                      },
                      indicatorBuilder: (_, index) {
                        var color;
                        var child;
                        if (index == processIndex && isLoading) {
                          color = inProgressColor;
                          child = const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CircularProgressIndicator(
                              strokeWidth: 3.0,
                              valueColor: AlwaysStoppedAnimation(Colors.white),
                            ),
                          );
                        } else if (index <= processIndex) {
                          color = completeColor;
                          child = Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 15.0,
                          );
                        } else {
                          color = todoColor;
                          child = null;
                        }

                        if (index <= processIndex) {
                          return Stack(
                            children: [
                              CustomPaint(
                                size: Size(30.0, 30.0),
                                painter: BezierPainter(
                                  color: color,
                                  drawStart: index > 0,
                                  drawEnd: index < processIndex,
                                ),
                              ),
                              DotIndicator(
                                size: 30.0,
                                color: color,
                                child: child,
                              ),
                            ],
                          );
                        } else {
                          return Stack(
                            children: [
                              CustomPaint(
                                size: Size(15.0, 15.0),
                                painter: BezierPainter(
                                  color: color,
                                  drawEnd: index < _processes.length - 1,
                                ),
                              ),
                              OutlinedDotIndicator(
                                borderWidth: 4.0,
                                color: color,
                              ),
                            ],
                          );
                        }
                      },
                      connectorBuilder: (_, index, type) {
                        if (index > 0) {
                          if (index == processIndex) {
                            final prevColor = getColor(index - 1);
                            final color = getColor(index);
                            List<Color> gradientColors;
                            if (type == ConnectorType.start) {
                              gradientColors = [
                                Color.lerp(prevColor, color, 0.5)!,
                                color
                              ];
                            } else {
                              gradientColors = [
                                prevColor,
                                Color.lerp(prevColor, color, 0.5)!
                              ];
                            }
                            return DecoratedLineConnector(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: gradientColors,
                                ),
                              ),
                            );
                          } else {
                            return SolidLineConnector(
                              color: getColor(index),
                            );
                          }
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                );
              },
            ),
            const Gap(16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                SizedBox(
                  width: 100,
                  height: 30,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.zero),
                      foregroundColor: MaterialStateProperty.all(Colors.teal),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                    ),
                    onPressed: isLoading ? null : onPress,
                    child: const Text(
                      'ຢືນຢັນ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

const _processes = [
  'ເດີນທາງ',
  'ເຖິງສະຖານທີ',
  'ເລີ່ມວຽກ',
  'ສໍາເລັດວຽກ',
];
