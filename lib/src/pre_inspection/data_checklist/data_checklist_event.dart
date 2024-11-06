import 'package:sigap_mobile/src/pre_inspection/data_checklist/data_checklist_response.dart';

abstract class DataChecklistEvent {}

class FetchDataChecklist extends DataChecklistEvent {
  final String type;
  final String code;

  FetchDataChecklist({required this.type, required this.code});
}

class SaveNoteDataChecklistEvent extends DataChecklistEvent {
  final int index;
  final String note;
  final String imagePath;
  final List<DataChecklistResponseData?> data;

  SaveNoteDataChecklistEvent(
      {required this.data,
      required this.index,
      required this.note,
      required this.imagePath});
}

class DeleteImageNoteDataChecklistEvent extends DataChecklistEvent {
  final int index;
  final List<DataChecklistResponseData?> data;

  DeleteImageNoteDataChecklistEvent(this.index, {required this.data});
}

class ChangeStatuseDataChecklistEvent extends DataChecklistEvent {
  final int index;
  final int status;
  final List<DataChecklistResponseData?> data;

  ChangeStatuseDataChecklistEvent(
      {required this.index, required this.status, required this.data});
}
