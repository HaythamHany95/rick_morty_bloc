import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_morty_bloc/core/my_color.dart';
import 'package:rick_morty_bloc/core/router/routes.dart';
import 'package:rick_morty_bloc/dep_injection.dart';
import 'package:rick_morty_bloc/logic/cubit/characters_cubit.dart';
import 'package:rick_morty_bloc/logic/cubit/characters_state.dart';
import 'package:rick_morty_bloc/presentation/widgets/search_field.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({super.key});

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  late ScrollController _scrollController;
  var cubit =
      CharactersCubit(repoContract: injectCharactersRepositoryDelegate());

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      cubit.getAllCharacters();
    }
  }

  void _showFilterDialog(
    BuildContext context,
    String title,
    List<String> options,
    Function(String) onSelected,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: options.map((option) {
                return ListTile(
                  title: Text(option),
                  onTap: () {
                    onSelected(option);
                    Navigator.pop(context);
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

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
              title: const Text(
                "Characters",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25),
              ),
            ),
            body: Column(
              children: [
                SearchFilterBar(
                  searchController: cubit.searchController,
                  onSearchChanged: cubit.addCharacterToSearchedList,
                  selectedStatus: cubit.filterState.status,
                  selectedSpecies: cubit.filterState.species,
                  onStatusTap: () => _showFilterDialog(
                    context,
                    'Select Status',
                    cubit.statusOptions,
                    (status) => cubit.updateFilters(status: status),
                  ),
                  onSpeciesTap: () => _showFilterDialog(
                    context,
                    'Select Species',
                    cubit.speciesOptions,
                    (species) => cubit.updateFilters(species: species),
                  ),
                  onClearFilters: cubit.resetFilters,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: BlocBuilder<CharactersCubit, CharactersStates>(
                      bloc: cubit..getAllCharacters(),
                      builder: (context, state) {
                        if (state is CharactersInitial &&
                            cubit.characters.isEmpty) {
                          return const Center(
                            child: CircularProgressIndicator(
                                color: MyColor.yellow),
                          );
                        }
                        if (state is CharactersSuccessState) {
                          return GridView.builder(
                            controller: _scrollController,
                            gridDelegate:
                                SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent:
                                  MediaQuery.of(context).size.width * 0.5,
                              mainAxisExtent:
                                  MediaQuery.of(context).size.width * 0.6,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                            shrinkWrap: true,
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemCount: state.characters.length +
                                (cubit.isLoading ? 1 : 0),
                            itemBuilder: (context, i) {
                              if (i >= state.characters.length) {
                                return const Center(
                                  child: CircularProgressIndicator(
                                      color: MyColor.yellow),
                                );
                              }

                              final character = state.characters[i];

                              return InkWell(
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                    Routes.characterDetailsScreen,
                                    arguments: character,
                                  );
                                },
                                child: Hero(
                                  tag: character?.id ?? 0,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: GridTile(
                                      footer: GridTileBar(
                                        backgroundColor:
                                            MyColor.grey.withOpacity(0.7),
                                        title: Text(
                                          character?.name ?? "",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      child: FadeInImage.assetNetwork(
                                        fit: BoxFit.cover,
                                        placeholder:
                                            'assets/images/loading.gif',
                                        image: character?.image ?? "",
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        }
                        return const SizedBox();
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
