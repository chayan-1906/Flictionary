import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget customListTile({String word, String partsOfSpeech, String imageUrl}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 3.0),
    child: ListTile(
      tileColor: Colors.grey.shade200,
      title: Row(
        children: [
          Visibility(
            visible: imageUrl != '',
            child: CircleAvatar(
              radius: 20.0,
              backgroundImage: NetworkImage(imageUrl),
            ),
          ),
          const SizedBox(width: 10.0),
          Text(
            word,
            style: GoogleFonts.getFont(
              'Roboto Slab',
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 3.0),
          Text(
            '($partsOfSpeech)',
            style: GoogleFonts.getFont(
              'Roboto Slab',
              fontSize: 16.0,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    ),
  );
}
