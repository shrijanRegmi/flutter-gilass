import 'package:drink/viewmodels/app_vm.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

class VmProvider<T extends ChangeNotifier> extends StatefulWidget {
  @override
  _VmProviderState<T> createState() => _VmProviderState<T>();

  final Widget Function(BuildContext, T, AppVm) builder;
  final T vm;
  final Function(T) onInit;
  final Function(T) onInitBuild;
  final List<String> boxes;
  VmProvider({
    this.builder,
    this.vm,
    this.onInit,
    this.onInitBuild,
    this.boxes,
  });
}

class _VmProviderState<T extends ChangeNotifier> extends State<VmProvider<T>> {
  @override
  void initState() {
    super.initState();
    if (widget.onInit != null) {
      widget.onInit(widget.vm);
    }
  }

  @override
  Widget build(BuildContext context) {
    final _appVm = Provider.of<AppVm>(context);

    return FutureBuilder(
      future: widget.boxes == null ? null : _openBoxes(),
      builder: (context, snapshot) {
        if (widget.boxes == null) return _consumerBuilder(_appVm);

        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError)
            return Container();
          else
            return _consumerBuilder(_appVm);
        }
        return Scaffold();
      },
    );
  }

  Widget _consumerBuilder(final AppVm appVm) {
    return MyStatefulBuilder(
      onInitBuild: () => widget.onInitBuild?.call(widget.vm),
      builder: () {
        return ChangeNotifierProvider<T>(
          create: (_) => widget.vm,
          child: Consumer<T>(
            builder: (context, value, child) {
              return widget.builder(context, value, appVm);
            },
          ),
        );
      },
    );
  }

  Future<List<Box>> _openBoxes() async {
    var _boxes = <Box>[];

    for (var box in widget.boxes) {
      final _openedBox = await Hive.openBox(box);
      _boxes.add(_openedBox);
    }

    return _boxes;
  }
}

class MyStatefulBuilder extends StatefulWidget {
  final Function() onInitBuild;
  final Widget Function() builder;
  MyStatefulBuilder({this.onInitBuild, this.builder});
  @override
  _MyStatefulBuilderState createState() => _MyStatefulBuilderState();
}

class _MyStatefulBuilderState extends State<MyStatefulBuilder> {
  @override
  void initState() {
    super.initState();
    if (widget.onInitBuild != null) {
      widget.onInitBuild();
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder();
  }
}
