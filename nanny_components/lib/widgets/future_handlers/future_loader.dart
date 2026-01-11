import 'package:flutter/material.dart';
import 'package:nanny_components/widgets/states/loading_view.dart';

class FutureLoader<T> extends StatelessWidget {
  final Future<T> future;
  final Widget Function(BuildContext context, T data) completeView;
  final Widget loadView;
  final Widget Function(BuildContext context, Object? error) errorView;
  
  const FutureLoader({
    super.key,
    required this.future,
    required this.completeView,
    required this.errorView,
    this.loadView = const LoadingView(),
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future, 
      builder: (context, snapshot) {
        if(snapshot.hasError) return errorView(context, snapshot.error);
        if(snapshot.connectionState == ConnectionState.done) return completeView(context, snapshot.requireData);

        return loadView;
      },
    );
  }
}