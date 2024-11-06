import 'package:sigap_mobile/src/pre_inspection/data_table_create/asset_search/asset_response.dart';

abstract class AssetSearchState {}

class AssetSearchInitial extends AssetSearchState {}

class AssetSearchLoading extends AssetSearchState {}

class AssetSearchLoaded extends AssetSearchState {
  final List<AssetResponseData?> assets; // Cumulative list of all loaded assets
  final int currentPage; // Current page number
  final bool hasMoreData; // Flag to indicate if there are more assets to load

  AssetSearchLoaded({
    required this.assets,
    required this.currentPage,
    required this.hasMoreData,
  });
}

class AssetSelected extends AssetSearchState {
  final AssetResponseData? assetSelected;

  AssetSelected(this.assetSelected);
}

class AssetSearchError extends AssetSearchState {
  final String message;

  AssetSearchError(this.message);
}
