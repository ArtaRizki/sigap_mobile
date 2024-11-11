import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sigap_mobile/common/base/base_controller.dart';
import 'package:sigap_mobile/common/helper/constant.dart';
import 'package:sigap_mobile/common/helper/multipart.dart';
import 'package:sigap_mobile/src/pre_inspection/data_table_create/data_table_create_event.dart';
import 'package:sigap_mobile/src/pre_inspection/data_table_create/data_table_create_param.dart';
import 'package:sigap_mobile/src/pre_inspection/data_table_create/data_table_create_state.dart';

import 'package:http/http.dart' as http;
import 'package:sigap_mobile/src/pre_inspection/single_data_response.dart';

class DataTableCreateBloc
    extends Bloc<DataTableCreateEvent, DataTableCreateState> {
  DataTableCreateBloc() : super(DataTableCreateState.initial()) {
    on<InitForm>((event, emit) async {
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        if (!event.ispusat) {
          var terminalName = prefs.getString(Constant.kSetPrefCabang);
          var terminalId = prefs.getInt(Constant.kSetPrefCabangId);
          emit(state.copyWith(
            selectedTerminal: terminalName,
            selectedTerminalId: terminalId,
          ));
        }
      } catch (_) {
        emit(state.copyWith(isFailure: true, isSubmitting: false));
      }
    });
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
            selectedToolCode: resultData?.assetCategoryCode,
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
      emit(state.copyWith(
        selectedTerminal: event.terminal.name,
        selectedTerminalId: event.terminal.id,
      ));
    });

    on<ToolSelected>((event, emit) {
      emit(state.copyWith(
          selectedTool: event.tool.name,
          selectedToolCode: event.tool.jenisAssetCode,
          selectedToolId: event.tool.id));
    });

    on<SubmitForm>((event, emit) async {
      emit(state.copyWith(isSubmitting: false));

      // Simulate a network call (Replace this with the actual API call in production)
      await Future.delayed(Duration(seconds: 2));

      // On success, yield a new state
      emit(state.copyWith(
          dataTableCreateParam: event.dataTableCreateParam,
          isSubmitting: false,
          isSuccess: true));
    });
    on<SendForm>((event, emit) async {
      emit(state.copyWith(isSubmitting: true));
      var param = event.dataTableCreateParam;
      List<DataTableCreateParamItem?> tmp = [];
      log("ASET ID : ${param?.assetId}");
      ;
      log("ASSET CATEGORY CODE : ${param?.assetCategoryCode}");
      log("DATE DOC : ${param?.dateDoc}");
      log("DOC TYPE : ${param?.docType}");
      log("CHECKLIST DATA : ${event.checkListData.length}");
      event.checkListData.forEach((e) async {
        log("FILENAME : ${e?.filename}");
        bool exist = await File(e?.filename ?? '').exists();
        log("FILE EXIST : $exist");
        if (exist)
          tmp.add(DataTableCreateParamItem(
            id: e?.id,
            assetCategoryCode: e?.assetCategoryCode,
            type: e?.type,
            status: e?.status,
            fileName: e?.filename,
            reason: e?.reason,
          ));
      });
      // Simulate a network call (Replace this with the actual API call in production)
      await Future.delayed(Duration(seconds: 2));
      param.item = tmp;
      log("PARAM AFTER : ${tmp.length}");
      log("PARAM AFTER 2 : ${param.item?.length}");
      // On success, yield a new state
      try {
        final response = await _sendData(param);
        if (response.statusCode == 200 || response.statusCode == 201) {
          emit(state.copyWith(
            dataTableCreateParam: param,
            isSubmitting: false,
            isSuccess: true,
            isSuccessSend: true,
          ));
        } else {
          emit(state.copyWith(
            isFailure: true,
            isSubmitting: false,
            isSuccess: false,
          ));
        }
      } catch (e) {
        emit(state.copyWith(
          isFailure: true,
          isSubmitting: false,
          isSuccess: false,
        ));
      }
    });
  }

  Future<http.Response> _getData(String id) async {
    var url =
        'https://sigap-api.erdata.id/api/Mobile/PreInspectionMobile/GetData/$id';

    Response response = await BaseController().get(url);
    return response;
  }

  Future<http.Response> _sendData(DataTableCreateParam param) async {
    var url =
        'https://sigap-api.erdata.id/api/Mobile/PreInspectionMobile/Create';
    var body = {'data': jsonEncode(param)};

    List<http.MultipartFile> files = [];
    for (int i = 0; i < (param.item?.length ?? 0); i++) {
      final item = param.item?[i];
      if (item?.fileName != null) {
        var f = File(item?.fileName ?? '');
        files.add(await getMultipart('$i', f));
      }
    }
    Response response = await BaseController().post(
      url,
      body: body,
      headers: {'Content-Type': 'application/json'},
      files: files,
    );
    return response;
  }
}
