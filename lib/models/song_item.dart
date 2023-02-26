// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

List<SongItem> garhwaliSongs = [
  SongItem(
      name: "Bedu Pako Baro Masa",
      relLink: "assets/music/bedu-pako-baro-masa.mp3",
      singer: "Gajendra Rana"),
  SongItem(
      name: "Hey Deepa Mijaj Deepa",
      relLink: "assets/music/hey-deepa-mijaj-deepa.mp3",
      singer: "Narendra Singh Negi"),
  SongItem(
      name: "Basant Rity Ma Jayee",
      relLink: "assets/music/basant-ritu-maa-jaiyee.mp3",
      singer: "Narendra Singh Negi"),
  SongItem(
      name: "Meri Satheni",
      relLink: "assets/music/hey-deepa-mijaj-deepa.mp3",
      singer: "Gajendra Rana"),
  SongItem(
      name: "Heera Samdhini",
      relLink: "assets/music/hey-deepa-mijaj-deepa.mp3",
      singer: "Krishan Mahipal"),
];

List<SongItem> assameseSongs = [
  SongItem(
      name: "Bistirno Dupare",
      relLink: "assets/music/bistirno-parore.mp3",
      singer: "Bhupen Hazarika"),
  SongItem(
      name: "Kolija",
      relLink: "assets/music/o-kolija.mp3",
      singer: "Zubeen Garg"),
  SongItem(
      name: "Mayabini Rair Bukut",
      relLink: "assets/music/o-kolija.mp3",
      singer: "Jitul Sonowal"),
  SongItem(
      name: "Mur Minoti",
      relLink: "assets/music/o-kolija.mp3",
      singer: "Gajendra Rana"),
  SongItem(
      name: "Hiyar Epahi Golap",
      relLink: "assets/music/o-kolija.mp3",
      singer: "Zubeen Garg"),
];

List<SongItem> getSongList(String name) {
  if (name == "assamese") {
    return [...assameseSongs];
  }
  return [...garhwaliSongs];
}

class SongItem {
  final String name;
  final String singer;
  final String relLink;
  SongItem({
    required this.name,
    required this.singer,
    required this.relLink,
  });

  SongItem copyWith({
    String? name,
    String? singer,
    String? relLink,
  }) {
    return SongItem(
      name: name ?? this.name,
      singer: singer ?? this.singer,
      relLink: relLink ?? this.relLink,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'singer': singer,
      'relLink': relLink,
    };
  }

  factory SongItem.fromMap(Map<String, dynamic> map) {
    return SongItem(
      name: map['name'] as String,
      singer: map['singer'] as String,
      relLink: map['relLink'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SongItem.fromJson(String source) =>
      SongItem.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'SongItem(name: $name, singer: $singer, relLink: $relLink)';
}
