import 'package:flutter/material.dart';
import 'package:rick_morty_bloc/constants/my_color.dart';

class SearchField extends StatelessWidget {
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  const SearchField({super.key, this.controller, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      cursorColor: MyColor.grey,
      style: const TextStyle(color: MyColor.grey, fontSize: 18),
      decoration: const InputDecoration(
          hintText: "Find a character... ",
          border: InputBorder.none,
          hintStyle: TextStyle(color: MyColor.grey, fontSize: 18)),
    );
  }
}
