import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/dio_service.dart';

class AddUpdateAtg {
  final bool status;
  final bool updateCode;

  AddUpdateAtg({required this.status, required this.updateCode});
}

final addUpdateStatusFutureProvider =
    FutureProvider.family.autoDispose<void, AddUpdateAtg>(
  (ref, model) {
    return DioService().addUpdateStatus(
        status: model.status ? 1 : 0, updateCode: model.updateCode ? 1 : 0);
  },
);
