import 'package:computer_detail_web/model/note_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/dio_service.dart';

final getNoteFutureProvider =
    FutureProvider.family.autoDispose<NoteModel, String>(
  (ref, uuid) {
    return DioService().getNote(uuid: uuid);
  },
);
