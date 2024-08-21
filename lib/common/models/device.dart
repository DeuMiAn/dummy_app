import 'package:dummy_app/common/enum/os_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'device.g.dart';

@JsonSerializable(explicitToJson: true)
class Device {
  OsType? os;
  String? model;
  String? deviceId;
  String? version;
  String? token;
  @JsonKey(name: 'prev_deviceId')
  String? prevDeviceId;

  Device();

  factory Device.fromJson(Map<String, dynamic> json) => _$DeviceFromJson(json);
  Map<String, dynamic> toJson() => _$DeviceToJson(this);
}
