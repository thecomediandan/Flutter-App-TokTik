import 'package:flutter/material.dart';
import 'package:flutter_app_toktik/config/theme/app_theme.dart';
import 'package:flutter_app_toktik/infrastructure/datasources/local_video_datasource_impl.dart';
import 'package:flutter_app_toktik/infrastructure/repositories/video_post_repository_impl.dart';
import 'package:flutter_app_toktik/presentation/providers/discover_provider.dart';
import 'package:flutter_app_toktik/presentation/screens/discover/discover_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // * Como el Datasource y los Repositories mantienen comunicacion con la capa de presentación necesitamos enviar un Repositorios o una implementacion de un Repositorio en la capa de dominio de videos el cual a su vez depende de un Datasource o fuente de datos.
    // ? En la capa de Dominio tenemos las clases abstractas de Los DataSources y Repositories, y en la capa de Infrastructure tenemos las implementaciones de tales DataSources y Repositories, en los cuales esta la lógica para procesar los pedido, en este caso la obtencion y conversion de los videos en formato Json a un objeto tipo VideoPost
    final videoPostRepository =
        VideoPostsRepository(videosDatasource: LocalVideoDataSource());

    // * MultiProvider es un widget, que en sus propiedades puede almacenar providers para luego ser usadas
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          lazy:
              false, // * Como funciona ChangeNotifierProvider es construir hasta que sea necesario por defecto (lazy: true), pero si queremos que se lance cuando se hace referencia ponemos lazy: false.
          create: (_) => DiscoverProvider(videosRepository: videoPostRepository)
            ..loadNextPage(), // * Esta es una sintaxis de cascada para evitar ocupar 2 líneas de código de una misma referencia
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'TokTik',
        theme: AppTheme().getTheme(),
        home: const DiscoverScreen(),
      ),
    );
  }
}
