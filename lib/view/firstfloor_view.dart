import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/firstfloor_riverpod.dart';
import '../widget/data_modal.dart';

class FirstFloorView extends ConsumerStatefulWidget {
  const FirstFloorView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FirstFloorViewState();
}

class _FirstFloorViewState extends ConsumerState<FirstFloorView> {
  @override
  void initState() {
    super.initState();
    ref.read(firstFloorProvider.notifier).sortFirstFloorComputerDetail();
  }

  @override
  Widget build(BuildContext context) {
    final dataList = ref.watch(firstFloorProvider);
    return Center(
      child: SizedBox(
        width: 500.0,
        child: ListView.builder(
          key: const PageStorageKey(1),
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
