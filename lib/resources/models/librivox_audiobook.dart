import 'package:flutter/cupertino.dart';

import 'audiobook.dart';
import 'chapter.dart';

class LibrivoxAudiobook extends Audiobook {

  // final String baseImageUrl = "https://archive.org/services/get-item-image.php?identifier=";
  // String getImageUrl (String identifier) => baseImageUrl + identifier;


  final String librivoxItemId;

  final String title;
  final String author;
  final String description;
  final double durationSeconds;
  final String coverImageUrl;
  final List<LibrivoxChapter> chapters;

  LibrivoxAudiobook({
    @required this.librivoxItemId,
    @required this.title,
    @required this.author,
    @required this.description,
    this.durationSeconds,
    this.coverImageUrl,
    this.chapters,
  }) : super(
      title: title,
      author: author,
      description: description,
      durationSeconds: durationSeconds,
      coverImageUrl: coverImageUrl,
      chapters: chapters);

  // Returns a copy of this audiobook object, with the chapters set
  LibrivoxAudiobook withChapters(List<Chapter> chapters) {
    return LibrivoxAudiobook(
      librivoxItemId: this.librivoxItemId,
      title: this.title,
      author: this.author,
      description: this.description,
      coverImageUrl: this.coverImageUrl,
      chapters: chapters.cast<LibrivoxChapter>(),

      // Now that we have chapters, we can calculate total duration
      durationSeconds: getTotalDuration(chapters),
    );
  }

  factory LibrivoxAudiobook.fromJSON(Map<String, dynamic> json) {
    return LibrivoxAudiobook(
      librivoxItemId: json["identifier"],
      title: json["title"],
      author: json["creator"],
      description: json["description"],

      // TODO: DO THIS BETTER
      coverImageUrl: "https://archive.org/services/get-item-image.php?identifier=" + json["identifier"]
    );
  }

  double getTotalDuration(List<Chapter> chapters) {
    double duration = 0;

    for (final chapter in chapters) {
      duration += chapter.durationSeconds;
    }

    return duration;
  }
}