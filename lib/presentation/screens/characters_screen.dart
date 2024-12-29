import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_morty_bloc/core/my_color.dart';
import 'package:rick_morty_bloc/core/router/routes.dart';
import 'package:rick_morty_bloc/data/api_services/errors.dart';
import 'package:rick_morty_bloc/data/models/characters_response.dart';
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
  late CharactersCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = CharactersCubit(repoContract: injectCharactersRepositoryDelegate());
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

  Widget _buildCharacterGrid(List<Character?> characters) {
    return GridView.builder(
      controller: _scrollController,
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: MediaQuery.of(context).size.width * 0.5,
        mainAxisExtent: MediaQuery.of(context).size.width * 0.6,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: characters.length + (cubit.isLoading ? 1 : 0),
      itemBuilder: (context, i) {
        if (i >= characters.length) {
          return const Center(
            child: CircularProgressIndicator(color: MyColor.yellow),
          );
        }

        final character = characters[i];
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
                  backgroundColor: MyColor.grey.withOpacity(0.7),
                  title: Text(
                    character?.name ?? "",
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
                child: Image.network(
                  character?.image ?? "",
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[800],
                      child: const Center(
                        child: Icon(
                          Icons.error_outline,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    );
                  },
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      color: Colors.grey[800],
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: MyColor.yellow,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildNoInternet(Errors error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.wifi_off,
            size: 100,
            color: MyColor.yellow,
          ),
          const SizedBox(height: 20),
          Text(
            error is NetworkError
                ? 'No internet connection'
                : 'Something went wrong',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: cubit.retry,
            style: ElevatedButton.styleFrom(
              backgroundColor: MyColor.yellow,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            ),
            child: const Text(
              'Retry',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => cubit..getAllCharacters(),
      child: Scaffold(
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
            BlocBuilder<CharactersCubit, CharactersStates>(
              builder: (context, state) {
                return SearchFilterBar(
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
                );
              },
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: BlocBuilder<CharactersCubit, CharactersStates>(
                  buildWhen: (previous, current) =>
                      current is CharactersSuccessState ||
                      current is CharactersErrorState ||
                      current is CharactersLoadingState,
                  builder: (context, state) {
                    if (state is CharactersLoadingState &&
                        cubit.characters.isEmpty) {
                      return const Center(
                        child: CircularProgressIndicator(color: MyColor.yellow),
                      );
                    }

                    if (state is CharactersErrorState &&
                        cubit.characters.isEmpty) {
                      return _buildNoInternet(state.errorMessage);
                    }

                    if (state is CharactersSuccessState) {
                      return state.characters.isEmpty
                          ? const Center(
                              child: Text(
                                'No characters found',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            )
                          : _buildCharacterGrid(state.characters);
                    }

                    if (cubit.characters.isNotEmpty) {
                      return _buildCharacterGrid(cubit.characters);
                    }

                    return const SizedBox();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
