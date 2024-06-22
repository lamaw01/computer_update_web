import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/department_model.dart';
import '../services/dio_service.dart';

final departmentProvider =
    NotifierProvider<Department, List<DepartmentModel>>(Department.new);

class Department extends Notifier<List<DepartmentModel>> {
  @override
  List<DepartmentModel> build() {
    return <DepartmentModel>[DepartmentModel(id: 0, department: 'All')];
  }

  Future<void> getDepartment() async {
    try {
      var result = await DioService().getDepartment();
      state.addAll(result);
    } catch (e) {
      log(e.toString());
    }
  }
}
