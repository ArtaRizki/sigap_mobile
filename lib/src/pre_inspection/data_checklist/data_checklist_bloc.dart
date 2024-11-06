import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'dart:convert';
import 'package:sigap_mobile/common/base/base_controller.dart';
import 'package:sigap_mobile/src/pre_inspection/data_checklist/data_checklist_event.dart';
import 'package:sigap_mobile/src/pre_inspection/data_checklist/data_checklist_response.dart';
import 'package:sigap_mobile/src/pre_inspection/data_checklist/data_checklist_state.dart';

class DataChecklistBloc extends Bloc<DataChecklistEvent, DataChecklistState> {
  DataChecklistBloc() : super(DataChecklistInitial()) {
    on<ChangeStatuseDataChecklistEvent>((event, emit) {
      var dataAll = event.data;

      dataAll[event.index]?.status = event.status;
      event.data[event.index] = dataAll[event.index];
      log("DATA STATUS : ${event.data[event.index]?.status == 1 ? 'Baik' : 'Tidak Baik'}");
      emit(DataChecklistLoaded(checklists: dataAll));
    });
    on<SaveNoteDataChecklistEvent>((event, emit) async {
      var dataAll = event.data;

      dataAll[event.index]?.reason = event.note;
      dataAll[event.index]?.filename = event.imagePath;
      event.data[event.index] = dataAll[event.index];
      log("DATA INDEX : ${event.data[event.index]?.filename ?? ''}");
      emit(DataChecklistLoaded(checklists: dataAll));
    });
    on<DeleteImageNoteDataChecklistEvent>((event, emit) async {
      var dataAll = event.data;
      event.data[event.index]?.filename = null;
      emit(DataChecklistLoaded(checklists: dataAll));
    });
    on<FetchDataChecklist>((event, emit) async {
      emit(DataChecklistLoading());
      try {
        final response = await BaseController().get(
            'https://sigap-api.erdata.id/api/Mobile/ChecklistMobile/getFilterByCode/?type=${event.type}&code=${event.code}');

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          if (data['status'] == 'S') {
            List<DataChecklistResponseData> checklists = (data['data'] as List)
                .map((item) => DataChecklistResponseData.fromJson(item))
                .toList();
            emit(DataChecklistLoaded(checklists: checklists));
          } else {
            emit(DataChecklistError(message: 'Failed to load data'));
          }
        } else {
          emit(DataChecklistError(message: 'Failed to fetch data'));
        }
      } catch (e) {
        emit(DataChecklistError(message: e.toString()));
      }
    });
  }
}
