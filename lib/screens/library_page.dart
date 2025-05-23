import 'package:flutter/material.dart';
import '../widgets/focusable_game_card.dart';
import '../widgets/carousel_row.dart';
import '../pagination_model.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({Key? key}) : super(key: key);

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
    return ListView(
      children: [
        CarouselRow<String>(
          autofocusFirst: true,
          heading: 'Recently Added',
          cardSpacing: 10,
          cardsPerView: 3,
          handleApiCall: _fetchRecentlyAdded,
          cardBuilder: (context, item, width, index, autofocus) => FocusableGameCard(
            child: Text(item, style: TextStyle(color: Colors.white)),
            onSelect: () {},
            autofocus: autofocus ?? false,
          ),
        ),
        SizedBox(height: 40),
        CarouselRow<String>(
          heading: 'Completed Games',
          cardSpacing: 10,
          cardsPerView: 3,
          handleApiCall: _fetchCompletedGames,
          cardBuilder: (context, item, width, index, autofocus) => FocusableGameCard(
            child: Text(item, style: TextStyle(color: Colors.white)),
            onSelect: () {},
            autofocus: autofocus ?? false,
          ),
        ),
      ],
    );
  }
} 