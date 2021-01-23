import 'package:drink/viewmodels/vm_provider.dart';
import 'package:drink/viewmodels/welcome_vm.dart';
import 'package:drink/views/widgets/common_widgets/filled_btn.dart';
import 'package:drink/views/widgets/common_widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return VmProvider<WelcomeVm>(
      vm: WelcomeVm(context),
      builder: (context, vm, appVm) {
        return Scaffold(
          key: vm.scaffoldKey,
          backgroundColor: Color(0xff0059D4),
          body: SafeArea(
            child: Container(
              color: ThemeData().canvasColor,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: 412.0,
                      width: MediaQuery.of(context).size.width,
                      child: Stack(
                        alignment: Alignment.centerLeft,
                        overflow: Overflow.visible,
                        children: [
                          Positioned(
                            top: 0.0,
                            left: -1.0,
                            child: SvgPicture.asset(
                              'assets/svgs/welcome_bg.svg',
                            ),
                          ),
                          _appbarBuilder(),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 20.0,
                          ),
                          _inputContainer(vm),
                          SizedBox(
                            height: 50.0,
                          ),
                          FilledBtn(
                            title: 'HYDRATE',
                            bgColor: Color(0xff006BFF).withOpacity(0.9),
                            onPressed: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (_) => HomeScreen(),
                              //   ),
                              // );
                              vm.onPressedHydrate();
                            },
                          )
                        ],
                      ),
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

  Widget _appbarBuilder() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 10.0,
          ),
          Text(
            'Welcome\nBack !',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 32.0,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _inputContainer(final WelcomeVm vm) {
    return Column(
      children: [
        InputField(
          title: 'Full Name',
          capitalization: TextCapitalization.words,
          controller: vm.nameController,
        ),
        SizedBox(
          height: 30.0,
        ),
        Row(
          children: [
            Expanded(
              child: InputField(
                title: 'Height (cm)',
                type: TextInputType.number,
                controller: vm.heightController,
              ),
            ),
            SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: InputField(
                title: 'Weight (kg)',
                type: TextInputType.number,
                controller: vm.weightController,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 30.0,
        ),
        InputField(
          title: 'Minutes of exercise daily',
          type: TextInputType.number,
          controller: vm.exerciseController,
        ),
      ],
    );
  }
}
