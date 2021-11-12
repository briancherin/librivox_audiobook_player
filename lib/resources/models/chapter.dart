import 'package:flutter/cupertino.dart';

class Chapter {
  final String title;
  final String fileName;
  final int chapterNumber;
  final double durationSeconds;

  Chapter({
    this.title,
    this.fileName,
    this.chapterNumber,
    this.durationSeconds,
  });
}

//  "https://archive.org/download/<book_id>/<track_file_name>"
String baseLibrivoxChapterUrl = "https://archive.org/download";
class LibrivoxChapter extends Chapter {
  final String title;
  final String fileName;
  final int chapterNumber;
  final double durationSeconds;

  final String trackUrl;
  final String librivoxItemId; // The id of the audiobook

  LibrivoxChapter({
    this.title,
    this.fileName,
    this.chapterNumber,
    this.durationSeconds,
    this.trackUrl,
    this.librivoxItemId,
  }) : super(
            title: title,
            fileName: fileName,
            chapterNumber: chapterNumber,
            durationSeconds: durationSeconds);


  factory LibrivoxChapter.fromJson(Map<String, dynamic> json, String librivoxItemId) {
    var fileName = json["name"];
    return LibrivoxChapter(
      title: json["title"],
      fileName: fileName,
      chapterNumber: int.parse((json["track"] as String).split("/")[0]), // going from "1/27" to 1
      durationSeconds: double.parse(json["length"]),
      trackUrl: "$baseLibrivoxChapterUrl/$librivoxItemId/$fileName",
      librivoxItemId: librivoxItemId,
    );
  }

/** example JSON
 * {"name":"dracula_01_stoker.mp3","source":"original","format":"128Kbps MP3",
 * "creator":"Bram Stoker","album":"Dracula","title":"Chapter 01","track":"1/27",
 * "md5":"b0377eb776152a4499db00a6ce62f023","mtime":"1147237781","size":"35490126",
 * "crc32":"62e678ad","sha1":"3418d869e89ddf8a8ebd7711dc36ba653bcd5b38","length":"2218",
 * "height":"0","width":"0","genre":"Speech","artist":"Bram Stoker","external-identifier-match-date":"acoustid:2019-04-04T21:23:19Z",
 * "external-identifier":"urn:acoustid:f0e91e3f-3bdb-4b5a-b3ea-478185795904"}
 */

}
