import 'package:flutter/material.dart';
import 'package:rick_morty_bloc/core/my_color.dart';

class SearchFilterBar extends StatelessWidget {
  final TextEditingController searchController;
  final Function(String) onSearchChanged;
  final String? selectedStatus;
  final String? selectedSpecies;
  final VoidCallback onStatusTap;
  final VoidCallback onSpeciesTap;
  final VoidCallback onClearFilters;

  const SearchFilterBar({
    super.key,
    required this.searchController,
    required this.onSearchChanged,
    this.selectedStatus,
    this.selectedSpecies,
    required this.onStatusTap,
    required this.onSpeciesTap,
    required this.onClearFilters,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: searchController,
            onChanged: onSearchChanged,
            decoration: InputDecoration(
              hintText: 'Search characters...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: searchController.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        searchController.clear();
                        onSearchChanged('');
                      },
                    )
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: FilterChip(
                  label: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.person, size: 16),
                      const SizedBox(width: 4),
                      Text(selectedStatus ?? 'Status'),
                    ],
                  ),
                  selected: selectedStatus != null,
                  onSelected: (_) => onStatusTap(),
                  backgroundColor: Colors.white,
                  selectedColor: MyColor.yellow.withOpacity(0.3),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: FilterChip(
                  label: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.category, size: 16),
                      const SizedBox(width: 4),
                      Text(selectedSpecies ?? 'Species'),
                    ],
                  ),
                  selected: selectedSpecies != null,
                  onSelected: (_) => onSpeciesTap(),
                  backgroundColor: Colors.white,
                  selectedColor: MyColor.yellow.withOpacity(0.3),
                ),
              ),
              if (selectedStatus != null ||
                  selectedSpecies != null ||
                  searchController.text.isNotEmpty)
                FilterChip(
                  label: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.clear_all, size: 16),
                      SizedBox(width: 4),
                      Text('Clear All'),
                    ],
                  ),
                  onSelected: (_) => onClearFilters(),
                  backgroundColor: Colors.white,
                ),
            ],
          ),
        ),
      ],
    );
  }
}
