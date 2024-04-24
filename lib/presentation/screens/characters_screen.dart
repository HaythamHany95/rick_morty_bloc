import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_morty_bloc/business_logic/cubit/characters_cubit.dart';
import 'package:rick_morty_bloc/business_logic/cubit/characters_state.dart';
import 'package:rick_morty_bloc/constants/my_color.dart';
import 'package:rick_morty_bloc/dep_injection.dart';
import 'package:rick_morty_bloc/presentation/screens/character_details_screen.dart';

class CharactersScreen extends StatefulWidget {
  static const String routeName = 'charaters_screen';

  const CharactersScreen({super.key});

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  var cubit =
      CharactersCubit(repoDelegate: injectCharactersRepositoryDelegate());
  @override
  void initState() {
    super.initState();
    cubit.getAllCharacters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.grey,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<CharactersCubit, CharactersStates>(
          bloc: cubit,
          builder: (context, state) {
            if (state is CharactersInitial) {
              return const Center(
                child: CircularProgressIndicator(color: MyColor.white),
              );
            }
            if (state is CharactersSuccessState) {
              return GridView.builder(
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent:
                          MediaQuery.of(context).size.width * 0.5,
                      mainAxisExtent: MediaQuery.of(context).size.width * 0.5,
                      crossAxisSpacing: 10),
                  itemCount: state.characters.length,
                  itemBuilder: (context, i) {
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                            CharacterDetailsScreen.routeName,
                            arguments: state.characters[i]);
                      },
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(13),
                          child:
                              Image.network(state.characters[i]?.image ?? "")),
                    );
                  });
            }
            return Container();
          },
        ),
      ),
    );
  }
}
