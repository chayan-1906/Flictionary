import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:owlbot_dart/owlbot_dart.dart';

class DetailsScreen extends StatefulWidget {
  final OwlBotResponse owlBotResponse;

  const DetailsScreen({Key key, this.owlBotResponse}) : super(key: key);

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  String imageUrl = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          widget.owlBotResponse.word,
          style: GoogleFonts.getFont(
            'Roboto',
            letterSpacing: 1.2,
            fontWeight: FontWeight.w600,
          ),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(20.0),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // word
                  Text(
                    widget.owlBotResponse.word,
                    style: GoogleFonts.getFont(
                      'Roboto Slab',
                      fontSize: 38.0,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  // pronunciation
                  Visibility(
                    visible: widget.owlBotResponse.pronunciation != null,
                    child: Text(
                      widget.owlBotResponse.pronunciation != null
                          ? widget.owlBotResponse.pronunciation
                          : '',
                      style: GoogleFonts.getFont(
                        'Roboto Slab',
                        fontSize: 20.0,
                        color: Colors.indigoAccent,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  // types --> chip
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: widget.owlBotResponse.definitions
                          .map((e) {
                            return Padding(
                              padding:
                                  const EdgeInsets.only(right: 8.0, top: 8.0),
                              child: Chip(
                                elevation: 0.0,
                                labelStyle: GoogleFonts.getFont(
                                  'Roboto Slab',
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w600,
                                ),
                                backgroundColor:
                                    Theme.of(context).primaryColorLight,
                                label: Text(e.type),
                              ),
                            );
                          })
                          .toSet()
                          .toList(),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  // definitions
                  Text(
                    'DEFINITIONS (${widget.owlBotResponse.definitions.length})',
                    style: GoogleFonts.getFont(
                      'Roboto Slab',
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: widget.owlBotResponse.definitions.map((e) {
                      e.definition = e.definition.replaceFirst(e.definition[0],
                          '\u2022  ${e.definition[0].toUpperCase()}');
                      return EasyRichText(
                        e.definition,
                        selectable: true,
                        textAlign: TextAlign.justify,
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 10.0),
                  // examples
                  Text(
                    'EXAMPLES',
                    style: GoogleFonts.getFont(
                      'Roboto Slab',
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: widget.owlBotResponse.definitions.map((e) {
                      imageUrl = e.imageUrl;
                      e.example != null
                          ? e.example.replaceFirst(e.example[0],
                              '\u2022  ' + e.example[0].toUpperCase())
                          : '';
                      return EasyRichText(
                        e.example,
                        selectable: true,
                        textAlign: TextAlign.justify,
                      );
                    }).toList(),
                  ),
                ],
              ),
              imageUrl == null
                  ? Container()
                  : Positioned(
                      top: 7.0,
                      right: 15.0,
                      child: CircleAvatar(
                        radius: 60.0,
                        backgroundImage: NetworkImage(imageUrl),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
