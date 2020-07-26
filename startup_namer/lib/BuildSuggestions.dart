import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:startup_namer/BuildRow.dart';

class BuildSuggestions extends StatefulWidget {
  final List<WordPair> suggestions;
  final Set<WordPair> savedWordPair;
  final TextStyle biggerFont;

  BuildSuggestions(this.suggestions, this.savedWordPair, this.biggerFont);

  @override
  _BuildSuggestionsState createState() => _BuildSuggestionsState();
}

class _BuildSuggestionsState extends State<BuildSuggestions> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          if (i.isOdd) return Divider();
          final index = i ~/ 2;
          if (index >= widget.suggestions.length) {
            widget.suggestions.addAll(generateWordPairs().take(10));
          }
          return BuildRow(widget.suggestions[index], widget.savedWordPair,
              widget.biggerFont);
        });
  }
}
