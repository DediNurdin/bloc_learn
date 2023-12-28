import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:device_info_plus/device_info_plus.dart';

class DeviceCubit extends Cubit<String> {
  final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  DeviceCubit() : super('');

  Future<void> getDeviceId() async {
    try {
      String? deviceId = await _getId();
      emit(deviceId!);
    } catch (error) {
      emit('Error retrieving device ID');
    }
  }

  Future<String?> _getId() async {
    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor;
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.id;
    }
    return null;
  }
}
