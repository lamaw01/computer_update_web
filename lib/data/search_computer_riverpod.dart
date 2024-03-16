import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/computer_detail_model.dart';
import '../services/dio_service.dart';

final searchComputerProvider =
    NotifierProvider<HistoryComputer, List<ComputerDetailModel>>(
        HistoryComputer.new);

class HistoryComputer extends Notifier<List<ComputerDetailModel>> {
  @override
  List<ComputerDetailModel> build() {
    return <ComputerDetailModel>[];
  }

  Future<void> searchComputer(String search) async {
    try {
      state = await DioService().searchComputer(search);
      log(state.length.toString());
    } catch (e) {
      log(e.toString());
    }
  }
}
