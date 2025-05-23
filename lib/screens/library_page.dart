import 'package:flutter/material.dart';
import '../widgets/focusable_game_card.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({Key? key}) : super(key: key);

  final List<String> recentlyAdded = const [
    'Celestial Quest',
    'Dungeon Crawler',
    'Sky Realms',
    'Pixel Adventure',
    'Mystic Forest',
  ];

  final List<String> completedGames = const [
    'Retro Racer',
    'Puzzle Master',
    'Space Odyssey',
    'Jungle Run',
    'Castle Siege',
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        // Recently Added Section
        Text(
          'Recently Added',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(recentlyAdded.length, (index) {
              return Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: SizedBox(
                  width: 200,
                  height: 120,
                  child: FocusableGameCard(
                    autofocus: index == 0,
                    onSelect: () => print('Selected: \\${recentlyAdded[index]}'),
                    child: Container(
                      color: Colors.blueGrey.shade700,
                      alignment: Alignment.center,
                      child: Text(
                        recentlyAdded[index],
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
        SizedBox(height: 40),
        // Completed Games Section
        Text(
          'Completed Games',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(completedGames.length, (index) {
              return Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: SizedBox(
                  width: 200,
                  height: 120,
                  child: FocusableGameCard(
                    autofocus: false,
                    onSelect: () => print('Selected: \\${completedGames[index]}'),
                    child: Container(
                      color: Colors.blueGrey.shade700,
                      alignment: Alignment.center,
                      child: Text(
                        completedGames[index],
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
} 