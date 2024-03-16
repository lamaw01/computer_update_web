import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/dio_service.dart';

class NoteArgUpdate {
  int id;
  String note;
  String uuid;

  NoteArgUpdate({required this.id, required this.note, required this.uuid});
}

final updateNoteFutureProvider =
    FutureProvider.family.autoDispose<void, NoteArgUpdate>(
  (ref, model) {
    return DioService()
        .updateNote(id: model.id, note: model.note, uuid: model.uuid);
  },
);
