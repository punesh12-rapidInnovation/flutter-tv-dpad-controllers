import 'package:flutter/material.dart';
import '../widgets/sidebar.dart';
import '../widgets/focusable_game_card.dart';

class HomeScreen extends StatelessWidget {
  final List<String> favoriteGames = [
    'Forgotten Playland',
    'Redout II',
    'Rumble',
    'Metal Core',
    'Starlight Odyssey',
    'Neon Drift',
  ];

  final List<String> savedGames = [
    'Quantum Arena',
    'Pixel Quest',
    'Skybound Saga',
    'Galactic Run',
    'Mystic Valley',
    'Cyber Sprint',
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        // Favorite Games Section
        Text(
          'Favorite Games',
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
            children: List.generate(favoriteGames.length, (index) {
              return Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: SizedBox(
                  width: 200,
                  height: 120,
                  child: FocusableGameCard(
                    autofocus: index == 0,
                    onSelect: () => print('Selected: ${favoriteGames[index]}'),
                    child: Container(
                      color: Colors.blueGrey.shade700,
                      alignment: Alignment.center,
                      child: Text(
                        favoriteGames[index],
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
        // Saved Games Section
        Text(
          'Saved Games',
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
            children: List.generate(savedGames.length, (index) {
              return Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: SizedBox(
                  width: 200,
                  height: 120,
                  child: FocusableGameCard(
                    autofocus: false,
                    onSelect: () => print('Selected: ${savedGames[index]}'),
                    child: Container(
                      color: Colors.blueGrey.shade700,
                      alignment: Alignment.center,
                      child: Text(
                        savedGames[index],
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
