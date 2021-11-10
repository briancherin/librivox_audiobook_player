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
  final int numChapters;
  final String coverImageUrl;
  final List<LibrivoxChapter> chapters;

  LibrivoxAudiobook({
    @required this.librivoxItemId,
    @required this.title,
    @required this.author,
    @required this.description,
    this.durationSeconds,
    this.numChapters,
    this.coverImageUrl,
    this.chapters,
  }) : super(
      title: title,
      author: author,
      description: description,
      durationSeconds: durationSeconds,
      numChapters: numChapters,
      coverImageUrl: coverImageUrl,
      chapters: chapters);

  // Returns a copy of this audiobook object, with the chapters set
  LibrivoxAudiobook withChapters(List<Chapter> chapters) {
    return LibrivoxAudiobook(
      librivoxItemId: this.librivoxItemId,
      title: this.title,
      author: this.author,
      description: this.description,
      durationSeconds: this.durationSeconds,
      numChapters: this.numChapters,
      coverImageUrl: this.coverImageUrl,
      chapters: chapters,
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
}