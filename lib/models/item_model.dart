// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:mysticmelodies/models/song_item.dart';

class ItemModel {
  final String name;
  final String id;
  final String image;
  final String description;
  final List<SongItem> songs;

  final String subTitle;

  ItemModel({
    required this.name,
    required this.id,
    required this.image,
    required this.description,
    required this.songs,
    required this.subTitle,
  });

  ItemModel copyWith({
    String? name,
    String? id,
    String? image,
    String? description,
    List<SongItem>? songs,
    String? subTitle,
  }) {
    return ItemModel(
      name: name ?? this.name,
      id: id ?? this.id,
      image: image ?? this.image,
      description: description ?? this.description,
      songs: songs ?? this.songs,
      subTitle: subTitle ?? this.subTitle,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'id': id,
      'image': image,
      'description': description,
      'songs': songs.map((x) => x.toMap()).toList(),
      'subTitle': subTitle,
    };
  }

  factory ItemModel.fromMap(Map<String, dynamic> map) {
    return ItemModel(
      name: map['name'] as String,
      id: map['id'] as String,
      image: map['image'] as String,
      description: map['description'] as String,
      songs: List<SongItem>.from((map['songs'] as List<int>).map<SongItem>((x) => SongItem.fromMap(x as Map<String,dynamic>),),),
      subTitle: map['subTitle'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ItemModel.fromJson(String source) =>
      ItemModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ItemModel(name: $name, id: $id, image: $image, description: $description, songs: $songs, subTitle: $subTitle)';
  }

  @override
  bool operator ==(covariant ItemModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.name == name &&
      other.id == id &&
      other.image == image &&
      other.description == description &&
      listEquals(other.songs, songs) &&
      other.subTitle == subTitle;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      id.hashCode ^
      image.hashCode ^
      description.hashCode ^
      songs.hashCode ^
      subTitle.hashCode;
  }
}
