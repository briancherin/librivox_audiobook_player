
import 'package:flutter/cupertino.dart';

class Audiobook {
  final String title;
  final String author;
  final int duration; // in seconds
  final int numChapters;

  Audiobook({
    @required this.title,
    @required this.author,
    @required this.duration,
    @required this.numChapters
  });

}