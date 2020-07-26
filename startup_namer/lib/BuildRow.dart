import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class BuildRow extends StatefulWidget {
  final WordPair wordPair;
  final Set<WordPair> savedWordPair;
  final TextStyle biggerFont;

  BuildRow(this.wordPair, this.savedWordPair, this.biggerFont);

  @override
  _BuildRowState createState() => _BuildRowState();
}

class _BuildRowState extends State<BuildRow> {
  @override
  Widget build(BuildContext context) {
    final _alreadySaved = widget.savedWordPair.contains(widget.wordPair);
    return ListTile(
      title: Text(
        widget.wordPair.asPascalCase,
        style: widget.biggerFont,
      ),
      trailing: Icon(
        _alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: _alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (_alreadySaved) {
            widget.savedWordPair.remove(widget.wordPair);
          } else {
            widget.savedWordPair.add(widget.wordPair);
          }
        });
      },
    );
  }
}
