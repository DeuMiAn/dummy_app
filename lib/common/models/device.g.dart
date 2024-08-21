// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Device _$DeviceFromJson(Map<String, dynamic> json) => Device()
  ..os = $enumDecodeNullable(_$OsTypeEnumMap, json['os'])
  ..model = json['model'] as String?
  ..deviceId = json['deviceId'] as String?
  ..version = json['version'] as String?
  ..token = json['token'] as String?
  ..prevDeviceId = json['prev_deviceId'] as String?;

Map<String, dynamic> _$DeviceToJson(Device instance) => <String, dynamic>{
      'os': _$OsTypeEnumMap[instance.os],
      'model': instance.model,
      'deviceId': instance.deviceId,
      'version': instance.version,
      'token': instance.token,
      'prev_deviceId': instance.prevDeviceId,
    };

const _$OsTypeEnumMap = {
  OsType.Android: 'Android',
  OsType.iOS: 'iOS',
};
