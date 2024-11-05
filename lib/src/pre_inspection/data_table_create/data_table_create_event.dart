import 'package:equatable/equatable.dart';

abstract class DataTableCreateEvent extends Equatable {
  @override
  List<Object> get props => [];
}

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
  final String tool;

  ToolSelected(this.tool);

  @override
  List<Object> get props => [tool];
}

class SubmitForm extends DataTableCreateEvent {}
