import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/dio_service.dart';

class AddUpdateAtg {
  final bool status;
  final bool updateCode;
  final bool updateOnce;

  AddUpdateAtg({
    required this.status,
    required this.updateCode,
    required this.updateOnce,
  });
}

final addUpdateStatusFutureProvider =
    FutureProvider.family.autoDispose<void, AddUpdateAtg>(
  (ref, model) {
    return DioService().addUpdateStatus(
      status: model.status ? 1 : 0,
      updateCode: model.updateCode ? 1 : 0,
      updateOnce: model.updateOnce ? 1 : 0,
    );
  },
);
