class FilterState {
  final String? status;
  final String? species;
  final String searchText;

  FilterState({
    this.status,
    this.species,
    this.searchText = '',
  });

  FilterState copyWith({
    String? status,
    String? species,
    String? searchText,
  }) {
    return FilterState(
      status: status ?? this.status,
      species: species ?? this.species,
      searchText: searchText ?? this.searchText,
    );
  }
}
