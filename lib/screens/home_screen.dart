
import 'package:dpad_controls/pagination_model.dart';
import 'package:flutter/material.dart';

import '../widgets/carousel_row.dart';
import '../widgets/focusable_game_card.dart';

class HomeScreen extends StatefulWidget {
        const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        CarouselRow(
          heading: 'Favorite Games',
          cardSpacing: 10,
          cardsPerView: 3,
          handleApiCall: (page) async {
            return Paginated<String>(count: favoriteGames.length, data: favoriteGames);
          },
          cardBuilder: (context, item, width, index, autofocus) => FocusableGameCard(
            child: Text(item),
            onSelect: () {},
            autofocus: autofocus ?? false,
          ),
        ),
        SizedBox(height: 40),
        CarouselRow(
          heading: 'Saved Games',
          cardSpacing: 10,
          cardsPerView: 3,
          handleApiCall: (page) async {
            return Paginated<String>(count: favoriteGames.length, data: favoriteGames);
          },
          cardBuilder: (context, item, width, index, autofocus) => FocusableGameCard(
            child: Text(item),
            onSelect: () {},
            autofocus: autofocus ?? false,
          ),
        ),
      ],
    );
  }
}
