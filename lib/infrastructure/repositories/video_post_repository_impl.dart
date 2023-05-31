import 'package:flutter_app_toktik/domain/datasources/video_posts_datasource.dart';
import 'package:flutter_app_toktik/domain/entities/video_post.dart';

import '../../domain/repositories/video_posts_repository.dart';

// * El fin de repository es mandame un origen de datos y te lo busco

class VideoPostsRepository implements VideoPostRepository {
  final VideoPostDatasource videosDatasource;

  VideoPostsRepository({required this.videosDatasource});

  @override
  Future<List<VideoPost>> getFavoriteVideosByUser(String userID) {
    // TODO: implement getFavoriteVideosByUser
    throw UnimplementedError();
  }

  @override
  Future<List<VideoPost>> getTrendingVideosByPage(int page) {
    return videosDatasource.getTrendingVideosByPage(page);
  }
}
