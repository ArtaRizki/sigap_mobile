import 'package:equatable/equatable.dart';

abstract class DataTableEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchDataTable extends DataTableEvent {}
