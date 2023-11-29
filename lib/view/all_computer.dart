import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/computer_detail_riverpod.dart';
import '../widget/data_modal.dart';

class AllComputerView extends ConsumerStatefulWidget {
  const AllComputerView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AllComputerViewState();
}

class _AllComputerViewState extends ConsumerState<AllComputerView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (ref.read(allComputerProvider).isEmpty) {
        await ref.read(allComputerProvider.notifier).getAllComputerDetail();
        log(ref.read(allComputerProvider).length.toString());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final dataList = ref.watch(allComputerProvider);
    return Center(
      child: SizedBox(
        width: 500.0,
        child: RefreshIndicator(
          onRefresh: () async {
            await ref.read(allComputerProvider.notifier).getAllComputerDetail();
          },
          child: ListView.builder(
            key: const PageStorageKey(0),
            itemCount: dataList.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  minVerticalPadding: 0.0,
                  visualDensity:
                      const VisualDensity(horizontal: 0, vertical: -4),
                  title: Text(dataList[index].hostname),
                  onTap: () {
                    showDataModal(context, dataList[index]);
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
