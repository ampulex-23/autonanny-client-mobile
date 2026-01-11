import 'package:flutter/material.dart';
import 'package:nanny_components/widgets/future_handlers/request_loader.dart';
import 'package:nanny_components/widgets/states/loading_view.dart';
import 'package:nanny_core/nanny_core.dart';

class RequestListLoader<T> extends StatelessWidget {
  final Future<ApiResponse<List<T>>> request;
  final Widget Function(BuildContext context, T e) tileTemplate;
  final Widget loadView;
  final Widget Function(BuildContext context, Object? error) errorView;
  final bool shrinkWrap;
  final ScrollPhysics? physics;
  final EdgeInsets? padding;

  const RequestListLoader({
    super.key,
    required this.request,
    required this.tileTemplate,
    required this.errorView,
    this.loadView = const LoadingView(),
    this.shrinkWrap = false,
    this.physics,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return RequestLoader(
        request: request,
        completeView: (context, data) {
          if (data == null) {
            return const Center(
              child: Text("Список пуст..."),
            );
          }

          return ListView(
            padding: padding,
            physics: physics,
            shrinkWrap: shrinkWrap,
            children: data.map((e) => tileTemplate(context, e)).toList(),
          );
        },
        errorView: errorView);
  }
}
