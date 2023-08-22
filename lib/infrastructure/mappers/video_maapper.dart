import 'package:flutter_2_cinema_app/domain/entities/video.dart';
import 'package:flutter_2_cinema_app/infrastructure/models/moviedb/moviedb_videos.dart';

class VideoMapper {
  static moviedbVideoToEntiry(Result moviedbVideo) => Video(
      id: moviedbVideo.id,
      name: moviedbVideo.name,
      publishetAt: moviedbVideo.publishedAt,
      youtubekey: moviedbVideo.key);
}
