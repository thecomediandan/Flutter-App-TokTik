import 'package:flutter/material.dart';
import 'package:flutter_app_toktik/presentation/widgets/video/video_background.dart';
import 'package:video_player/video_player.dart';

// * Para usar esta clase necesitaremos de la librería de video_player
// ? Documentacion: https://pub.dev/packages/video_player/example
// ? Habilitamos los permisos para el uso de internet, no lo necesitamos pero es necesario si consumiremos un video de internet
class FullScreenPlayer extends StatefulWidget {
  final String caption;
  final String url;
  const FullScreenPlayer({super.key, required this.caption, required this.url});

  @override
  State<FullScreenPlayer> createState() => _FullScreenPlayerState();
}

class _FullScreenPlayerState extends State<FullScreenPlayer> {
  // * El estado a controlar para este Widget será _controller que es basicamente el reproductor de Videos, donde almacenamos toda la información del video que carguemos en un VideoPlayer
  late VideoPlayerController _controller;

  // * Como se trata de un StatefulWidget contamos con los metodos initState (Para iniciar los estados) y dispose (Para destruir el Widget)
  @override
  void initState() {
    super.initState();
    // * El controlador de video consta de todas los métodos que implica la reproducción de videos, al cual cargamos en un objeto VideoPlayerController
    // ? _controller estaba en late hasta que se instancia aqui, en la inicialización
    _controller = VideoPlayerController.asset(widget.url)
      ..setVolume(0)
      ..setLooping(true)
      ..play();
  }

  // * Cuando termina el Widget el video y sus configuraciones se destruyen, asi que no hay que preocuparse de usar el dispose() del _controller
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // * FutureBuilder es un constructor que depende de promesas (Future) datos que son esperados a recibir, como la carga de los datos del video en este caso
    return FutureBuilder(
      future: _controller.initialize(),
      // * Cuando los datos se empiezan a cargarse podemos cargar diferentes estados en la carga del video en el _Controller con los metodos de ConnectionState, done, waiting, none y active
      builder: (context, snapshot) {
        // * El builder trabaja con una funcion el cual debe de retornar un Widget
        // ? context el contexto del Widget, snapshot el estado de la carga de los datos prometidos
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
            ),
          );
        }

        return GestureDetector(
          onTap: () {
            _controller.value.isPlaying
                ? _controller.pause()
                : _controller.play();
          },
          child: AspectRatio(
            // * Dentro de los valores del _controller obtenemos el aspectRatio
            aspectRatio: _controller.value.aspectRatio,
            child: Stack(
              children: [
                // * Aqui utilizamos el Widget del Reproductor de video, el cual debe recibir un objeto de tipo VideoPlayerController al cual llamamos _controller
                VideoPlayer(_controller),
                // * El gradiente que configuramos
                VideoBackGround(stops: const [0.8, 1.0]),
                // * Como estamos en un Stack podemos optar por utilizar un Positioned para posicionar el caption
                Positioned(
                    bottom: 50,
                    left: 20,
                    child: _VideoCaption(
                      caption: widget.caption,
                    ))
              ],
            ),
          ),
        );
      },
    );
  }
}

// * Widget del caption
class _VideoCaption extends StatelessWidget {
  final String caption;
  const _VideoCaption({
    required this.caption,
  });

  @override
  Widget build(BuildContext context) {
    // * Tamaño del dispositivo
    final size = MediaQuery.of(context).size;
    // * Estilo de los textos
    final titleStyle = Theme.of(context).textTheme.titleLarge;

    return SizedBox(
      width: size.width * 0.6,
      child: Text(
        caption,
        maxLines: 2,
        style: titleStyle,
      ),
    );
  }
}
