import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:mysticmelodies/globals.dart';
import 'package:mysticmelodies/models/item_model.dart';
import 'package:mysticmelodies/pages/song_page.dart';
import 'package:mysticmelodies/widgets/currently_playing_widget.dart';

class SongsListPage extends StatefulHookWidget {
  final ItemModel item;
  const SongsListPage({Key? key, required this.item}) : super(key: key);

  @override
  State<SongsListPage> createState() => _SongsListPageState();
}

class _SongsListPageState extends State<SongsListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildBody(context),
          const Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: CurrentlyPlayingWidget(),
          ),
        ],
      ),
    );
  }

  GridView _getGridView() {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: widget.item.songs.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => goToPage(
            context,
            SongPage(
              item: widget.item,
              index: index,
            ),
          ),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset(
                    "assets/music.png",
                    height: 0.1 * getHeight(context),
                  ),
                  Text(
                    widget.item.songs[index].name,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  _buildBody(BuildContext context) {
    return CustomScrollView(
      controller: useScrollController(),
      slivers: [
        SliverAppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            PopupMenuButton(
              offset: const Offset(0.0, 12.0),
              position: PopupMenuPosition.under,
              color: semiDarkColor,
              itemBuilder: (context) {
                return [
                  const PopupMenuItem(
                    height: 28,
                    child: Text(
                      "About",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  PopupMenuItem(
                    padding: const EdgeInsets.only(
                      bottom: 10.0,
                      left: 16.0,
                      right: 16.0,
                    ),
                    child: Text(widget.item.description),
                  )
                ];
              },
              child: const Icon(
                Icons.help_outline,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 15),
          ],
          forceElevated: true,
          expandedHeight: 0.4 * getHeight(context),
          pinned: true,
          flexibleSpace: LayoutBuilder(
            builder: (context, constraints) {
              return FlexibleSpaceBar(
                title: Text(
                  widget.item.subTitle,
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: "Gloock",
                    letterSpacing: 1.2,
                  ),
                ),
                centerTitle: true,
                collapseMode: CollapseMode.parallax,
                stretchModes: const [
                  StretchMode.blurBackground,
                  StretchMode.fadeTitle,
                ],
                background: Stack(
                  children: [
                    Positioned.fill(
                      child: Image.asset(
                        widget.item.image,
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
                  ],
                ),
              );
            },
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            _getGridView(),
            SizedBox(height: 0.1 * getHeight(context)),
            Center(
              child: Text(
                "~ END ~",
                style: TextStyle(
                  color: Colors.white.withOpacity(0.4),
                ),
              ),
            ),
            SizedBox(height: 0.05 * getHeight(context)),
          ]),
        ),
      ],
    );
  }
}
