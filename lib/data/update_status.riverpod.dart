import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/update_model.dart';
import '../services/dio_service.dart';

final updateStatusFutureProvider =
    FutureProvider.family.autoDispose<void, UpdateModel>(
  (ref, model) {
    return DioService().updateStatus(
      id: model.id,
      status: model.status,
      updateCode: model.updateCode,
      updateOnce: model.updateOnce,
    );
  },
);
