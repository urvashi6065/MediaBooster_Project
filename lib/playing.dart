import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PositionSeekWidget extends StatefulWidget {
  final Duration currentPosition;
  final Duration duration;
  final Function(Duration) seekTo;

  const PositionSeekWidget({
    required this.currentPosition,
    required this.duration,
    required this.seekTo,
  });

  @override
  _PositionSeekWidgetState createState() => _PositionSeekWidgetState();
}

class _PositionSeekWidgetState extends State<PositionSeekWidget> {
  late Duration _visibleValue;
  bool listenOnlyUserInterraction = false;

  double get percent => widget.duration.inMilliseconds == 0
      ? 0
      : _visibleValue.inMilliseconds / widget.duration.inMilliseconds;

  @override
  void initState() {
    super.initState();
    _visibleValue = widget.currentPosition;
  }

  @override
  void didUpdateWidget(PositionSeekWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!listenOnlyUserInterraction) {
      _visibleValue = widget.currentPosition;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: 40,
            child: Text(durationToString(widget.currentPosition),style: TextStyle(color: Colors.white),),
          ),
          Expanded(
            child: Slider(
                min: 0,
                max: widget.duration.inMilliseconds.toDouble(),
                value: percent * widget.duration.inMilliseconds.toDouble(),
                onChangeEnd: (newValue) {
                  setState(() {
                    listenOnlyUserInterraction = false;
                    widget.seekTo(_visibleValue);
                  });
                },
                onChangeStart: (_) {
                  setState(() {
                    listenOnlyUserInterraction = true;
                  });
                },
                onChanged: (value) {
                  setState(() {
                    final to = Duration(milliseconds: value.floor());
                    _visibleValue = to;
                  });
                }),

          ),
          SizedBox(
            width: 40,
            child: Text(durationToString(widget.duration),style: TextStyle(color: Colors.white),),
          ),
        ],
      ),
    );
  }
}

String durationToString(Duration duration) {
  String twoDigits(int n) {
    if (n >= 10) return '$n';
    return '0$n';
  }

  final twoDigitMinutes =
      twoDigits(duration.inMinutes.remainder(Duration.minutesPerHour));
  final twoDigitSeconds =
      twoDigits(duration.inSeconds.remainder(Duration.secondsPerMinute));
  return '$twoDigitMinutes:$twoDigitSeconds';
}
