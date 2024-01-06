import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/computer_detail_model.dart';
import 'computer_detail_riverpod.dart';

final othersProvider =
    NotifierProvider<OthersProvider, List<ComputerDetailModel>>(
        OthersProvider.new);

class OthersProvider extends Notifier<List<ComputerDetailModel>> {
  @override
  List<ComputerDetailModel> build() {
    return <ComputerDetailModel>[];
  }

  void sortOthersComputerDetail() {
    final allComputer = ref.read(allComputerProvider);
    final sortedListOthers = allComputer.where((e) {
      return e.hostname.substring(0, 1) != '1' &&
          e.hostname.substring(0, 1) != '2' &&
          e.hostname.substring(0, 1) != '3';
    });
    state.clear();
    state.addAll(sortedListOthers);
  }
}
