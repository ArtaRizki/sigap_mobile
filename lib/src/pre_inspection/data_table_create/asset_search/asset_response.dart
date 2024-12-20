///
/// Code generated by jsonToDartModel https://ashamp.github.io/jsonToDartModel/
///
class AssetResponseData {
/*
{
  "id": 7101,
  "code": "testt",
  "jenis_asset_code": "KT",
  "name": "tesssa"
} 
*/

  int? id;
  String? code;
  String? jenisAssetCode;
  String? name;

  AssetResponseData({
    this.id,
    this.code,
    this.jenisAssetCode,
    this.name,
  });
  AssetResponseData.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    code = json['code']?.toString();
    jenisAssetCode = json['jenis_asset_code']?.toString();
    name = json['name']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['code'] = code;
    data['jenis_asset_code'] = jenisAssetCode;
    data['name'] = name;
    return data;
  }
}

class AssetResponse {
/*
{
  "status": "S",
  "message": null,
  "data": [
    {
      "id": 7101,
      "code": "testt",
      "jenis_asset_code": "KT",
      "name": "tesssa"
    }
  ]
} 
*/

  String? status;
  String? message;
  List<AssetResponseData?>? data;

  AssetResponse({
    this.status,
    this.message,
    this.data,
  });
  AssetResponse.fromJson(Map<String, dynamic> json) {
    status = json['status']?.toString();
    message = json['message']?.toString();
    if (json['data'] != null) {
      final v = json['data'];
      final arr0 = <AssetResponseData>[];
      v.forEach((v) {
        arr0.add(AssetResponseData.fromJson(v));
      });
      this.data = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      final v = this.data;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['data'] = arr0;
    }
    return data;
  }
}
