import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/get_department.dart';
import '../data/get_department_computer_detail.dart';
import '../data/others_riverpod.dart';
import '../widget/data_modal.dart';

class OthersView extends ConsumerStatefulWidget {
  const OthersView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OthersViewState();
}

class _OthersViewState extends ConsumerState<OthersView> {
  int currentIndex = 0;
  @override
  void initState() {
    super.initState();
    ref.read(othersProvider.notifier).sortOthersComputerDetail();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final departmentList = ref.watch(departmentProvider);
      for (int j = 0; j < departmentList.length; j++) {
        departmentList[j].selected = false;
      }
      setState(() {
        departmentList.first.selected = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final othersDataList = ref.watch(othersProvider);
    final departmentComputerDataList =
        ref.watch(departmentComputerDetailProvider);
    final departmentList = ref.watch(departmentProvider);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (currentIndex == 0) ...[
            Expanded(
              child: SizedBox(
                width: 500.0,
                child: ListView.builder(
                  key: const PageStorageKey(1),
                  itemCount: othersDataList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        minVerticalPadding: 0.0,
                        visualDensity:
                            const VisualDensity(horizontal: 0, vertical: -4),
                        title: Text(othersDataList[index].hostname),
                        subtitle: Text(othersDataList[index].note ?? ''),
                        onTap: () {
                          showDataModal(context, othersDataList[index], ref);
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
          ] else ...[
            Expanded(
              child: SizedBox(
                width: 500.0,
                child: ListView.builder(
                  key: const PageStorageKey(1),
                  itemCount: departmentComputerDataList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        minVerticalPadding: 0.0,
                        visualDensity:
                            const VisualDensity(horizontal: 0, vertical: -4),
                        title: Text(departmentComputerDataList[index].hostname),
                        subtitle:
                            Text(departmentComputerDataList[index].note ?? ''),
                        onTap: () {
                          showDataModal(
                              context, departmentComputerDataList[index], ref);
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
          Container(
            color: Colors.grey,
            height: 50.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: departmentList.length,
              itemBuilder: (context, i) {
                return TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor:
                        departmentList[i].selected ? Colors.orange : null,
                  ),
                  onPressed: () async {
                    for (int j = 0; j < departmentList.length; j++) {
                      departmentList[j].selected = false;
                    }
                    setState(() {
                      currentIndex = i;
                      departmentList[i].selected = !departmentList[i].selected;
                    });

                    await ref
                        .read(departmentComputerDetailProvider.notifier)
                        .getDepartmentComputerDetail(departmentList[i].id);
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
