
import 'package:flutter/cupertino.dart';

import 'chapter.dart';

abstract class Audiobook {
  final String title;
  final String author;
  final String description;
  final int durationSeconds; // in seconds
  final int numChapters;
  final String coverImageUrl; // TODO: Make a BookCoverImage object in case it is not a url but a local file
  final List<Chapter> chapters;

  Audiobook({
    @required this.title,
    @required this.author,
    @required this.description,
    @required this.durationSeconds,
    @required this.numChapters,
    this.coverImageUrl,
    this.chapters,
  });

  Audiobook withChapters(List<Chapter> chapters);

}

class LibrivoxAudiobook extends Audiobook {
  final String librivoxItemId;
  final String title;
  final String author;
  final String description;
  final int durationSeconds;
  final int numChapters;
  final String coverImageUrl;
  final List<LibrivoxChapter> chapters;

  LibrivoxAudiobook({
    @required this.librivoxItemId,
    @required this.title,
    @required this.author,
    @required this.description,
    @required this.durationSeconds,
    @required this.numChapters,
    this.coverImageUrl,
    this.chapters,
  }) : super(title: title, author: author, description: description, durationSeconds: durationSeconds, numChapters: numChapters, coverImageUrl: coverImageUrl, chapters: chapters);

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

}