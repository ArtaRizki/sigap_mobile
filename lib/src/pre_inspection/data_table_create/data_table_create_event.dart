import 'package:equatable/equatable.dart';
import 'package:sigap_mobile/src/pre_inspection/data_checklist/data_checklist_response.dart';
import 'package:sigap_mobile/src/pre_inspection/data_table_create/asset_search/asset_response.dart';
import 'package:sigap_mobile/src/pre_inspection/data_table_create/data_table_create_param.dart';

abstract class DataTableCreateEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class InitForm extends DataTableCreateEvent {}

class InitEditForm extends DataTableCreateEvent {
  final int id;

  InitEditForm(this.id);

  @override
  List<Object> get props => [id];
}

class InitEditFormSuccess extends DataTableCreateEvent {}

class DateSelected extends DataTableCreateEvent {
  final DateTime date;

  DateSelected(this.date);

  @override
  List<Object> get props => [date];
}

class TerminalSelected extends DataTableCreateEvent {
  final String terminal;

  TerminalSelected(this.terminal);

  @override
  List<Object> get props => [terminal];
}

class ToolSelected extends DataTableCreateEvent {
  final AssetResponseData tool;

  ToolSelected(this.tool);

  @override
  List<Object> get props => [tool];
}

class SubmitForm extends DataTableCreateEvent {
  final DataTableCreateParam dataTableCreateParam;

  SubmitForm(this.dataTableCreateParam);

  @override
  List<Object> get props => [dataTableCreateParam];
}

class SendForm extends DataTableCreateEvent {
  final DataTableCreateParam dataTableCreateParam;
  final List<DataChecklistResponseData?> checkListData;

  SendForm(this.dataTableCreateParam, this.checkListData);

  @override
  List<Object> get props => [dataTableCreateParam, checkListData];
}
