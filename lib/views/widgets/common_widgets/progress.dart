import 'package:flutter/material.dart';

class Progress extends StatefulWidget {
  final bool requiredColorChange;
  final double thickness;
  final double value;
  final Color bgColor;
  final Color progressColor;
  Progress(
    this.value, {
    this.thickness = 6.0,
    this.requiredColorChange = true,
    this.bgColor = const Color(0xffd7e9ed),
    this.progressColor = const Color(0xff74d5df),
  });

  @override
  _ProgressState createState() => _ProgressState();
}

class _ProgressState extends State<Progress>
    with SingleTickerProviderStateMixin {
  Animation<double> _animation;
  AnimationController _controller;
  Tween<double> _tween;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 2000),
    );

    _tween = Tween<double>(begin: 0.0, end: widget.value);

    _animation = _tween.animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _controller.forward();
  }

  _changeVal() {
    _controller.reset();
    _tween.begin = _tween.end;
    _tween.end = widget.value;
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    if (_tween.end != widget.value) {
      _changeVal();
    }

    return Container(
      width: MediaQuery.of(context).size.width,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return CustomPaint(
            painter: ProgressPainter(
              _animation.value,
              widget.thickness,
              widget.requiredColorChange,
              widget.bgColor,
              widget.progressColor,
            ),
            child: Container(),
          );
        },
      ),
    );
  }
}

class ProgressPainter extends CustomPainter {
  final double value;
  final double thickness;
  final bool requiredColorChange;
  final Color bgColor;
  final Color progressColor;

  ProgressPainter(
    this.value,
    this.thickness,
    this.requiredColorChange,
    this.bgColor,
    this.progressColor,
  );

  @override
  void paint(Canvas canvas, Size size) {
    final _progressValue = value / 100 * size.width;

    final _progressPaint = Paint()
      ..color = requiredColorChange && value <= 50
          ? Color(0xfffbad30)
          : progressColor
      ..strokeCap = StrokeCap.round
      ..strokeWidth = thickness;

    final _progressBGPaint = Paint()
      ..color = bgColor.withOpacity(0.5)
      ..strokeCap = StrokeCap.round
      ..strokeWidth = thickness;

    final _startPoint = Offset(0, size.height / 2);
    final _endPoint = Offset(_progressValue, size.height / 2);

    final _endBGPoint = Offset(size.width, size.height / 2);

    canvas.drawLine(_startPoint, _endBGPoint, _progressBGPaint);
    canvas.drawLine(_startPoint, _endPoint, _progressPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
