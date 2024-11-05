///
/// Code generated by jsonToDartModel https://ashamp.github.io/jsonToDartModel/
///
class DataTableResponseData {
/*
{
  "id": 20,
  "asset_name": "HPR-07 22 T T.Intan",
  "date_doc": "30 October   2024 02:57:50",
  "personil_name": "Manager TPS",
  "company_name": "TPS"
} 
*/

  int? id;
  String? assetName;
  String? dateDoc;
  String? personilName;
  String? companyName;

  DataTableResponseData({
    this.id,
    this.assetName,
    this.dateDoc,
    this.personilName,
    this.companyName,
  });
  DataTableResponseData.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    assetName = json['asset_name']?.toString();
    dateDoc = json['date_doc']?.toString();
    personilName = json['personil_name']?.toString();
    companyName = json['company_name']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['asset_name'] = assetName;
    data['date_doc'] = dateDoc;
    data['personil_name'] = personilName;
    data['company_name'] = companyName;
    return data;
  }
}

class DataTableResponse {
/*
{
  "status": "S",
  "message": "Berhasil mengambil data.",
  "data": [
    {
      "id": 20,
      "asset_name": "HPR-07 22 T T.Intan",
      "date_doc": "30 October   2024 02:57:50",
      "personil_name": "Manager TPS",
      "company_name": "TPS"
    }
  ]
} 
*/

  String? status;
  String? message;
  List<DataTableResponseData?>? data;

  DataTableResponse({
    this.status,
    this.message,
    this.data,
  });
  DataTableResponse.fromJson(Map<String, dynamic> json) {
    status = json['status']?.toString();
    message = json['message']?.toString();
    if (json['data'] != null) {
      final v = json['data'];
      final arr0 = <DataTableResponseData>[];
      v.forEach((v) {
        arr0.add(DataTableResponseData.fromJson(v));
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