import 'package:sigap_mobile/src/pre_inspection/data_table_create/terminal/terminal_response.dart';

abstract class TerminalSearchEvent {}

class FetchTerminalSearch extends TerminalSearchEvent {
  final int page;
  final String search;

  FetchTerminalSearch({this.page = 1, this.search = ''});
}

class TerminalSelectedEvent extends TerminalSearchEvent {
  final TerminalResponseData selectedTerminal;

  TerminalSelectedEvent({required this.selectedTerminal});
}

class LoadNextPage extends TerminalSearchEvent {
  final String search;
  LoadNextPage(this.search);
}
