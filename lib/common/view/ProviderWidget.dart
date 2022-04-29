import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProviderWidget<T extends ChangeNotifier> extends StatefulWidget {
  final ValueWidgetBuilder<T> builder;
  final T vm;
  final Widget? child;
  final Function(T vm)? init;
  final bool autoDispose;

  const ProviderWidget({
    Key? key,
    required this.builder,
    required this.vm,
    this.child,
    this.init,
    this.autoDispose: true,
  }) : super(key: key);

  _ProviderWidgetState<T> createState() => _ProviderWidgetState<T>();
}

class _ProviderWidgetState<T extends ChangeNotifier>
    extends State<ProviderWidget<T>> {
  late T vm;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>.value(
      value: vm,
      child: Consumer<T>(
        builder: widget.builder,
        child: widget.child,
      ),
    );
  }

  @override
  void dispose() {
    if (widget.autoDispose) vm.dispose();
    super.dispose();
  }

  @override
  void initState() {
    vm = widget.vm;
    widget.init?.call(vm);
    super.initState();
  }
}
