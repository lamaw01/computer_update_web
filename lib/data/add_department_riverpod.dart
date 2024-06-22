import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/dio_service.dart';

final addDepartmentFutureProvider =
    FutureProvider.family.autoDispose<void, String>(
  (ref, department) {
    return DioService().addDepartment(department: department);
  },
);
