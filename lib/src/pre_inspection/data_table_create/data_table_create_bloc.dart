import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sigap_mobile/common/base/base_controller.dart';
import 'package:sigap_mobile/common/helper/constant.dart';
import 'package:sigap_mobile/src/pre_inspection/data_table_create/data_table_create_event.dart';
import 'package:sigap_mobile/src/pre_inspection/data_table_create/data_table_create_state.dart';

import 'package:http/http.dart' as http;
import 'package:sigap_mobile/src/pre_inspection/single_data_response.dart';

class DataTableCreateBloc
    extends Bloc<DataTableCreateEvent, DataTableCreateState> {
  DataTableCreateBloc() : super(DataTableCreateState.initial()) {
    on<InitEditForm>((event, emit) async {
      try {
        final response = await _getData('${event.id}');
        if (response.statusCode == 200) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          var terminalName = prefs.getString(Constant.kSetPrefCompany);
          var terminalId = prefs.getInt(Constant.kSetPrefCompanyId);
          final data = jsonDecode(response.body);
          final result = SingleDataResponse.fromJson(data);
          final resultData = result.data;
          DateTime date = DateFormat("MM/dd/yyyy HH:mm:ss")
              .parse(result.data?.dateDoc ?? '${DateTime.now()}');
          emit(state.copyWith(
            selectedDate: date,
            selectedTerminal: terminalName,
            selectedTerminalId: terminalId,
            selectedTool: resultData?.assetName,
            selectedToolId: resultData?.assetId,
          ));
        } else {
          emit(state.copyWith(isFailure: true, isSubmitting: false));
        }
      } catch (_) {
        emit(state.copyWith(isFailure: true, isSubmitting: false));
      }
    });
    on<DateSelected>((event, emit) {
      emit(state.copyWith(selectedDate: event.date));
    });

    on<TerminalSelected>((event, emit) {
      emit(state.copyWith(selectedTerminal: event.terminal));
    });

    on<ToolSelected>((event, emit) {
      emit(state.copyWith(selectedTool: event.tool));
    });

    on<SubmitForm>((event, emit) async {
      emit(state.copyWith(isSubmitting: true));

      // Simulate a network call (Replace this with the actual API call in production)
      await Future.delayed(Duration(seconds: 2));

      // On success, yield a new state
      emit(state.copyWith(isSubmitting: false, isSuccess: true));
    });
  }

  Future<http.Response> _getData(String id) async {
    var url =
        'https://sigap-api.erdata.id/api/Mobile/PreInspectionMobile/GetData/$id';

    Response response = await BaseController().get(url);
    return response;
  }
}
