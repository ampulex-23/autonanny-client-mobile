import 'package:flutter/material.dart';
import 'package:nanny_components/widgets/future_handlers/future_loader.dart';
import 'package:nanny_components/widgets/states/loading_view.dart';
import 'package:nanny_core/nanny_core.dart';

class RequestLoader<T> extends StatelessWidget {
  final Future< ApiResponse<T> > request;
  final Widget Function(BuildContext context, T? data) completeView;
  final Widget loadView;
  final Widget Function(BuildContext context, Object? error) errorView;
  
  const RequestLoader({
    super.key,
    required this.request,
    required this.completeView,
    required this.errorView,
    this.loadView = const LoadingView(),
  });

  @override
  Widget build(BuildContext context) {
    return FutureLoader(
      future: request, 
      completeView: (context, data) => completeView(context, data.response), 
      errorView: errorView
    );
  }
}