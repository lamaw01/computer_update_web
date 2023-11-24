import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/computer_detail_model.dart';
import 'computer_detail_riverpod.dart';

final secondFloorProvider =
    NotifierProvider<LatestEvent, List<ComputerDetailModel>>(LatestEvent.new);

class LatestEvent extends Notifier<List<ComputerDetailModel>> {
  @override
  List<ComputerDetailModel> build() {
    return <ComputerDetailModel>[];
  }

  void sortSecondFloorComputerDetail() async {
    final allComputer = ref.read(allComputerlProvider);
    final sortedList1h = allComputer.where((e) {
      log(e.hostname.substring(0, 1));
      return e.hostname.substring(0, 1) == '2';
    });
    state.clear();
    state.addAll(sortedList1h);
  }
}
