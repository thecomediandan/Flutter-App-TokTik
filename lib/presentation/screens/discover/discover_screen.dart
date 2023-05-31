import 'package:flutter/material.dart';
import 'package:flutter_app_toktik/presentation/providers/discover_provider.dart';
import 'package:flutter_app_toktik/presentation/widgets/shared/video_scrollable_view.dart';
import 'package:provider/provider.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ? Con context.watch<DiscoverProvider>() Observamos cambios del provider para dibujarlo o aplicar un setState con 'watch', con 'read' solo leemos los cambios, watch o read son metodos pertenecientes a la librería de Provider para detectar notificaciones o cambios con objetos de tipo ChangeNotifier
    final DiscoverProvider discoverProvider = context.watch<DiscoverProvider>();
    // Otra manera de implementar un observador de Providers
    // ? final otherProvider = Provider.of<DiscoverProvider>(context, listen: false);

    return Scaffold(
      // ? Verificamos si el Provider ejecuto la lectura de los videos del JSON, si se leyó mostramos un widget personalizado VideoScrollableView que recibe una lista de objetos del tipo VideoPost que contiene discoverProvider
      body: discoverProvider.initialLoading
          ? const Center(
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : VideoScrollableView(videos: discoverProvider.videos),
    );
  }
}
