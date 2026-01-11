import 'package:flutter/material.dart';
import 'package:nanny_components/nanny_components.dart';
import 'package:nanny_core/nanny_core.dart';

// Временно отключен из-за несовместимости better_player с Flutter 3.35
class VideoView extends StatefulWidget {
  final String url;

  const VideoView({
    super.key,
    required this.url,
  });

  @override
  State<VideoView> createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> {
  // late BetterPlayerController controller;
  
  @override
  void initState() {
    super.initState();
    // controller = BetterPlayerController(
    //   const BetterPlayerConfiguration(),
    //   betterPlayerDataSource: BetterPlayerDataSource.network(
    //     widget.url,
    //     headers: {
    //       "Authorization": "Bearer ${DioRequest.authToken}"
    //     }
    //   )
    // );
    // controller.setOverriddenFit(BoxFit.contain);
  }

  @override
  void dispose() {
    super.dispose();
    // controller.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const NannyAppBar(),
        body: const Center(
          child: Text('Видео плеер временно недоступен'),
        ),
      ),
    );
  }
}