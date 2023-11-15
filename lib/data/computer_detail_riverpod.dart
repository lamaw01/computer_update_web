import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/computer_detail_model.dart';
import '../services/dio_service.dart';

final computerDetailProvider =
    NotifierProvider<LatestEvent, List<ComputerDetailModel>>(LatestEvent.new);

class LatestEvent extends Notifier<List<ComputerDetailModel>> {
  @override
  List<ComputerDetailModel> build() {
    return <ComputerDetailModel>[];
  }

  Future<void> getAllComputerDetail() async {
    try {
      final latestEvent = await DioService().getAllComputerDetail();
      state = latestEvent;
    } catch (e) {
      log(e.toString());
    }
  }
}
