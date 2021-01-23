import 'package:drink/viewmodels/app_vm.dart';
import 'package:drink/viewmodels/vm_provider.dart';
import 'package:drink/views/widgets/home_widgets/drink_time.dart';
import 'package:drink/views/widgets/home_widgets/home_appbar.dart';
import 'package:drink/views/widgets/home_widgets/percentage_overview.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return VmProvider<AppVm>(
      vm: AppVm(),
      builder: (context, vm, appVm) {
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    HomeAppbar(vm),
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      height: 300.0,
                      child: PercentageOverview(vm),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Column(
                      children: [
                        _waterStatusBuilder(vm),
                        SizedBox(
                          height: 30.0,
                        ),
                        DrinkTime(vm),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _waterStatusBuilder(final AppVm vm) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _getStatus(
            'Remaining', '${vm.remainingWater}ml', CrossAxisAlignment.start),
        _getStatus('Target', '${vm.targetWater}ml', CrossAxisAlignment.end)
      ],
    );
  }

  Widget _getStatus(final String title, final String value,
      final CrossAxisAlignment alignment) {
    return Column(
      crossAxisAlignment: alignment,
      children: [
        Text(
          '$title',
          style: TextStyle(
            color: Colors.black26,
          ),
        ),
        SizedBox(
          height: 5.0,
        ),
        Text(
          '$value',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
