// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:mysticmelodies/models/item_model.dart';
import 'package:mysticmelodies/models/song_item.dart';

List<String> images = [
  "assets/uttarakhand.png",
  "assets/assam.png",
  "assets/maharashtra.png",
  "assets/rajasthan.png",
  "assets/karnataka.jpg",
  "assets/bengal.png",
];

List<String> titles = [
  "Uttarakhand",
  "Assam",
  "Maharashtra",
  "Rajasthan",
  "Karnataka",
  "Bengal",
];

List<String> descriptions = [
  "Garhwal is a region in the Indian state of Uttarakhand, located in the foothills of the Himalayas. The region has a rich cultural heritage, including a vibrant musical tradition. Garhwali songs are known for their unique melodies and lyrics that often reflect the natural beauty of the region.",
  "Assam is a state in Northeast India known for its diverse culture and rich heritage. The region has a vibrant music scene that includes traditional folk music, Bihu songs, and modern music.",
  "Lavani is a popular folk music genre that originated in the Indian state of Maharashtra. It is a lively and rhythmic style of music that is often accompanied by dance. Lavani is characterized by its fast tempo, dynamic rhythm, and lively percussion, which includes instruments such as the dholki, tabla, and manjeera. The vocals are typically sung in a high-pitched, powerful voice, and are accompanied by dance movements that are often suggestive and flirtatious.",
  "Maand is a form of folk music that originated in Rajasthan, India. It is typically sung during weddings and other festive occasions, and is accompanied by a variety of instruments including the dholak, harmonium, and sarangi. Maand music is characterized by its soulful melodies and intricate rhythms. The lyrics often reflect the joys and sorrows of life, and the music is deeply rooted in the culture and traditions of Rajasthan.",
  "Bhavgeet is a popular form of devotional music that originated in the southern Indian state of Karnataka. It is a musical genre that expresses emotions and feelings through poetic verses set to melodious tunes. Bhavgeet is often sung in Kannada, the official language of Karnataka.",
  "Bengali music includes a wide range of styles, including Baul, Rabindra Sangeet, and Nazrul Geeti. Baul music is a form of folk music that originated in Bengal and is characterized by its simple melodies and lyrics that often reflect the spiritual beliefs of the performers. Rabindra Sangeet, on the other hand, is a form of music that was popularized by the Bengali poet and philosopher Rabindranath Tagore. The music is known for its poetic lyrics and rich melodies.",
];

List<String> subTitles = [
  "Garhwali",
  "Bihu",
  "Lavani",
  "Maand",
  "Bhavgeet",
  "Bengali",
];

List<ItemModel> items = [
  ItemModel(
    id: "1",
    subTitle: subTitles[1],
    name: titles[1],
    image: images[1],
    description: descriptions[1],
    songs: getSongList("assamese"),
  ),
  ItemModel(
    id: "2",
    subTitle: subTitles[2],
    name: titles[2],
    image: images[2],
    description: descriptions[2],
    songs: getSongList("abc"),
  ),
  ItemModel(
    id: "3",
    subTitle: subTitles[3],
    name: titles[3],
    image: images[3],
    description: descriptions[3],
    songs: getSongList("abc"),
  ),
  ItemModel(
    id: "0",
    subTitle: subTitles[0],
    name: titles[0],
    image: images[0],
    description: descriptions[0],
    songs: getSongList("garhwali"),
  ),
  ItemModel(
    id: "4",
    subTitle: subTitles[4],
    name: titles[4],
    image: images[4],
    description: descriptions[4],
    songs: getSongList("abc"),
  ),
  ItemModel(
    id: "5",
    subTitle: subTitles[5],
    name: titles[5],
    image: images[5],
    description: descriptions[5],
    songs: getSongList("abc"),
  ),
];
