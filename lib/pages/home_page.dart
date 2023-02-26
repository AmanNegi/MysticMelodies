import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:mysticmelodies/globals.dart';
import 'package:mysticmelodies/models/item_model.dart';
import 'package:mysticmelodies/pages/songs_list_page.dart';
import 'package:mysticmelodies/widgets/currently_playing_widget.dart';
import '../data/data.dart';

class HomePage extends StatefulHookWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool condensedView = false;

  @override
  Widget build(BuildContext context) {
    TabController tabController = useTabController(initialLength: items.length);
    return Scaffold(
      backgroundColor:
          condensedView ? semiDarkColor : Theme.of(context).canvasColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              condensedView = !condensedView;
              setState(() {});
            },
            icon: Icon(!condensedView ? Icons.line_weight : Icons.view_column),
          )
        ],
        title: const Text(
          "Mystic Melodies",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: darkColor,
        centerTitle: true,
      ),
      body: Column(children: [
        Expanded(
          child: condensedView
              ? _getCondensedView(context)
              : _getNormalView(tabController),
        ),
        const CurrentlyPlayingWidget(),
      ]),
    );
  }

  CustomScrollView _getCondensedView(BuildContext context) {
    return CustomScrollView(
      slivers: items.map((item) {
        return StackedListChild(
          key: Key(item.id),
          maxHeight: 0.3 * getHeight(context),
          minHeight: 0.2 * getHeight(context),
          floating: false,
          pinned: false,
          child: GestureDetector(
            onTap: () {
              goToPage(context, SongsListPage(item: item));
            },
            child: SizedBox(
              height: 0.3 * getHeight(context),
              child: Stack(children: [
                Positioned.fill(
                  child: Image.asset(
                    item.image,
                    fit: BoxFit.fitWidth,
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
                  left: 15.0,
                  bottom: 10.0,
                  child: Text(
                    item.subTitle,
                    style: const TextStyle(
                      fontFamily: "Gloock",
                      fontSize: 25,
                    ),
                  ),
                ),
              ]),
            ),
          ),
        );
      }).toList(),
    );
  }

  _getNormalView(TabController tabController) {
    return LayoutBuilder(builder: (context, constraints) {
      return Column(
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
                    (e) => _getItem(e, constraints),
                  )
                  .toList(),
            ),
          ),
        ],
      );
    });
  }

  Stack _getItem(ItemModel item, BoxConstraints constraints) {
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
          top: 0.55 * constraints.maxHeight,
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
              Text(
                item.description,
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
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

class StackedListChild extends StatelessWidget {
  final double minHeight;
  final double maxHeight;
  final bool pinned;
  final bool floating;
  final Widget child;

  SliverPersistentHeaderDelegate get _delegate => _StackedListDelegate(
      minHeight: minHeight, maxHeight: maxHeight, child: child);

  const StackedListChild({
    Key? key,
    required this.minHeight,
    required this.maxHeight,
    required this.child,
    this.pinned = false,
    this.floating = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SliverPersistentHeader(
      key: key, pinned: pinned, floating: floating, delegate: _delegate);
}

class _StackedListDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _StackedListDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });
  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => max(maxHeight, minHeight);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_StackedListDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
