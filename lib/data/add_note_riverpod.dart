import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/dio_service.dart';

class NoteArg {
  String note;
  String updateId;
  String uuid;

  NoteArg({required this.note, required this.updateId, required this.uuid});
}

final addNoteFutureProvider = FutureProvider.family.autoDispose<void, NoteArg>(
  (ref, model) {
    return DioService()
        .addNote(note: model.note, updateId: model.updateId, uuid: model.uuid);
  },
);
