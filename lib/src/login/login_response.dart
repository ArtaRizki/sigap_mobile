import 'dart:convert';

class LoginResponse {
  final String? status;
  final String? message;
  final UserData data;

  LoginResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      status: json['status'] as String?,
      message: json['message'] as String?,
      data: UserData.fromJson(json['data']),
    );
  }
}

class UserData {
  final int? id;
  final String? username;
  final int? status;
  final int? superadmin;
  final int? companyId;
  final int? assetId;
  final String? assetName;
  final String? companyName;
  final String? companyType;
  final String? cabangName;
  final String? cabangCode;
  final int? cabangId;
  final int? regionalId;
  final String? regionalCode;
  final String? regionalName;
  final int? personilId;
  final String? personilName;
  final String? email;
  final String? jabatan;
  final String? plantSap;
  final String? companySap;
  final int? isPusat;
  final String? token;
  final String? tokenCentra;
  final List<Permission> permissions;
  final List<Role> roles;

  UserData({
    required this.id,
    required this.username,
    required this.status,
    required this.superadmin,
    required this.companyId,
    required this.assetId,
    required this.assetName,
    required this.companyName,
    required this.companyType,
    required this.cabangName,
    required this.cabangCode,
    required this.cabangId,
    required this.regionalId,
    required this.regionalCode,
    required this.regionalName,
    required this.personilId,
    required this.personilName,
    required this.email,
    required this.jabatan,
    required this.plantSap,
    required this.companySap,
    required this.isPusat,
    required this.token,
    required this.tokenCentra,
    required this.permissions,
    required this.roles,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'] as int?,
      username: json['username'] as String?,
      status: json['status'] as int?,
      superadmin: json['superadmin'] as int?,
      companyId: json['company_id'] as int?,
      assetId: json['asset_id'] as int?,
      assetName: json['asset_name'] as String?,
      companyName: json['company_name'] as String?,
      companyType: json['company_type'] as String?,
      cabangName: json['cabang_name'] as String?,
      cabangCode: json['cabang_code'] as String?,
      cabangId: json['cabang_id'] as int?,
      regionalId: json['regional_id'] as int?,
      regionalCode: json['regional_code'] as String?,
      regionalName: json['regional_name'] as String?,
      personilId: json['personil_id'] as int?,
      personilName: json['personil_name'] as String?,
      email: json['email'] as String?,
      jabatan: json['jabatan'] as String?,
      plantSap: json['plant_sap'] as String?,
      companySap: json['company_sap'] as String?,
      isPusat: json['is_pusat'] as int?,
      token: json['token'] as String?,
      tokenCentra: json['token_centra'] as String?,
      permissions: (json['permissions'] as List)
          .map((e) => Permission.fromJson(e))
          .toList(),
      roles: (json['roles'] as List).map((e) => Role.fromJson(e)).toList(),
    );
  }
}

class Permission {
  final String? name;
  final int? isHidden;

  Permission({
    required this.name,
    required this.isHidden,
  });

  factory Permission.fromJson(Map<String, dynamic> json) {
    return Permission(
      name: json['name'] as String?,
      isHidden: json['is_hidden'] as int?,
    );
  }
}

class Role {
  final int? id;
  final String? code;
  final String? name;
  final String? description;
  final int? isActive;
  final int? companyId;

  Role({
    required this.id,
    required this.code,
    required this.name,
    required this.description,
    required this.isActive,
    required this.companyId,
  });

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      id: json['id'] as int?,
      code: json['code'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      isActive: json['is_active'] as int?,
      companyId: json['company_id'] as int?,
    );
  }
}
