import 'dart:math';

import 'package:flutter/material.dart';

class Goals extends StatefulWidget {
  @override
  _GoalsState createState() => _GoalsState();

  final double value;
  Goals(this.value);
}

class _GoalsState extends State<Goals> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animation;
  Tween<double> _tween;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 2000),
      vsync: this,
    )..forward();

    _tween = Tween<double>(begin: 0, end: widget.value);
    _animation = _tween.animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
  }

  _changeVal() {
    _animationController.reset();
    _tween.begin = _tween.end;
    _tween.end = widget.value;
    _animationController.forward();
  }

  @override
  void dispose() { 
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_tween.end != widget.value) {
      _changeVal();
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final _radius =
            min(constraints.maxWidth / 2, constraints.maxHeight / 2);
        return AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return CustomPaint(
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: ThemeData().canvasColor,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 30.0,
                        color: Color(0xffd7e9ed).withOpacity(0.5),
                      ),
                    ],
                  ),
                  width: _radius,
                  height: _radius,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Achieved Goals',
                        style: TextStyle(
                          fontSize: _radius > 100 ? 10.0 : 14.0,
                          color: Colors.black26,
                        ),
                      ),
                      Text(
                        '${_animation.value.toStringAsFixed(1)}%',
                        style: TextStyle(
                          fontSize: _radius > 100 ? 24.0 : 40.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              foregroundPainter:
                  GoalPainter(_animation.value, _radius / 2 + 15),
            );
          },
        );
      },
    );
  }
}

class GoalPainter extends CustomPainter {
  final value;
  final radius;
  GoalPainter(this.value, this.radius);

  @override
  void paint(Canvas canvas, Size size) {
    _paintArc(canvas, size);
    _paintDashes(canvas, size);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  _paintArc(Canvas canvas, Size size) {
    final _arcPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 15.0
      ..strokeCap = StrokeCap.round
      ..color = Color(0xff74d5df);

    final _arcBGPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 15.0
      ..strokeCap = StrokeCap.round
      ..color = Color(0xffd7e9ed).withOpacity(0.5);

    final _center = Offset(size.width / 2, size.height / 2);
    final _radius = min(size.width / 2 - 20, size.height / 2 - 20);

    final _arcAngle = (value / 100) * 2 * pi;

    canvas.drawArc(Rect.fromCircle(center: _center, radius: _radius),
        -pi / 2 + 0.1, 2 * pi - 0.2, false, _arcBGPaint);
    canvas.drawArc(
        Rect.fromCircle(center: _center, radius: _radius),
        -pi / 2 + 0.1,
        _arcAngle >= (2 * pi - 0.2) ? 2 * pi - 0.2 : _arcAngle,
        false,
        _arcPaint);
  }

  _paintDashes(Canvas canvas, Size size) {
    final _paint = Paint()
      ..color = Color(0xffd7e9ed).withOpacity(0.5)
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2.0;

    final _outerRadius = radius;
    final _innerRadius = radius - 6.0;

    int _colorVal = 1;
    for (int i = 0; i <= 360; i += 12) {
      _colorVal++;
      final _x1 = size.width / 2 + _outerRadius * cos(i * pi / 180);
      final _y1 = size.height / 2 + _outerRadius * sin(i * pi / 180);

      final _x2 = size.width / 2 + _innerRadius * cos(i * pi / 180);
      final _y2 = size.height / 2 + _innerRadius * sin(i * pi / 180);

      if (_colorVal.isEven) {
        _paint.color = Color(0xff74d5df);
      } else {
        _paint.color = Color(0xffd7e9ed).withOpacity(0.5);
      }

      canvas.drawLine(Offset(_x1, _y1), Offset(_x2, _y2), _paint);
    }
  }
}
