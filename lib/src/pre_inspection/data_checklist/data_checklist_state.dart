import 'package:sigap_mobile/src/pre_inspection/data_checklist/data_checklist_response.dart';

abstract class DataChecklistState {}

class DataChecklistInitial extends DataChecklistState {}

class DataChecklistLoading extends DataChecklistState {}

class DataChecklistLoaded extends DataChecklistState {
  final List<DataChecklistResponseData?> checklists;

  DataChecklistLoaded({required this.checklists});
}

// class DataChecklistSavedNote extends DataChecklistState {
//   final DataChecklistResponse data;

//   DataChecklistSavedNote({required this.data});
// }

class DataChecklistError extends DataChecklistState {
  final String message;

  DataChecklistError({required this.message});
}
