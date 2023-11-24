import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/secondfloor_riverpod.dart';
import '../widget/data_modal.dart';

class SecondFloorView extends ConsumerStatefulWidget {
  const SecondFloorView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SecondFloorViewState();
}

class _SecondFloorViewState extends ConsumerState<SecondFloorView> {
  @override
  void initState() {
    super.initState();
    ref.read(secondFloorProvider.notifier).sortSecondFloorComputerDetail();
  }

  @override
  Widget build(BuildContext context) {
    final dataList = ref.watch(secondFloorProvider);
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
                  showDataModal(context, dataList[index]);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
