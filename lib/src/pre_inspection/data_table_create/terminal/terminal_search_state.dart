import 'package:sigap_mobile/src/pre_inspection/data_table_create/terminal/terminal_response.dart';

abstract class TerminalSearchState {}

class TerminalSearchInitial extends TerminalSearchState {}

class TerminalSearchLoading extends TerminalSearchState {}

class TerminalSearchLoaded extends TerminalSearchState {
  final List<TerminalResponseData?>
      terminals; // Cumulative list of all loaded terminals
  final int currentPage; // Current page number
  final bool
      hasMoreData; // Flag to indicate if there are more terminals to load

  TerminalSearchLoaded({
    required this.terminals,
    required this.currentPage,
    required this.hasMoreData,
  });
}

class TerminalSelected extends TerminalSearchState {
  final TerminalResponseData? terminalSelected;

  TerminalSelected(this.terminalSelected);
}

class TerminalSearchError extends TerminalSearchState {
  final String message;

  TerminalSearchError(this.message);
}
