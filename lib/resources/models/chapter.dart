

import 'package:flutter/cupertino.dart';

class Chapter {
  final String title;
  final String fileName;

  Chapter({
    @required this.title,
    this.fileName,
  });

}

class LibrivoxChapter extends Chapter {
  final String title;
  final String fileName;
  final String trackUrl;

  LibrivoxChapter({
    @required this.title,
    this.fileName,
    @required this.trackUrl,
  }) : super(title: title, fileName: fileName);
}