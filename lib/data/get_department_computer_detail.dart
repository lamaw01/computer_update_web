import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/computer_detail_model.dart';
import '../services/dio_service.dart';

final departmentComputerDetailProvider =
    NotifierProvider<DepartmentComputerDetail, List<ComputerDetailModel>>(
        DepartmentComputerDetail.new);

class DepartmentComputerDetail extends Notifier<List<ComputerDetailModel>> {
  @override
  List<ComputerDetailModel> build() {
    return <ComputerDetailModel>[];
  }

  Future<void> getDepartmentComputerDetail(int departmentID) async {
    try {
      state = await DioService().getDepartmentComputerDetail(departmentID);
    } catch (e) {
      log(e.toString());
    }
  }
}
