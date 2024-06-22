import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/get_department.dart';
import '../data/others_riverpod.dart';
import '../widget/data_modal.dart';

class OthersView extends ConsumerStatefulWidget {
  const OthersView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OthersViewState();
}

class _OthersViewState extends ConsumerState<OthersView> {
  @override
  void initState() {
    super.initState();
    ref.read(othersProvider.notifier).sortOthersComputerDetail();
  }

  @override
  Widget build(BuildContext context) {
    final dataList = ref.watch(othersProvider);
    final departmentList = ref.watch(departmentProvider);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: SizedBox(
              width: 500.0,
              child: ListView.builder(
                key: const PageStorageKey(1),
                itemCount: dataList.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      minVerticalPadding: 0.0,
                      visualDensity:
                          const VisualDensity(horizontal: 0, vertical: -4),
                      title: Text(dataList[index].hostname),
                      subtitle: Text(dataList[index].note ?? ''),
                      onTap: () {
                        showDataModal(context, dataList[index], ref);
                      },
                    ),
                  );
                },
              ),
            ),
          ),
          Container(
            color: Colors.grey,
            height: 50.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: departmentList.length,
              itemBuilder: (context, i) {
                return TextButton(
                  onPressed: () {
                    //
                  },
                  child: Text(
                    departmentList[i].department,
                    style: const TextStyle(color: Colors.white),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
