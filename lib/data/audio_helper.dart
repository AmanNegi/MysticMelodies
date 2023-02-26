import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:mysticmelodies/models/item_model.dart';
import 'package:mysticmelodies/models/song_item.dart';

final assetsAudioPlayer = AssetsAudioPlayer();

Future<void> load(SongItem song, ItemModel item) async {
  await assetsAudioPlayer.open(
    Audio(
      song.relLink,
      package: "Mystic Melodies",
      metas: Metas(
        artist: song.singer,
        image: MetasImage.asset(item.image),
        title: song.name,
      ),
    ),
    showNotification: true,
  );
  debugPrint("Audio loaded successfully!");
}

Future<void> playOrPause() async {
  await assetsAudioPlayer.playOrPause();
  debugPrint("Play/Pause Successfull");
}

Future<void> seekAt(Duration duration) async {
  await assetsAudioPlayer.seek(duration);
}

Future<void> disposeAudioPlayer() async {
  await assetsAudioPlayer.stop();
}
