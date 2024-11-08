///
/// Code generated by jsonToDartModel https://ashamp.github.io/jsonToDartModel/
///
class SingleDataResponseDataItem {
/*
{
  "id": 332,
  "checklist_id": 332,
  "pre_inspection_id": 20,
  "file": "dev/attachments/Transcation/-20241031053507-652738750.png",
  "file_name": "add-friend_10264422.png",
  "reason": "test",
  "asset_category_code": "GSU",
  "check_name": "BOOM SYSTEM",
  "check_sub_name": "Cek Limit switch / Sensor",
  "category_local": "GSU",
  "status": 0
} 
*/

  int? id;
  int? checklistId;
  int? DataTableId;
  String? file;
  String? fileName;
  String? reason;
  String? assetCategoryCode;
  String? checkName;
  String? checkSubName;
  String? categoryLocal;
  int? status;

  SingleDataResponseDataItem({
    this.id,
    this.checklistId,
    this.DataTableId,
    this.file,
    this.fileName,
    this.reason,
    this.assetCategoryCode,
    this.checkName,
    this.checkSubName,
    this.categoryLocal,
    this.status,
  });
  SingleDataResponseDataItem.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    checklistId = json['checklist_id']?.toInt();
    DataTableId = json['pre_inspection_id']?.toInt();
    file = json['file']?.toString();
    fileName = json['file_name']?.toString();
    reason = json['reason']?.toString();
    assetCategoryCode = json['asset_category_code']?.toString();
    checkName = json['check_name']?.toString();
    checkSubName = json['check_sub_name']?.toString();
    categoryLocal = json['category_local']?.toString();
    status = json['status']?.toInt();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['checklist_id'] = checklistId;
    data['pre_inspection_id'] = DataTableId;
    data['file'] = file;
    data['file_name'] = fileName;
    data['reason'] = reason;
    data['asset_category_code'] = assetCategoryCode;
    data['check_name'] = checkName;
    data['check_sub_name'] = checkSubName;
    data['category_local'] = categoryLocal;
    data['status'] = status;
    return data;
  }
}

class SingleDataResponseData {
/*
{
  "id": 20,
  "doc_no": "PI-2024-0000017",
  "asset_id": 23,
  "asset_category_code": "GSU",
  "asset_name": "HPR-07 22 T T.Intan",
  "personil_name": "Manager TPS",
  "date_doc": "10/30/2024 14:57:50",
  "created_by": 21,
  "created_at": "10/31/2024 05:35:07",
  "updated_by": null,
  "updated_at": null,
  "doc_type": "OPR",
  "is_deleted": 0,
  "item": [
    {
      "id": 332,
      "checklist_id": 332,
      "pre_inspection_id": 20,
      "file": "dev/attachments/Transcation/-20241031053507-652738750.png",
      "file_name": "add-friend_10264422.png",
      "reason": "test",
      "asset_category_code": "GSU",
      "check_name": "BOOM SYSTEM",
      "check_sub_name": "Cek Limit switch / Sensor",
      "category_local": "GSU",
      "status": 0
    }
  ]
} 
*/

  int? id;
  String? docNo;
  int? assetId;
  String? assetCategoryCode;
  String? assetName;
  String? personilName;
  String? dateDoc;
  int? createdBy;
  String? createdAt;
  String? updatedBy;
  String? updatedAt;
  String? docType;
  int? isDeleted;
  List<SingleDataResponseDataItem?>? item;

  SingleDataResponseData({
    this.id,
    this.docNo,
    this.assetId,
    this.assetCategoryCode,
    this.assetName,
    this.personilName,
    this.dateDoc,
    this.createdBy,
    this.createdAt,
    this.updatedBy,
    this.updatedAt,
    this.docType,
    this.isDeleted,
    this.item,
  });
  SingleDataResponseData.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    docNo = json['doc_no']?.toString();
    assetId = json['asset_id']?.toInt();
    assetCategoryCode = json['asset_category_code']?.toString();
    assetName = json['asset_name']?.toString();
    personilName = json['personil_name']?.toString();
    dateDoc = json['date_doc']?.toString();
    createdBy = json['created_by']?.toInt();
    createdAt = json['created_at']?.toString();
    updatedBy = json['updated_by']?.toString();
    updatedAt = json['updated_at']?.toString();
    docType = json['doc_type']?.toString();
    isDeleted = json['is_deleted']?.toInt();
    if (json['item'] != null) {
      final v = json['item'];
      final arr0 = <SingleDataResponseDataItem>[];
      v.forEach((v) {
        arr0.add(SingleDataResponseDataItem.fromJson(v));
      });
      item = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['doc_no'] = docNo;
    data['asset_id'] = assetId;
    data['asset_category_code'] = assetCategoryCode;
    data['asset_name'] = assetName;
    data['personil_name'] = personilName;
    data['date_doc'] = dateDoc;
    data['created_by'] = createdBy;
    data['created_at'] = createdAt;
    data['updated_by'] = updatedBy;
    data['updated_at'] = updatedAt;
    data['doc_type'] = docType;
    data['is_deleted'] = isDeleted;
    if (item != null) {
      final v = item;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['item'] = arr0;
    }
    return data;
  }
}

class SingleDataResponse {
/*
{
  "status": "S",
  "message": "Succes",
  "data": {
    "id": 20,
    "doc_no": "PI-2024-0000017",
    "asset_id": 23,
    "asset_category_code": "GSU",
    "asset_name": "HPR-07 22 T T.Intan",
    "personil_name": "Manager TPS",
    "date_doc": "10/30/2024 14:57:50",
    "created_by": 21,
    "created_at": "10/31/2024 05:35:07",
    "updated_by": null,
    "updated_at": null,
    "doc_type": "OPR",
    "is_deleted": 0,
    "item": [
      {
        "id": 332,
        "checklist_id": 332,
        "pre_inspection_id": 20,
        "file": "dev/attachments/Transcation/-20241031053507-652738750.png",
        "file_name": "add-friend_10264422.png",
        "reason": "test",
        "asset_category_code": "GSU",
        "check_name": "BOOM SYSTEM",
        "check_sub_name": "Cek Limit switch / Sensor",
        "category_local": "GSU",
        "status": 0
      }
    ]
  }
} 
*/

  String? status;
  String? message;
  SingleDataResponseData? data;

  SingleDataResponse({
    this.status,
    this.message,
    this.data,
  });
  SingleDataResponse.fromJson(Map<String, dynamic> json) {
    status = json['status']?.toString();
    message = json['message']?.toString();
    data = (json['data'] != null)
        ? SingleDataResponseData.fromJson(json['data'])
        : null;
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}
