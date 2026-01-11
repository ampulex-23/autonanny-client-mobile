import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:nanny_components/base_views/view_models/document_vm.dart';
import 'package:nanny_components/widgets/nanny_app_bar.dart';
import 'package:nanny_components/widgets/states/error_view.dart';
import 'package:nanny_components/widgets/states/loading_view.dart';
import 'package:nanny_core/nanny_core.dart';

class DocumentView extends StatefulWidget {
  final String url;
  
  const DocumentView({
    super.key,
    required this.url,
  });

  @override
  State<DocumentView> createState() => _DocumentViewState();
}

class _DocumentViewState extends State<DocumentView> {
  late DocumentVM vm;
  
  @override
  void initState() {
    super.initState();
    vm = DocumentVM(context: context, update: setState);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: const NannyAppBar(),
        // body: FutureLoader(
        //   future: vm.loadPdf(),
        //   completeView: (context, data) {
        //     if(!data) {
        //       return const Padding(
        //         padding: EdgeInsets.all(20),
        //         child: Center(
        //           child: Text("Не удалось загрузить документ!"),
        //         ),
        //       );
        //     }

        //     // return PDFView(
        //     //   filePath: vm.file.path,
        //     // );
        //     return const SizedBox();
        //   },
        //   errorView: (context, error) => ErrorView(errorText: error.toString()),
        // ),
        body: const PDF(swipeHorizontal: true).fromUrl(
          widget.url,
          headers: {
            "Authorization": "Bearer ${DioRequest.authToken}"
          },
          placeholder: (progress) => const LoadingView(),
          errorWidget: (error) => ErrorView(errorText: error.toString()),
        ),
      ),
    );
  }
}