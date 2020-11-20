import 'package:fluttertravelman/models/user_model.dart';
import 'package:meta/meta.dart';

enum MediaType {
  image,
  video,
}

class Story {
  final String url;
  final MediaType media;
  final Duration duration;
  final UserModel user;

  const Story({
    @required this.url,
    @required this.media,
    @required this.duration,
    @required this.user,
  });
}
