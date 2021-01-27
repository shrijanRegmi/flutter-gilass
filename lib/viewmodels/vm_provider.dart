import 'package:drink/viewmodels/app_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VmProvider<T extends ChangeNotifier> extends StatefulWidget {
  @override
  _VmProviderState<T> createState() => _VmProviderState<T>();

  final Widget Function(BuildContext, T, AppVm) builder;
  final T vm;
  final Function(T) onInit;
  VmProvider({
    this.builder,
    this.vm,
    this.onInit,
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
    return ChangeNotifierProvider<T>(
      create: (_) => widget.vm,
      child: Consumer<T>(
        builder: (context, value, child) {
          return widget.builder(context, value, _appVm);
        },
      ),
    );
  }
}
