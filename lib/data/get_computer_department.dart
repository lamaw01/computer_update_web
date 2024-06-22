import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/department_model.dart';
import '../services/dio_service.dart';

final getComputerDepartmentFutureProvider =
    FutureProvider.family.autoDispose<DepartmentModel, String>(
  (ref, uuid) {
    return DioService().getComputerDepartment(uuid);
  },
);
