import 'package:flutter/material.dart';
import 'package:rick_morty_bloc/constants/my_color.dart';
import 'package:rick_morty_bloc/data/models/characters_response.dart';

class CharacterDetailsScreen extends StatefulWidget {
  final Character character;

  const CharacterDetailsScreen({required this.character, super.key});

  @override
  State<CharacterDetailsScreen> createState() => _CharacterDetailsScreenState();
}

class _CharacterDetailsScreenState extends State<CharacterDetailsScreen> {
  Widget buildSliverAppBar(Character character) {
    return SliverAppBar(
      expandedHeight: 600,
      pinned: true,
      stretch: true,
      foregroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          character.name ?? "",
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 22,
            color: Colors.white,
            // shadows: [
            //   Shadow(
            //     color:
            //         Colors.black.withOpacity(0.5), // Shadow color and opacity
            //     offset:
            //         const Offset(2, 2), // Offset of the shadow from the text
            //     blurRadius: 10, // Spread of the shadow
            //   ),
            // ],
          ),
        ),
        // centerTitle: true,
        background: Hero(
          tag: character.id ?? "",
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(
                character.image ?? "",
                fit: BoxFit.cover,
              ),
              Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  begin: Alignment.center,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0),
                    Colors.black.withOpacity(0.9)
                  ],
                  stops: const [0.75, 1],
                )),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.grey,
      body: CustomScrollView(
        slivers: [buildSliverAppBar(widget.character)],
      ),
    );
  }
}
