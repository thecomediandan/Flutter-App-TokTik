import 'package:flutter/material.dart';
import 'package:flutter_app_toktik/domain/entities/video_post.dart';
import 'package:flutter_app_toktik/presentation/widgets/shared/video_buttons.dart';
import 'package:flutter_app_toktik/presentation/widgets/video/fullscreen_player.dart';

class VideoScrollableView extends StatelessWidget {
  final List<VideoPost> videos;
  const VideoScrollableView({super.key, required this.videos});

  @override
  Widget build(BuildContext context) {
    // ? PageView ocupa todo el espacio disponible, es com una lista Scrollable
    return PageView.builder(
      itemCount: videos.length,
      scrollDirection: Axis.vertical,
      // physics: const BouncingScrollPhysics(), // ? Esto hace que al llegar al límite de los items en el scroll, se haga un efecto de scroll oscuro como imán con el borde
      itemBuilder: (context, index) {
        final VideoPost videoPost = videos[index];
        return Stack(
          children: [
            // * SizedBox.expand ocupa todo el espacion disponible, generalmente es mas efectivo en un stack
            SizedBox.expand(
              child: FullScreenPlayer(
                  caption: videoPost.caption, url: videoPost.videoURL),
            ),
            // * Positioned generalmente funciona cuando esta dentro de un stack
            Positioned(
                bottom: 10, right: 10, child: VideoButtons(video: videoPost))
          ],
        );
      },
    );
  }
}
