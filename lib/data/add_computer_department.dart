import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/computer_department_arg_model.dart';
import '../services/dio_service.dart';

final addComputerDepartmentFutureProvider =
    FutureProvider.family.autoDispose<void, ComputerDepartmentArg>(
  (ref, arg) {
    return DioService().addComputerDepartment(arg.uuid, arg.departmentID);
  },
);
