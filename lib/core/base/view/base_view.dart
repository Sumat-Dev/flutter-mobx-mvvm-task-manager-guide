import 'package:flutter/material.dart';
import 'package:flutter_mobx_mvvm_task_manager/core/base/model/base_view_model.dart';
import 'package:provider/provider.dart';

class BaseView<T extends BaseViewModel> extends StatefulWidget {
  const BaseView({
    required this.onPageBuilder,
    required this.onModelReady,
    super.key,
    this.onDispose,
  });

  final Widget Function(BuildContext context, T viewModel) onPageBuilder;
  final void Function(T viewModel) onModelReady;
  final VoidCallback? onDispose;

  @override
  State<BaseView<T>> createState() => _BaseViewState<T>();
}

class _BaseViewState<T extends BaseViewModel> extends State<BaseView<T>> {
  late T viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = Provider.of<T>(context, listen: false);
    widget.onModelReady(viewModel);
  }

  @override
  void dispose() {
    widget.onDispose?.call();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.onPageBuilder(context, viewModel);
  }
}
