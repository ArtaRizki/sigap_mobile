import 'package:sigap_mobile/src/pre_inspection/data_table_create/asset_search/asset_response.dart';

abstract class AssetSearchEvent {}

class FetchAssetSearch extends AssetSearchEvent {
  final int page;
  final String search;

  FetchAssetSearch({this.page = 1, this.search = ''});
}

class AssetSelectedEvent extends AssetSearchEvent {
  final AssetResponseData selectedAsset;

  AssetSelectedEvent({required this.selectedAsset});
}

class LoadNextPage extends AssetSearchEvent {
  final String search;
  LoadNextPage(this.search);
}
