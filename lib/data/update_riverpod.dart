import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/update_model.dart';
import '../services/dio_service.dart';

final updateProvider =
    AutoDisposeAsyncNotifierProvider<UpdateRiverpod, List<UpdateModel>>(
        UpdateRiverpod.new);

class UpdateRiverpod extends AutoDisposeAsyncNotifier<List<UpdateModel>> {
  @override
  Future<List<UpdateModel>> build() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(DioService().getUpdate);
    return DioService().getUpdate();
  }
}
