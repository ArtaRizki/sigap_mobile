import 'dart:convert';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sigap_mobile/common/base/base_controller.dart';
import 'package:sigap_mobile/src/pre_inspection/data_table_create/terminal/terminal_response.dart';
import 'package:sigap_mobile/src/pre_inspection/data_table_create/terminal/terminal_search_event.dart';
import 'package:sigap_mobile/src/pre_inspection/data_table_create/terminal/terminal_search_state.dart';

class TerminalSearchBloc
    extends Bloc<TerminalSearchEvent, TerminalSearchState> {
  TerminalSearchBloc() : super(TerminalSearchInitial()) {
    on<FetchTerminalSearch>(_onFetchTerminalSearch);
    on<LoadNextPage>(_onLoadNextPage); // New event for pagination
  }

  final String baseUrl =
      'https://sigap-api.erdata.id/api/Mobile/CabangMobile/GetCabang';
  int currentPage = 1; // Track the current page
  bool hasMoreData = true; // Flag to check if more data is available

  Future<void> _onFetchTerminalSearch(
      FetchTerminalSearch event, Emitter<TerminalSearchState> emit) async {
    emit(TerminalSearchLoading());
    try {
      currentPage = 1; // Reset to the first page on a new search
      final terminals =
          await fetchTerminalSearch(page: currentPage, search: event.search);
      hasMoreData = false; // Check if there are more terminals
      emit(TerminalSearchLoaded(
          terminals: terminals,
          currentPage: currentPage,
          hasMoreData: hasMoreData));
    } catch (e) {
      emit(TerminalSearchError(e.toString()));
    }
  }

  Future<void> _onLoadNextPage(
      LoadNextPage event, Emitter<TerminalSearchState> emit) async {
    log("MASUK LOAD NEXT PAGE");
    if (!hasMoreData || state is TerminalSearchLoading) return;

    try {
      currentPage++;
      final newTerminals =
          await fetchTerminalSearch(page: currentPage, search: event.search);
      if (newTerminals.isEmpty) {
        hasMoreData = false; // No more data to load
      } else if (state is TerminalSearchLoaded) {
        final currentTerminals = (state as TerminalSearchLoaded).terminals;
        emit(TerminalSearchLoaded(
          terminals: [...currentTerminals, ...newTerminals],
          currentPage: currentPage,
          hasMoreData: hasMoreData,
        )); // Append new terminals
      }
    } catch (e) {
      emit(TerminalSearchError(e.toString()));
    }
  }

  Future<List<TerminalResponseData?>> fetchTerminalSearch(
      {int page = 1, String search = ''}) async {
    final response =
        await BaseController().get('$baseUrl?page=$page&search=$search');

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      var responseData = TerminalResponse.fromJson(data);
      return responseData.data ?? [];
    } else {
      throw Exception("Failed to fetch Terminal");
    }
  }
}
