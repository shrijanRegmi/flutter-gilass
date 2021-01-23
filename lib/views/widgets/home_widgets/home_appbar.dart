import 'package:drink/viewmodels/app_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeAppbar extends StatefulWidget {
  final AppVm vm;
  HomeAppbar(this.vm);

  @override
  _HomeAppbarState createState() => _HomeAppbarState();
}

class _HomeAppbarState extends State<HomeAppbar>
    with SingleTickerProviderStateMixin {

  AnimationController _animationController;

  Animation<Offset> _animation;
  Animation<double> _opacityAnimation;
  bool _isLocked = true;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(duration: Duration(milliseconds: 800), vsync: this);
    _animation = Tween<Offset>(begin: Offset(1.0, 0.0), end: Offset(-0.2, 0.0))
        .animate(_animationController);
    _opacityAnimation =
        Tween<double>(begin: 1.0, end: 0.0).animate(_animationController);
  }

  _showText() {
    setState(() {
      _isLocked = false;
    });
    _animationController.reset();
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Gilass',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30.0,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SlideTransition(
                position: _animation,
                child: AnimatedBuilder(
                  animation: _opacityAnimation,
                  builder: (context, child) {
                    return Opacity(
                      opacity: _isLocked ? 0.0 : _opacityAnimation.value,
                      child: Text('+200ml'),
                    );
                  },
                ),
              ),
              SizedBox(
                width: 20.0,
              ),
              GestureDetector(
                onTap: () {
                  _showText();
                  final _drinkPercentage =
                      (widget.vm.waterToDrink / widget.vm.targetWater) * 100;
                  widget.vm
                      .onWaterDrink(widget.vm.goalValue + _drinkPercentage);
                  widget.vm.updateRemainingWater(
                      widget.vm.remainingWater - widget.vm.waterToDrink);
                },
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: ThemeData().canvasColor,
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xffd7e9ed),
                        blurRadius: 20.0,
                      ),
                    ],
                  ),
                  width: 50.0,
                  height: 50.0,
                  padding: const EdgeInsets.all(12.0),
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/svgs/water.svg',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
