import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AppSearchBar extends HookWidget {
  const AppSearchBar(
      {super.key, this.value, this.hintText, required this.onChanged});

  final String? value;
  final String? hintText;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final empty = useState<bool>(value == null || value!.isEmpty);
    final searchController = useTextEditingController(text: value);
    return SearchBar(
      elevation: const MaterialStatePropertyAll(1),
      controller: searchController,
      leading: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Icon(Icons.search_rounded),
      ),
      onChanged: (value) {
        onChanged(value);
        if (empty.value != value.isEmpty) {
          empty.value = value.isEmpty;
        }
      },
      hintText: hintText ?? "Search",
      trailing: [
        if (!empty.value)
          IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              searchController.clear();
              onChanged("");
              empty.value = true;
            },
          ),
      ],
    );
  }
}
