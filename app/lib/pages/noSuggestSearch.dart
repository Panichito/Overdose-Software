import 'package:flutter/material.dart';
import 'package:searchfield/searchfield.dart';

// put dummy in search suggestion
class Dummy {
  String dummy;
  Dummy(this.dummy);
}

// create dummy list
List<Dummy> dummy = [
  Dummy(''),
];

/* create a search field without suggestions */
Widget noSuggestSearch(updateList(String value)) {
  return SearchField(
    suggestions: dummy
        .map((e) => SearchFieldListItem(
              e.dummy,
              item: e,
            ))
        .toList(),
    searchStyle: const TextStyle(
      fontSize: 18,
    ),
    suggestionStyle: const TextStyle(
      fontSize: 18,
    ),
    searchInputDecoration: const InputDecoration(
      border: OutlineInputBorder(),
      contentPadding: EdgeInsets.fromLTRB(8, 16, 8, 16),
      prefixIcon: Icon(Icons.search),
    ),
    maxSuggestionsInViewPort: 0,
    onSubmit: (value) => updateList(value),
  );
}
