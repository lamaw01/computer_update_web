import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/search_computer_riverpod.dart';
import '../widget/data_modal.dart';

class SearchView extends ConsumerStatefulWidget {
  const SearchView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchViewState();
}

class _SearchViewState extends ConsumerState<SearchView> {
  @override
  Widget build(BuildContext context) {
    final dataList = ref.watch(searchComputerProvider);
    return Center(
      child: SizedBox(
        width: 500.0,
        child: ListView.builder(
          key: const PageStorageKey(0),
          itemCount: dataList.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                minVerticalPadding: 0.0,
                visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                title: Text(dataList[index].hostname),
                onTap: () {
                  showDataModal(context, dataList[index], ref);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
