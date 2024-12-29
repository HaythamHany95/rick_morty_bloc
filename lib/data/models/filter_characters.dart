class FilterCharacters {
  final String? status;
  final String? species;
  final String searchText;

  FilterCharacters({
    this.status,
    this.species,
    this.searchText = '',
  });

  FilterCharacters copyWith({
    String? status,
    String? species,
    String? searchText,
  }) {
    return FilterCharacters(
      status: status ?? this.status,
      species: species ?? this.species,
      searchText: searchText ?? this.searchText,
    );
  }
}
