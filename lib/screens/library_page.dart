import 'package:dpad_controls/screens/home_screen.dart';
import 'package:flutter/material.dart';
import '../pagination_model.dart';
import '../widgets/carousel_row.dart';
import '../widgets/image_card.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key});

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  static const List<String> recentlyAdded = [
    'Celestial Quest',
    'Dungeon Crawler',
    'Sky Realms',
    'Pixel Adventure',
    'Mystic Forest',
  ];

  static const List<String> completedGames = [
    'Retro Racer',
    'Puzzle Master',
    'Space Odyssey',
    'Jungle Run',
    'Castle Siege',
  ];

  final List<GameItem> savedGames = [
    GameItem(
      name: 'Quantum Arena',
      imageUrl: 'https://picsum.photos/id/1021/200/120',
    ),
    GameItem(
      name: 'Pixel Quest',
      imageUrl: 'https://picsum.photos/id/1022/200/120',
    ),
    GameItem(
      name: 'Skybound Saga',
      imageUrl: 'https://picsum.photos/id/1023/200/120',
    ),
    GameItem(
      name: 'Galactic Run',
      imageUrl: 'https://picsum.photos/id/1024/200/120',
    ),
    GameItem(
      name: 'Mystic Valley',
      imageUrl: 'https://picsum.photos/id/1025/200/120',
    ),
    GameItem(
      name: 'Cyber Sprint',
      imageUrl: 'https://picsum.photos/id/1026/200/120',
    ),
  ];

 

  Future<Paginated<String>> _fetchRecentlyAdded(int page) async {
    // For demonstration, return all items on page 1, empty on others
    if (page == 1) {
      return Paginated<String>(count: recentlyAdded.length, data: recentlyAdded);
    } else {
      return Paginated<String>(count: recentlyAdded.length, data: []);
    }
  }

  Future<Paginated<String>> _fetchCompletedGames(int page) async {
    if (page == 1) {
      return Paginated<String>(count: completedGames.length, data: completedGames);
    } else {
      return Paginated<String>(count: completedGames.length, data: []);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Helper to wire up up/down focus movement
    Widget buildCarouselRow(int rowIndex, String heading, List<GameItem> items, {bool autofocusFirst = false}) {
      return CarouselRow<GameItem>(
        heading: heading,
        cardSpacing: 16,
        cardsPerView: 4,
        autofocusFirst: autofocusFirst,
        handleApiCall: (page) async {
          return Paginated<GameItem>(count: items.length, data: items);
        },
        cardBuilder: (context, item, width, index, autofocus) {
          return ImageCard(
            imageUrl: item.imageUrl,
            title: item.name,
            autofocus: autofocus ?? false,
            onSelect: () {},
          );
        },
      );
    }

    return ListView(
      children: [
        buildCarouselRow(0, 'Beautiful Places', savedGames, autofocusFirst: true),
        buildCarouselRow(1, 'Recently Added', savedGames),
        SizedBox(height: 40),
        buildCarouselRow(2, 'Completed Games', savedGames),
      ],
    );
  }
}