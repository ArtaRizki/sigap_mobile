import 'dart:convert';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:sigap_mobile/common/base/base_controller.dart';
import 'package:sigap_mobile/src/pre_inspection/data_table/data_table_event.dart';
import 'package:sigap_mobile/src/pre_inspection/data_table/data_table_response.dart';
import 'package:sigap_mobile/src/pre_inspection/data_table/data_table_state.dart';

import 'package:http/http.dart' as http;

class DataTableBloc extends Bloc<DataTableEvent, DataTableState> {
  DataTableBloc() : super(DataTableInitial()) {
    on<FetchDataTable>(_onFetchDataTable);
  }

  Future<void> _onFetchDataTable(
      FetchDataTable event, Emitter<DataTableState> emit) async {
    emit(DataTableLoading());
    try {
      // final response = await http.get(
      //   Uri.parse(
      //       'https://sigap-api.erdata.id/api/Mobile/PreInspectionMobile/GetPreInspection'),
      //   headers: {
      //     'Authorization':
      //         'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJKV1RTZXJ2aWNlQWNjZXNzVG9rZW4iLCJqdGkiOiJiODhkNWNhZi1hNzQ1LTQ4YzItYjM4ZS1lMjE5ODcyMmIyM2MiLCJpYXQiOiIxNzMwNzc5NzkwIiwiaHR0cDovL3NjaGVtYXMueG1sc29hcC5vcmcvd3MvMjAwNS8wNS9pZGVudGl0eS9jbGFpbXMvbmFtZWlkZW50aWZpZXIiOiIyMSIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL25hbWUiOiJ0ZXJtaW5hbG1hbmFnZXIiLCJpZCI6IjIxIiwidXNlcm5hbWUiOiJ0ZXJtaW5hbG1hbmFnZXIiLCJlbWFpbCI6Im1hbmFnZXIudGVybWluYWxAbWFpbC5jb20iLCJjb21wYW55X2lkIjoiMyIsInN1cGVyYWRtaW4iOiIwIiwic3RhdHVzIjoiMSIsImphYmF0YW4iOiJNQU5BR0VSIiwicGVyc29uaWxfaWQiOiIxNDAxIiwicGVyc29uaWxfbmFtZSI6Ik1hbmFnZXIgVFBTIiwiY2FiYW5nX2lkIjoiMzUiLCJjYWJhbmdfY29kZSI6IkNBQjIwIiwiY2FiYW5nX25hbWUiOiJURVJNSU5BTCBQRVRJS0VNQVMgU1VSQUJBWUEiLCJyZWdpb25hbF9pZCI6IjIiLCJyZWdpb25hbF9jb2RlIjoiUkVHMDIiLCJyZWdpb25hbF9uYW1lIjoiU1BUUCIsImNvbXBhbnlfbmFtZSI6IlRQUyIsImNvbXBhbnlfdHlwZSI6IlRlcm1pbmFsIiwiYXNzZXRfaWQiOiIwIiwiYXNzZXRfbmFtZSI6IiIsImlzX3B1c2F0IjoiMSIsInRva2VuX2NlbnRyYSI6ImV5SjBlWEFpT2lKS1YxUWlMQ0poYkdjaU9pSklVekkxTmlKOS5leUpwYzNNaU9pSm9kSFJ3Y3pwY0wxd3ZZMlZ1ZEhKaExXUmxkaTV3Wld4cGJtUnZMbU52TG1sa1hDOXdkV0pzYVdOY0wyRndhVnd2Ykc5bmFXNHRiVzlpYVd4bElpd2lhV0YwSWpveE56STRNRFEyTURneExDSmxlSEFpT2pFM05UazFPREl3T0RFc0ltNWlaaUk2TVRjeU9EQTBOakE0TVN3aWFuUnBJam9pVVdSV2NXbFdibTlrTTJKVk0zSlRiU0lzSW5OMVlpSTZNU3dpY0hKMklqb2lNREpsT1dNNFptWTBNV05qWldJM1pUQmtNakJpTW1RNE5EVXhaR1EyTmpZd1pHWTJOalJpTlNKOS4yMlhFS0xCMlY4UmJjS2tjWXlaZTVvMU5kVVU5bDRBcTF6dmFxdWE2Wk53IiwiY29tcGFueV9zYXAiOiIzMjAwIiwicGxhbnRfc2FwIjoiMzIwMSIsIm1hbmR0IjoiMTMwIiwicGFyZW50X2NvbXBhbnkiOiIiLCJjb21wX2NhdGVnb3J5IjoiYm0iLCJyb2xlX2lkIjoiNSIsInBlcm1pc3Npb25zIjoiTURBU0gsTVBSSUxDLE1QUklMWCIsImV4cCI6MTczMTM4NDU5MCwiaXNzIjoiQklNQSIsImF1ZCI6IkJJTUEifQ._4RKxIjsMioFTBjL3aNIFB22pjTMNHwWtANc8sZFsDo'
      //   },
      // );
      // log("RESPONSE GET DATA : ${response.body}");
      final response = await BaseController().get(
          'https://sigap-api.erdata.id/api/Mobile/PreInspectionMobile/GetPreInspection');

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        // final dataList = jsonResponse['data'] as List;
        // final data =
        //     dataList.map((item) => DataTableResponse.fromJson(item)).toList();
        final data = DataTableResponse.fromJson(jsonResponse);
        emit(DataTableSuccess(data));
      } else {
        emit(DataTableFailure('Failed to load data'));
      }
    } catch (e) {
      emit(DataTableFailure(e.toString()));
    }
  }
}
