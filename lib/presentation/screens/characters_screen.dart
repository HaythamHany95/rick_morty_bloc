import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_morty_bloc/business_logic/cubit/characters_cubit.dart';
import 'package:rick_morty_bloc/business_logic/cubit/characters_state.dart';
import 'package:rick_morty_bloc/constants/my_color.dart';
import 'package:rick_morty_bloc/dep_injection.dart';
import 'package:rick_morty_bloc/presentation/screens/character_details_screen.dart';
import 'package:rick_morty_bloc/presentation/widgets/search_field.dart';

class CharactersScreen extends StatefulWidget {
  static const String routeName = 'charaters_screen';

  const CharactersScreen({super.key});

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  var cubit =
      CharactersCubit(repoDelegate: injectCharactersRepositoryDelegate());

  // @override
  // void initState() {
  //   super.initState();
  //   cubit.getAllCharacters();
  // }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => cubit,
      child: BlocBuilder<CharactersCubit, CharactersStates>(
          builder: (context, state) {
        return Scaffold(
            backgroundColor: MyColor.grey,
            appBar: AppBar(
              backgroundColor: MyColor.yellow,
              title: cubit.searching
                  ? SearchField(
                      controller: cubit.searchController,
                      onChanged: (searchedText) {
                        cubit.addCharacterToSearchedList(searchedText);
                      },
                    )
                  : const Text(
                      "Characters",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 25),
                    ),
              actions: cubit.searching
                  ? [
                      IconButton(
                        onPressed: () {
                          cubit.searchController.clear();
                          cubit.emitSearchState();

                          // Navigator.pop(context);
                        },
                        icon: const Icon(Icons.clear),
                      ),
                    ]
                  : [
                      IconButton(
                        onPressed: () {
                          ModalRoute.of(context)?.addLocalHistoryEntry(
                            LocalHistoryEntry(
                              onRemove: () {
                                cubit.searchController.clear();
                                cubit.searching = false;
                                cubit.emitSearchState();
                              },
                            ),
                          );
                          cubit.searching = true;
                          cubit.emitSearchState();
                        },
                        icon: const Icon(
                          Icons.search,
                          size: 32,
                        ),
                      ),
                    ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: BlocBuilder<CharactersCubit, CharactersStates>(
                bloc: cubit..getAllCharacters(),
                builder: (context, state) {
                  if (state is CharactersInitial) {
                    return const Center(
                      child: CircularProgressIndicator(color: MyColor.yellow),
                    );
                  }
                  if (state is CharactersSuccessState) {
                    return GridView.builder(
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent:
                                MediaQuery.of(context).size.width * 0.5,
                            mainAxisExtent:
                                MediaQuery.of(context).size.width * 0.6,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10),
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        // padding: EdgeInsets.zero,
                        itemCount: cubit.searchController.text.isEmpty
                            ? state.characters.length
                            : cubit.searchedCharacters.length,
                        itemBuilder: (context, i) {
                          return InkWell(
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                  CharacterDetailsScreen.routeName,
                                  arguments: cubit.searchController.text.isEmpty
                                      ? state.characters[i]
                                      : cubit.searchedCharacters[i]);
                            },
                            child: Hero(
                              tag: state.characters[i]?.id ?? 0,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: GridTile(
                                    footer: GridTileBar(
                                      backgroundColor:
                                          MyColor.grey.withOpacity(0.7),
                                      title: Text(
                                        cubit.searchController.text.isEmpty
                                            ? cubit.characters[i].name ?? ""
                                            : cubit.searchedCharacters[i]
                                                    .name ??
                                                "",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18,
                                            color: Colors.white),
                                      ),
                                    ),
                                    child: FadeInImage.assetNetwork(
                                        fit: BoxFit.cover,
                                        placeholder:
                                            'assets/images/loading.gif',
                                        image: cubit
                                                .searchController.text.isEmpty
                                            ? cubit.characters[i].image ?? ""
                                            : cubit.searchedCharacters[i]
                                                    .image ??
                                                ""),
                                  )),
                            ),
                          );
                        });
                  }
                  return const SizedBox();
                },
              ),
            ));
      }),
    );
  }
}
