import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../data/add_note_riverpod.dart';
import '../data/computer_history_riverpod.dart';
import '../data/get_note_riverpod.dart';
import '../model/computer_detail_model.dart';
import '../model/note_model.dart';
import 'detail_column.dart';

void showAddNote(
    BuildContext context, ComputerDetailModel model, WidgetRef ref) async {
  NoteModel? notemode;

  try {
    await ref
        .read(getNoteFutureProvider(model.uuid).future)
        .then((value) => notemode = value);
  } catch (e) {
    log('$e');
  } finally {
    // ignore: use_build_context_synchronously
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        final notes = TextEditingController(text: notemode?.note ?? '');
        return AlertDialog(
          title: const Text('Remarks'),
          content: SizedBox(
            width: 400.0,
            child: StatefulBuilder(
              builder: (context, setState) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 100.0,
                      width: 400.0,
                      child: TextField(
                        controller: notes,
                        keyboardType: TextInputType.multiline,
                        minLines: 5,
                        maxLines: 5,
                        maxLength: 254,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                          ),
                          hintText: 'Note..',
                          contentPadding:
                              EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          actions: [
            TextButton(
              child: const Text(
                'Cancel',
                style: TextStyle(fontSize: 16.0),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(
                'Ok',
                style: TextStyle(fontSize: 16.0),
              ),
              onPressed: () async {
                Navigator.of(context).pop();
                await ref.read(addNoteFutureProvider(NoteArg(
                        note: notes.text.trim(),
                        updateId: model.updateId,
                        uuid: model.uuid))
                    .future);
              },
            ),
          ],
        );
      },
    );
  }
}

void showHistory(
    BuildContext context, ComputerDetailModel model, WidgetRef ref) async {
  await ref.read(historyProvider.notifier).getHistory(model.uuid);
  final dataList = ref.watch(historyProvider);
  // ignore: use_build_context_synchronously
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('History'),
        content: SizedBox(
          height: 400.0,
          width: 400.0,
          child: ListView.builder(
            key: const PageStorageKey(0),
            itemCount: dataList.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  minVerticalPadding: 0.0,
                  visualDensity:
                      const VisualDensity(horizontal: 0, vertical: -4),
                  title: Text('Update ID ${dataList[index].updateId}'),
                  onTap: () {
                    Navigator.pop(context);
                    _currentModalData.value = dataList[index];
                  },
                ),
              );
            },
          ),
        ),
      );
    },
  );
}

var _currentModalData = ValueNotifier<ComputerDetailModel>(ComputerDetailModel(
  browser: '',
  id: 0,
  uuid: '',
  hostname: '',
  os: '',
  defender: '',
  cpu: '',
  gpu: '',
  motherboard: '',
  ram: '',
  storage: '',
  user: '',
  network: '',
  monitor: '',
  timeStamp: DateTime.now(),
  msoffice: '',
  updateId: '',
));

void showDataModal(
    BuildContext context, ComputerDetailModel model, WidgetRef ref) {
  final dateFormat = DateFormat().add_yMEd().add_Hms();
  _currentModalData.value = model;
  showModalBottomSheet(
    context: context,
    showDragHandle: true,
    isScrollControlled: true,
    isDismissible: true,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
      topRight: Radius.circular(20.0),
      topLeft: Radius.circular(20.0),
    )),
    builder: (context) {
      return DraggableScrollableSheet(
        initialChildSize: 0.90,
        minChildSize: 0.90,
        maxChildSize: 0.90,
        expand: false,
        builder: (_, controller) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ValueListenableBuilder(
                  valueListenable: _currentModalData,
                  builder: (context, value, widget) {
                    return Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              child: const Text('Show Note'),
                              onPressed: () {
                                showAddNote(context, value, ref);
                              },
                            ),
                            const SizedBox(width: 10.0),
                            ElevatedButton(
                              child: const Text('History'),
                              onPressed: () {
                                showHistory(context, value, ref);
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 15.0),
                        Container(
                          color: Colors.grey[400],
                          height: 30.0,
                          width: 325.0,
                          child: const Center(
                            child: Text(
                              'Computer Profile Summary',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18.0),
                            ),
                          ),
                        ),
                        const SizedBox(height: 5.0),
                        SelectableText('Hostname: ${value.hostname}'),
                        SelectableText('UUID: ${value.uuid}'),
                        SelectableText('Network: ${value.network}'),
                        Text(
                            'Last Update: ${dateFormat.format(value.timeStamp)}'),
                        Text('Update ID: ${value.updateId}'),
                        const SizedBox(height: 20.0),
                        SizedBox(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              DetailColumn(title: 'Os', data: value.os),
                              const SizedBox(width: 50.0),
                              DetailColumn(
                                  title: 'Defender', data: value.defender),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        SizedBox(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              DetailColumn(title: 'Cpu', data: value.cpu),
                              const SizedBox(width: 50.0),
                              DetailColumn(
                                  title: 'Motherboard',
                                  data: value.motherboard),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        SizedBox(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              DetailColumn(title: 'Ram', data: value.ram),
                              const SizedBox(width: 50.0),
                              DetailColumn(
                                  title: 'Storage', data: value.storage),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        SizedBox(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              DetailColumn(title: 'User', data: value.user),
                              const SizedBox(width: 50.0),
                              DetailColumn(
                                  title: 'Monitor', data: value.monitor),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        SizedBox(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              DetailColumn(
                                  title: 'Browser', data: value.browser),
                              const SizedBox(width: 50.0),
                              DetailColumn(
                                  title: 'MS Office', data: value.msoffice),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        SizedBox(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              DetailColumn(title: 'Gpu', data: value.gpu),
                            ],
                          ),
                        ),
                      ],
                    );
                  }),
            ),
          );
        },
      );
    },
  );
}
