import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/add_department_riverpod.dart';
import '../data/get_department.dart';

class DepartmentView extends ConsumerStatefulWidget {
  const DepartmentView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DepartmentViewState();
}

class _DepartmentViewState extends ConsumerState<DepartmentView> {
  final TextEditingController department = TextEditingController();
  void addDepartmentDialog() {
    showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('New Department'),
          content: StatefulBuilder(
            builder: (context, setState) {
              return SizedBox(
                width: 300.0,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 250.0,
                      child: TextField(
                        controller: department,
                        decoration: InputDecoration(
                          hintText: 'Department..',
                          // labelText: 'Ip',
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.red,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Cancel',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onPressed: () async {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(
                'Ok',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onPressed: () async {
                Navigator.of(context).pop();
                await ref.read(
                    addDepartmentFutureProvider(department.text.trim()).future);
                await ref.read(departmentProvider.notifier).getDepartment();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final departmentList = ref.watch(departmentProvider);
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 500.0,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView.builder(
              key: const PageStorageKey(1),
              itemCount: departmentList.length,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return const SizedBox();
                }
                return Card(
                  child: ListTile(
                    minVerticalPadding: 0.0,
                    visualDensity:
                        const VisualDensity(horizontal: 0, vertical: -4),
                    title: Text(departmentList[index].department),
                    onTap: () {},
                  ),
                );
              },
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrange,
        child: const Text('Add'),
        onPressed: () {
          addDepartmentDialog();
        },
      ),
    );
  }
}
