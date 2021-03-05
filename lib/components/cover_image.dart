

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:librivox_audiobook_player/resources/models/audiobook.dart';

class CoverImage extends StatelessWidget {
  final Audiobook audiobook;

  const CoverImage({@required this.audiobook});

  @override
  Widget build(BuildContext context) {
    return Container(height: 200, width: 200, decoration: BoxDecoration(color: Colors.grey),
        child: audiobook.coverImageUrl != null
            ? Image.network(audiobook.coverImageUrl, fit: BoxFit.fill,)
            : SizedBox(height:0)
    );
  }

}