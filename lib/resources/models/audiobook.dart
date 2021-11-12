import 'package:flutter/cupertino.dart';

import 'chapter.dart';

abstract class Audiobook {
  final String title;
  final String author;
  final String description;
  final double durationSeconds; // in seconds
  final String
      coverImageUrl; // TODO: Make a BookCoverImage object in case it is not a url but a local file
  final List<Chapter> chapters;

  Audiobook({
    @required this.title,
    @required this.author,
    @required this.description,
    this.durationSeconds,
    this.coverImageUrl,
    this.chapters,
  });

  Audiobook withChapters(List<Chapter> chapters);
}


