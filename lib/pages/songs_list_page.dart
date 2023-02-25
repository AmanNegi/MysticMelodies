import 'package:flutter/material.dart';
import 'package:mysticmelodies/data/data.dart';

class SongsListPage extends StatefulWidget {
  final ItemModel item;
  const SongsListPage({Key? key, required this.item}) : super(key: key);

  @override
  State<SongsListPage> createState() => _SongsListPageState();
}

class _SongsListPageState extends State<SongsListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.item.name),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              widget.item.image,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
