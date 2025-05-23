
import 'package:dpad_controls/pagination_model.dart';
import 'package:dpad_controls/widgets/image_card.dart';
import 'package:flutter/material.dart';

import '../widgets/carousel_row.dart';
import '../widgets/focusable_game_card.dart';

class GameItem {
  final String name;
  final String imageUrl;

  GameItem({required this.name, required this.imageUrl});
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<GameItem> favoriteGames = [
    GameItem(
      name: 'Forgotten Playland',
      imageUrl: 'https://picsum.photos/id/1011/200/120',
    ),
    GameItem(
      name: 'Redout II',
      imageUrl: 'https://picsum.photos/id/1012/200/120',
    ),
    GameItem(
      name: 'Rumble',
      imageUrl: 'https://picsum.photos/id/1013/200/120',
    ),
    GameItem(
      name: 'Metal Core',
      imageUrl: 'https://picsum.photos/id/1014/200/120',
    ),
    GameItem(
      name: 'Starlight Odyssey',
      imageUrl: 'https://picsum.photos/id/1015/200/120',
    ),
    GameItem(
      name: 'Neon Drift',
      imageUrl: 'https://picsum.photos/id/1016/200/120',
    ),
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

  @override
  void initState() {
    super.initState();
  }

  Widget _gameCardContent(GameItem item) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            item.imageUrl,
            width: 200,
            height: 120,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              width: 200,
              height: 120,
              color: Colors.grey[800],
              child: Icon(Icons.videogame_asset, color: Colors.white54, size: 40),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          item.name,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        CarouselRow<GameItem>(
          autofocusFirst: true,
          heading: 'Favorite Games',
          cardSpacing: 10,
          handleApiCall: (page) async {
            return Paginated<GameItem>(count: favoriteGames.length, data: favoriteGames);
          },
          cardBuilder: (context, item, width, index, autofocus) => FocusableGameCard(
            child: _gameCardContent(item),
            onSelect: () {},
            autofocus: autofocus ?? false,
          ),
        ),
        const SizedBox(height: 40),
        CarouselRow<GameItem>(
          heading: 'Saved Games',
          cardSpacing: 10,
          handleApiCall: (page) async {
            return Paginated<GameItem>(count: savedGames.length, data: savedGames);
          },
          cardBuilder: (context, item, width, index, autofocus) => 
          ImageCard(
            imageUrl: item.imageUrl,
            title: item.name,
            autofocus: autofocus ?? false,
          ),
        
        ),
      ],
    );
  }
}
