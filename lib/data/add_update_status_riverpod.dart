import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/dio_service.dart';

class AddUpdateModel {
  final bool status;
  final bool updateCode;

  AddUpdateModel({required this.status, required this.updateCode});
}

final addUpdateStatusFutureProvider =
    FutureProvider.family.autoDispose<void, AddUpdateModel>(
  (ref, model) {
    return DioService().addUpdateStatus(
        status: model.status ? 1 : 0, updateCode: model.updateCode ? 1 : 0);
  },
);
