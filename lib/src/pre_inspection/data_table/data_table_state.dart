import 'package:equatable/equatable.dart';
import 'package:sigap_mobile/src/pre_inspection/data_table/data_table_response.dart';

abstract class DataTableState extends Equatable {
  @override
  List<Object> get props => [];
}

class DataTableInitial extends DataTableState {}

class DataTableLoading extends DataTableState {}

class DataTableSuccess extends DataTableState {
  final DataTableResponse data;

  DataTableSuccess(this.data);

  @override
  List<Object> get props => [data];
}

class DataTableFailure extends DataTableState {
  final String error;

  DataTableFailure(this.error);

  @override
  List<Object> get props => [error];
}
