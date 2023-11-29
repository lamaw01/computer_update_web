import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/computer_detail_model.dart';
import 'computer_detail_riverpod.dart';

final secondFloorProvider =
    NotifierProvider<SecondFloorProvider, List<ComputerDetailModel>>(
        SecondFloorProvider.new);

class SecondFloorProvider extends Notifier<List<ComputerDetailModel>> {
  @override
  List<ComputerDetailModel> build() {
    return <ComputerDetailModel>[];
  }

  void sortSecondFloorComputerDetail() async {
    final allComputer = ref.read(allComputerProvider);
    final sortedList2 = allComputer.where((e) {
      return e.hostname.substring(0, 1) == '2';
    });
    state.clear();
    state.addAll(sortedList2);
  }
}
