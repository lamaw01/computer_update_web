import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../data/add_update_status_riverpod.dart';
import '../data/update_riverpod.dart';
import '../data/update_status.riverpod.dart';

class UpdateView extends ConsumerStatefulWidget {
  const UpdateView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UpdateViewState();
}

class _UpdateViewState extends ConsumerState<UpdateView> {
  void addUpdateDialog() {
    bool status = true;
    bool updateCode = false;
    showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('New Update Status'),
          content: StatefulBuilder(
            builder: (context, setState) {
              return SizedBox(
                width: 300.0,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 100.0,
                          child: Text(
                            'Status: ',
                            textAlign: TextAlign.right,
                          ),
                        ),
                        SizedBox(
                          width: 100.0,
                          child: CupertinoSwitch(
                            value: status,
                            onChanged: (value) async {
                              setState(() {
                                status = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 100.0,
                          child: Text(
                            'Update Code: ',
                            textAlign: TextAlign.right,
                          ),
                        ),
                        SizedBox(
                          width: 100.0,
                          child: CupertinoSwitch(
                            activeColor: Colors.blue,
                            value: updateCode,
                            onChanged: (value) async {
                              setState(() {
                                updateCode = value;
                              });
                            },
                          ),
                        ),
                      ],
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
                await ref.read(addUpdateStatusFutureProvider(
                        AddUpdateAtg(status: status, updateCode: updateCode))
                    .future);
                ref.read(updateAsyncProvider.notifier).refresh();
              },
            ),
          ],
        );
      },
    );
  }

  bool isTrue(int value) {
    if (value == 1) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final valueAsync = ref.watch(updateAsyncProvider);
    final dateFormat = DateFormat('yyyy-MM-dd hh:mm');
    final update = ref.read(updateAsyncProvider.notifier);
    return Scaffold(
      body: valueAsync.when(
        data: (data) {
          return Center(
            child: SizedBox(
              width: 500.0,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 50.0,
                      width: 500.0,
                      color: Colors.grey[400],
                      child: const Row(
                        children: [
                          Flexible(
                            child: SizedBox(
                              width: 100.0,
                              child: Text(
                                'ID',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 16.0),
                              ),
                            ),
                          ),
                          Flexible(
                            child: SizedBox(
                              width: 100.0,
                              child: Text(
                                'Status',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 16.0),
                              ),
                            ),
                          ),
                          Flexible(
                            child: SizedBox(
                              width: 100.0,
                              child: Text(
                                'Update Code',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 16.0),
                              ),
                            ),
                          ),
                          Flexible(
                            child: SizedBox(
                              width: 200.0,
                              child: Text(
                                'Timestamp',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 16.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: () async {},
                        child: ListView.separated(
                          separatorBuilder: (context, index) => const Divider(),
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return SizedBox(
                              height: 50.0,
                              width: 500.0,
                              child: Row(
                                children: [
                                  Flexible(
                                    child: SizedBox(
                                      width: 100.0,
                                      child: Text(
                                        data[index].id.toString(),
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(fontSize: 14.0),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: SizedBox(
                                      width: 100.0,
                                      child: CupertinoSwitch(
                                        value: isTrue(data[index].status),
                                        onChanged: (value) async {
                                          setState(() {
                                            data[index].status = value ? 1 : 0;
                                          });
                                          await ref.read(
                                              updateStatusFutureProvider(
                                                      data[index])
                                                  .future);
                                          update.refresh();
                                        },
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: SizedBox(
                                      width: 100.0,
                                      child: CupertinoSwitch(
                                        activeColor: Colors.blue,
                                        value: isTrue(data[index].updateCode),
                                        onChanged: (value) async {
                                          setState(() {
                                            data[index].updateCode =
                                                value ? 1 : 0;
                                          });
                                          await ref.read(
                                              updateStatusFutureProvider(
                                                      data[index])
                                                  .future);
                                          update.refresh();
                                        },
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: SizedBox(
                                      width: 200.0,
                                      child: Text(
                                        dateFormat
                                            .format(data[index].timeStamp),
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(fontSize: 14.0),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        error: (object, stackTrace) {
          return Center(child: Text(object.toString()));
        },
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrange,
        child: const Text('Add'),
        onPressed: () {
          addUpdateDialog();
        },
      ),
    );
  }
}
