import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/computer_detail_model.dart';
import '../services/dio_service.dart';

final historyProvider =
    NotifierProvider<History, List<ComputerDetailModel>>(History.new);

class History extends Notifier<List<ComputerDetailModel>> {
  @override
  List<ComputerDetailModel> build() {
    return <ComputerDetailModel>[];
  }

  Future<void> getHistory(String uuid) async {
    try {
      state = await DioService().getHistory(uuid);
    } catch (e) {
      log(e.toString());
    }
  }
}
