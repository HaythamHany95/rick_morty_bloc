import 'package:flutter/material.dart';
import 'package:rick_morty_bloc/core/my_color.dart';
import 'package:rick_morty_bloc/data/models/characters_response.dart';

class CharacterDetailsScreen extends StatefulWidget {
  final Character character;

  const CharacterDetailsScreen({required this.character, super.key});

  @override
  State<CharacterDetailsScreen> createState() => _CharacterDetailsScreenState();
}

class _CharacterDetailsScreenState extends State<CharacterDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.grey,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(widget.character),
          buildInfoSection(),
        ],
      ),
    );
  }

  Widget buildSliverAppBar(Character character) {
    return SliverAppBar(
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Material(
          shape: CircleBorder(),
          elevation: 1,
          child: CircleAvatar(
              backgroundColor: MyColor.yellow,
              foregroundColor: Colors.black,
              child: Icon(Icons.arrow_back)),
        ),
        color: Colors.black,
      ),
      expandedHeight: 600,
      pinned: true,
      stretch: true,
      // foregroundColor: Colors.black,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          character.name ?? "",
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 22,
            color: Colors.white,
          ),
        ),
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
                    stops: const [0.1, 1],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCharacterInfo(String title, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$title: ',
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Text(
              value ?? 'Unknown',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildInfoSection() {
    return SliverPadding(
      padding: const EdgeInsets.all(16.0),
      sliver: SliverList(
        delegate: SliverChildListDelegate([
          buildCharacterInfo('Status', widget.character.status),
          buildCharacterInfo('Species', widget.character.species),
          if (widget.character.type?.isNotEmpty ?? false)
            buildCharacterInfo('Type', widget.character.type),
          buildCharacterInfo('Gender', widget.character.gender),
          const SizedBox(height: 16),
          const Text(
            'Location Information',
            style: TextStyle(
              color: MyColor.yellow,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          buildCharacterInfo('Origin', widget.character.origin?.name),
          buildCharacterInfo(
              'Current Location', widget.character.location?.name),
          const SizedBox(height: 16),
          const Text(
            'Episodes',
            style: TextStyle(
              color: MyColor.yellow,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          if (widget.character.episode != null &&
              widget.character.episode!.isNotEmpty)
            Text(
              'Appears in ${widget.character.episode?.length ?? 0} episodes',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            )
          else
            const Text(
              'No episode information available',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
        ]),
      ),
    );
  }
}
