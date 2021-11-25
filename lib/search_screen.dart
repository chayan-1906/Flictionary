import 'package:flictionary/details_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:owlbot_dart/owlbot_dart.dart';
import 'package:page_transition/page_transition.dart';

import 'custom_list_tite.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final String _token = 'd0aaac89c450b9ccf38459131c3acec06ab32241';
  final TextEditingController _searchController = TextEditingController();
  OwlBot owlBot;
  OwlBotResponse searchResult;

  _searchWord() async {
    if (_searchController.text == null || _searchController.text.isEmpty) {
      return;
    }
    try {
      searchResult = await owlBot.define(word: _searchController.text);
      // refresh
      setState(() {});
    } catch (error) {
      print('error: $error');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    owlBot = OwlBot(token: _token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'Flictionary',
          style: GoogleFonts.getFont(
            'Roboto',
            letterSpacing: 1.2,
            fontWeight: FontWeight.w600,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48.0),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 12.0, bottom: 8.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: TextFormField(
                    controller: _searchController,
                    autofocus: false,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search',
                      hintStyle: GoogleFonts.getFont(
                        'Roboto',
                        fontWeight: FontWeight.w400,
                      ),
                      contentPadding: const EdgeInsets.only(left: 24.0),
                    ),
                    onChanged: (String text) {
                      _searchWord();
                    },
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  _searchWord();
                },
                icon: const Icon(
                  Icons.search,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
      body: searchResult != null
          ? ListView(
              children: searchResult.definitions.map((e) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        child: DetailsScreen(owlBotResponse: searchResult),
                        type: PageTransitionType.fade,
                      ),
                    );
                  },
                  child: customListTile(
                    word: searchResult.word,
                    partsOfSpeech: e.type,
                    imageUrl: e.imageUrl ?? '',
                  ),
                );
              }).toList(),
            )
          : Container(),
    );
  }
}
