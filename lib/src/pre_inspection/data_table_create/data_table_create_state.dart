import 'package:equatable/equatable.dart';

class DataTableCreateState extends Equatable {
  final DateTime? selectedDate;
  final String? selectedTerminal;
  final String? selectedTool;
  final int? selectedToolId;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  const DataTableCreateState({
    this.selectedDate,
    this.selectedTerminal,
    this.selectedTool,
    this.selectedToolId,
    this.isSubmitting = false,
    this.isSuccess = false,
    this.isFailure = false,
  });

  factory DataTableCreateState.initial() {
    return const DataTableCreateState(
      selectedDate: null,
      selectedTerminal: null,
      selectedTool: null,
      selectedToolId: null,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  DataTableCreateState copyWith({
    DateTime? selectedDate,
    String? selectedTerminal,
    String? selectedTool,
    int? selectedToolId,
    bool? isSubmitting,
    bool? isSuccess,
    bool? isFailure,
  }) {
    return DataTableCreateState(
      selectedDate: selectedDate ?? this.selectedDate,
      selectedTerminal: selectedTerminal ?? this.selectedTerminal,
      selectedTool: selectedTool ?? this.selectedTool,
      selectedToolId: selectedToolId ?? this.selectedToolId,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
    );
  }

  @override
  List<Object?> get props => [
        selectedDate,
        selectedTerminal,
        selectedTool,
        selectedToolId,
        isSubmitting,
        isSuccess,
        isFailure
      ];
}
