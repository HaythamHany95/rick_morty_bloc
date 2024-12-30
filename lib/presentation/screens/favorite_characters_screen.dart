import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:rick_morty_bloc/core/my_color.dart';
import 'package:rick_morty_bloc/data/models/character.dart';
import 'package:rick_morty_bloc/logic/cubit/characters_cubit.dart';

class FavoriteCharactersScreen extends StatelessWidget {
  const FavoriteCharactersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteCharacters = Hive.box<Character>('favorites').values.toList();

    return Scaffold(
      backgroundColor: MyColor.grey,
      appBar: AppBar(
        backgroundColor: MyColor.yellow,
        title: const Text(
          'Favorite Characters',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25),
        ),
      ),
      body: favoriteCharacters.isEmpty
          ? const Center(
              child: Text(
                'No favorites added yet.',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            )
          : ListView.builder(
              itemCount: favoriteCharacters.length,
              itemBuilder: (context, index) {
                final character = favoriteCharacters[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(character.image ?? ""),
                  ),
                  title: Text(
                    character.name ?? "",
                    style: const TextStyle(color: Colors.white),
                  ),
                  // trailing: IconButton(
                  //   icon: const Icon(Icons.delete, color: Colors.red),
                  //   onPressed: () {
                  //     context.read<CharactersCubit>().toggleFavorite(character);
                  //   },
                  // ),
                );
              },
            ),
    );
  }
}
