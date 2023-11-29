import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/computer_detail_model.dart';
import 'computer_detail_riverpod.dart';

final firstFloorProvider =
    NotifierProvider<FirstFloorProvider, List<ComputerDetailModel>>(
        FirstFloorProvider.new);

class FirstFloorProvider extends Notifier<List<ComputerDetailModel>> {
  @override
  List<ComputerDetailModel> build() {
    return <ComputerDetailModel>[];
  }

  void sortFirstFloorComputerDetail() async {
    final allComputer = ref.read(allComputerProvider);
    final sortedList1 = allComputer.where((e) {
      return e.hostname.substring(0, 1) == '1';
    });
    state.clear();
    state.addAll(sortedList1);
  }
}
