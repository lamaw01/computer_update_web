import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/computer_detail_model.dart';
import 'computer_detail_riverpod.dart';

final thirdFloorProvider =
    NotifierProvider<ThirdFloorProvider, List<ComputerDetailModel>>(
        ThirdFloorProvider.new);

class ThirdFloorProvider extends Notifier<List<ComputerDetailModel>> {
  @override
  List<ComputerDetailModel> build() {
    return <ComputerDetailModel>[];
  }

  void sortThirdFloorComputerDetail() {
    final allComputer = ref.read(allComputerProvider);
    final sortedList3 = allComputer.where((e) {
      return e.hostname.substring(0, 1) == '3';
    });
    state.clear();
    state.addAll(sortedList3);
  }
}
