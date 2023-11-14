import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../data/update_riverpod.dart';

class UpdateView extends ConsumerStatefulWidget {
  const UpdateView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UpdateViewState();
}

class _UpdateViewState extends ConsumerState<UpdateView> {
  @override
  Widget build(BuildContext context) {
    bool isTrue(int value) {
      if (value == 1) {
        return true;
      }
      return false;
    }

    final valueAsync = ref.watch(updateProvider);
    final dateFormat = DateFormat().add_yMEd().add_Hm();
    return valueAsync.when(
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
                            width: 150.0,
                            child: Text(
                              'ID',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ),
                        ),
                        Flexible(
                          child: SizedBox(
                            width: 150.0,
                            child: Text(
                              'Status',
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
                            width: 600.0,
                            child: Row(
                              children: [
                                Flexible(
                                  child: SizedBox(
                                    width: 150.0,
                                    child: Text(
                                      data[index].id.toString(),
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(fontSize: 14.0),
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: SizedBox(
                                    width: 150.0,
                                    child: CupertinoSwitch(
                                      value: isTrue(data[index].status),
                                      onChanged: (value) {
                                        setState(() {
                                          data[index].status = value ? 1 : 0;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: SizedBox(
                                    width: 200.0,
                                    child: Text(
                                      dateFormat.format(data[index].timeStamp),
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
        return Text(object.toString());
      },
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
