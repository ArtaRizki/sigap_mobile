import 'dart:convert';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sigap_mobile/common/base/base_controller.dart';
import 'package:sigap_mobile/src/pre_inspection/data_table_create/asset_search/asset_response.dart';
import 'package:sigap_mobile/src/pre_inspection/data_table_create/asset_search/asset_search_event.dart';
import 'package:sigap_mobile/src/pre_inspection/data_table_create/asset_search/asset_search_state.dart';

class AssetSearchBloc extends Bloc<AssetSearchEvent, AssetSearchState> {
  AssetSearchBloc() : super(AssetSearchInitial()) {
    on<FetchAssetSearch>(_onFetchAssetSearch);
    on<LoadNextPage>(_onLoadNextPage); // New event for pagination
  }

  final String baseUrl =
      'https://sigap-api.erdata.id/api/Mobile/AssetMobile/GetAsset';
  int currentPage = 1; // Track the current page
  bool hasMoreData = true; // Flag to check if more data is available

  Future<void> _onFetchAssetSearch(
      FetchAssetSearch event, Emitter<AssetSearchState> emit) async {
    emit(AssetSearchLoading());
    try {
      currentPage = 1; // Reset to the first page on a new search
      final assets =
          await fetchAssetSearch(page: currentPage, search: event.search);
      hasMoreData = assets.isNotEmpty; // Check if there are more assets
      emit(AssetSearchLoaded(
          assets: assets, currentPage: currentPage, hasMoreData: hasMoreData));
    } catch (e) {
      emit(AssetSearchError(e.toString()));
    }
  }

  Future<void> _onLoadNextPage(
      LoadNextPage event, Emitter<AssetSearchState> emit) async {
    log("MASUK LOAD NEXT PAGE");
    if (!hasMoreData || state is AssetSearchLoading) return;

    try {
      currentPage++;
      final newAssets =
          await fetchAssetSearch(page: currentPage, search: event.search);
      if (newAssets.isEmpty) {
        hasMoreData = false; // No more data to load
      } else if (state is AssetSearchLoaded) {
        final currentAssets = (state as AssetSearchLoaded).assets;
        emit(AssetSearchLoaded(
          assets: [...currentAssets, ...newAssets],
          currentPage: currentPage,
          hasMoreData: hasMoreData,
        )); // Append new assets
      }
    } catch (e) {
      emit(AssetSearchError(e.toString()));
    }
  }

  Future<List<AssetResponseData?>> fetchAssetSearch(
      {int page = 1, String search = ''}) async {
    final response =
        await BaseController().get('$baseUrl?page=$page&search=$search');

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      var responseData = AssetResponse.fromJson(data);
      return responseData.data ?? [];
    } else {
      throw Exception("Failed to fetch Asset");
    }
  }
}
