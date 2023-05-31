import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_toktik/config/helpers/human_formats.dart';

import '../../../domain/entities/video_post.dart';

class VideoButtons extends StatelessWidget {
  final VideoPost video;

  const VideoButtons({super.key, required this.video});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _CustomButtons(
            iconData: Icons.favorite,
            iconColor: Colors.red,
            value: video.likes),
        const SizedBox(
          height: 10,
        ),
        _CustomButtons(
            iconData: Icons.remove_red_eye_outlined, value: video.views),
        const SizedBox(
          height: 20,
        ),
        // * SpinPerfect pertenece a la libreria de Fernando Herrera animate_do que importamos con Pubspec Assist
        SpinPerfect(
          infinite: true,
          duration: const Duration(seconds: 5),
          child: const _CustomButtons(
              iconData: Icons.arrow_drop_down_circle_outlined, value: 0),
        )
      ],
    );
  }
}

class _CustomButtons extends StatelessWidget {
  final IconData iconData;
  final Color color;
  final int value;

  const _CustomButtons({required this.iconData, iconColor, required this.value})
      : color = iconColor ?? Colors.white;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          onPressed: () {},
          icon: Icon(
            iconData,
            color: color,
            size: 30,
          ),
        ),
        if (value > 0) Text(HumanFormats.humanReadbleNumber(value.toDouble()))
      ],
    );
  }
}
