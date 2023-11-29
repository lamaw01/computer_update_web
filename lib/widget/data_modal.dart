import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/computer_detail_model.dart';
import 'detail_column.dart';

void showDataModal(BuildContext context, ComputerDetailModel model) {
  final dateFormat = DateFormat().add_yMEd().add_Hms();
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
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
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
                  Text('Hostname: ${model.hostname}'),
                  Text('UUID: ${model.uuid}'),
                  Text('Network: ${model.network}'),
                  Text('Last Update: ${dateFormat.format(model.timeStamp)}'),
                  Text('Update ID: ${model.updateId}'),
                  const SizedBox(height: 20.0),
                  SizedBox(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        DetailColumn(title: 'Os', data: model.os),
                        const SizedBox(width: 50.0),
                        DetailColumn(title: 'Defender', data: model.defender),
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
                        DetailColumn(title: 'Cpu', data: model.cpu),
                        const SizedBox(width: 50.0),
                        DetailColumn(
                            title: 'Motherboard', data: model.motherboard),
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
                        DetailColumn(title: 'Ram', data: model.ram),
                        const SizedBox(width: 50.0),
                        DetailColumn(title: 'Storage', data: model.storage),
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
                        DetailColumn(title: 'User', data: model.user),
                        const SizedBox(width: 50.0),
                        DetailColumn(title: 'Monitor', data: model.monitor),
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
                        DetailColumn(title: 'Browser', data: model.browser),
                        const SizedBox(width: 50.0),
                        DetailColumn(title: 'MS Office', data: model.msoffice),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20.0),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
