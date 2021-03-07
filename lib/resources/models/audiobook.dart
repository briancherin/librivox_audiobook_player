
import 'package:flutter/cupertino.dart';

class Audiobook {
  final String title;
  final String author;
  final String description;
  final int durationSeconds; // in seconds
  final int numChapters;
  final String coverImageUrl; // TODO: Make a BookCoverImage object in case it is not a url but a local file

  Audiobook({
    @required this.title,
    @required this.author,
    @required this.description,
    @required this.durationSeconds,
    @required this.numChapters,
    this.coverImageUrl,
  });

}

class LibrivoxAudiobook extends Audiobook {
  final String librivoxItemId;
  final String title;
  final String author;
  final String description;
  final int durationSeconds;
  final int numChapters;
  final String coverImageUrl;


  LibrivoxAudiobook({
    @required this.librivoxItemId,
    @required this.title,
    @required this.author,
    @required this.description,
    @required this.durationSeconds,
    @required this.numChapters,
    this.coverImageUrl,
  }) : super(title: title, author: author, description: description, durationSeconds: durationSeconds, numChapters: numChapters, coverImageUrl: coverImageUrl);


}