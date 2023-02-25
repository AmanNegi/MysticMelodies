import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:mysticmelodies/globals.dart';
import 'package:mysticmelodies/pages/songs_list_page.dart';
import '../data/data.dart';

class HomePage extends StatefulHookWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    TabController tabController = useTabController(initialLength: items.length);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mystic Melodies"),
        backgroundColor: darkColor,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: kToolbarHeight,
              child: TabBar(
                controller: tabController,
                tabs: items.map((e) => Text(e.name)).toList(),
                isScrollable: true,
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: items
                    .map(
                      (e) => _getItem(e),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Stack _getItem(ItemModel item) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            item.image,
            fit: BoxFit.cover,
          ),
        ),
        Positioned.fill(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  Colors.black,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ),
        Positioned(
          top: 0.55 * getHeight(context),
          bottom: 0,
          left: 15.0,
          right: 15.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.subTitle,
                style: const TextStyle(
                  fontFamily: "Gloock",
                  fontSize: 40,
                ),
              ),
              SizedBox(
                height: 0.1 * getHeight(context),
                child: Text(
                  item.description,
                  maxLines: 0.1 * getHeight(context) ~/ 16,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              OutlinedButton(
                onPressed: () {
                  goToPage(context, SongsListPage(item: item));
                },
                child: const Text(
                  "Explore Songs",
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
