import 'package:equatable/equatable.dart';
import 'package:sigap_mobile/src/pre_inspection/data_table_create/data_table_create_param.dart';

class DataTableCreateState extends Equatable {
  final DateTime? selectedDate;
  final String? selectedTerminal;
  final int? selectedTerminalId;
  final String? selectedTool;
  final int? selectedToolId;
  final DataTableCreateParam? dataTableCreateParam;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isSuccessSend;
  final bool isFailure;

  const DataTableCreateState({
    this.selectedDate,
    this.selectedTerminal,
    this.selectedTerminalId,
    this.selectedTool,
    this.selectedToolId,
    this.dataTableCreateParam,
    this.isSubmitting = false,
    this.isSuccess = false,
    this.isSuccessSend = false,
    this.isFailure = false,
  });

  factory DataTableCreateState.initial() {
    return const DataTableCreateState(
      selectedDate: null,
      selectedTerminal: null,
      selectedTerminalId: null,
      selectedTool: null,
      selectedToolId: null,
      dataTableCreateParam: null,
      isSubmitting: false,
      isSuccess: false,
      isSuccessSend: false,
      isFailure: false,
    );
  }

  DataTableCreateState copyWith({
    DateTime? selectedDate,
    String? selectedTerminal,
    int? selectedTerminalId,
    String? selectedTool,
    int? selectedToolId,
    DataTableCreateParam? dataTableCreateParam,
    bool? isSubmitting,
    bool? isSuccess,
    bool? isSuccessSend,
    bool? isFailure,
  }) {
    return DataTableCreateState(
      selectedDate: selectedDate ?? this.selectedDate,
      selectedTerminal: selectedTerminal ?? this.selectedTerminal,
      selectedTerminalId: selectedTerminalId ?? this.selectedTerminalId,
      selectedTool: selectedTool ?? this.selectedTool,
      selectedToolId: selectedToolId ?? this.selectedToolId,
      dataTableCreateParam: dataTableCreateParam ?? this.dataTableCreateParam,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isSuccessSend: isSuccessSend ?? this.isSuccessSend,
      isFailure: isFailure ?? this.isFailure,
    );
  }

  @override
  List<Object?> get props => [
        selectedDate,
        selectedTerminal,
        selectedTerminalId,
        selectedTool,
        selectedToolId,
        dataTableCreateParam,
        isSubmitting,
        isSuccess,
        isSuccessSend,
        isFailure
      ];
}
