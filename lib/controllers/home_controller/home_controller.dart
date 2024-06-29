import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:health/health.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeController extends GetxController {
  var loadingData = false.obs;
  var hasPermissions = false.obs; //make it false by default
  var notSupported = false.obs;
  var healthDataList = <HealthDataPoint>[].obs;
  var healthConnectStatus = "...".obs;
  var steps = '0'.obs;
  var calBurnt = '0'.obs;

  List<HealthDataAccess> get permissions =>
      types.map((e) => HealthDataAccess.READ).toList();

  var types = [
    HealthDataType.STEPS,
    HealthDataType.TOTAL_CALORIES_BURNED,
  ];


  @override
  void onInit() {
    super.onInit();
    authorize();
    _initHealth();
  
  }

  _initHealth() async {
    loadingData.value = true;

    Health().configure(useHealthConnectIfAvailable: true).whenComplete(
      () {
        installHealthConnect();
      },
    );
    loadingData.value = false;
    update();
  }

  Future<void> installHealthConnect() async {
    Health().installHealthConnect().then(
      (value) {
        fetchData();
      },
    );
  }

  Future<void> authorize() async {
    // If we are trying to read Step Count, Workout, Sleep or other data that requires
    // the ACTIVITY_RECOGNITION permission, we need to request the permission first.
    // This requires a special request authorization call.
    //
    // The location permission is requested for Workouts using the Distance information.
    await Permission.activityRecognition.request();
    await Permission.location.request();

    // Check if we have health permissions
    bool? _permission =
        await Health().hasPermissions(types, permissions: permissions);

    // hasPermissions = false because the hasPermission cannot disclose if WRITE access exists.
    // Hence, we have to request with WRITE as well.
    _permission = false;

    bool authorized = false;
    if (!_permission) {
      try {
        authorized = await Health()
            .requestAuthorization(types, permissions: permissions);
      } catch (error) {
        print("======================Exception in authorize: $error");
      }
    }

    hasPermissions.value = authorized;
    return;
  }

  Future<void> getHealthConnectSdkStatus() async {
    assert(Platform.isAndroid, "This is only available on Android");

    final status = await Health().getHealthConnectSdkStatus();

    healthConnectStatus.value = "Health Connect Status: $status";
  }

  Future<void> fetchData() async {
    loadingData.value = true;

    // get data within the last 24 hours
    final now = DateTime.now();
    final yesterday = now.subtract(const Duration(hours: 24));

    // Clear old data points
    healthDataList.value.clear();

    // try {
    // fetch health data
    List<HealthDataPoint> healthData = await Health().getHealthDataFromTypes(
      types: types,
      startTime: yesterday,
      endTime: now,
    );

    print('Total number of data points: ${healthData.length}. '
        '${healthData.length > 100 ? 'Only showing the first 100.' : ''}');

    // save all the new data points (only the first 100)
    healthDataList.value.addAll(
        (healthData.length < 100) ? healthData : healthData.sublist(0, 100));
    // } catch (error) {
    //   debugPrint("Exception in getHealthDataFromTypes: $error");
    // }

    // filter out duplicates
    healthDataList.value = Health().removeDuplicates(healthDataList.value);

    for (var data in healthDataList.value) {
      String value = data.value.toJson()["numeric_value"].toString();

      if (data.type == HealthDataType.STEPS) {
        steps.value = value;
      }
      if (data.type == HealthDataType.TOTAL_CALORIES_BURNED) {
        calBurnt.value = value;
      }
      hasPermissions.value = true;
    }
    loadingData.value = false;
  }

  _getcalandstep() async {
    final now = DateTime.now();
    final yesterday = now.subtract(const Duration(hours: 24));

    bool stepsPermission =
        await Health().hasPermissions([HealthDataType.STEPS]) ?? false;
    bool calBurntPermission =
        await Health().hasPermissions([HealthDataType.TOTAL_CALORIES_BURNED]) ??
            false;
    if (!stepsPermission) {
      stepsPermission =
          await Health().requestAuthorization([HealthDataType.STEPS]);
    }
    if (!calBurntPermission) {
      stepsPermission = await Health()
          .requestAuthorization([HealthDataType.TOTAL_CALORIES_BURNED]);
    }

    if (stepsPermission) {
      try {
        final _steps = await Health().getTotalStepsInInterval(yesterday, now);
        if (_steps != null) {
          hasPermissions.value = true;
          steps.value = _steps.toString();
        }
      } catch (error) {
        print("ERROR FETCHING STEPS===: $error");
      }

      print('Total number of steps--------------------------: $steps');
    } else {
      print(
          "-----------------Authorization not granted - error in authorization");
      // _state = AppState.DATA_NOT_FETCHED);
    }
    if (calBurntPermission) {
      try {
        final _cal = await Health().getTotalStepsInInterval(yesterday, now);
        if (_cal != null) {
          hasPermissions.value = true;
          calBurnt.value = _cal.toString();
        }
      } catch (error) {
        print("ERROR FETCHING calBurnt===: $error");
      }

      print('Total number of calBurnt--------------------------: $steps');
    } else {
      print(
          "-----------------Authorization not granted - error in authorization");
      // _state = AppState.DATA_NOT_FETCHED);
    }
  }

  Future<void> fetchStepData() async {
    // get steps for today (i.e., since midnight)
    final now = DateTime.now();
    final midnight = DateTime(now.year, now.month, now.day);

    bool stepsPermission =
        await Health().hasPermissions([HealthDataType.STEPS]) ?? false;
    if (!stepsPermission) {
      stepsPermission =
          await Health().requestAuthorization([HealthDataType.STEPS]);
    }

    if (stepsPermission) {
      try {
        final _steps = await Health().getTotalStepsInInterval(midnight, now);
        if (_steps != null) {
          hasPermissions.value = true;
          steps.value = _steps.toString();
        }
      } catch (error) {
        print("ERROR FETCHING STEPS===: $error");
      }

      print('Total number of steps--------------------------: $steps');
    } else {
      print(
          "-----------------Authorization not granted - error in authorization");
      // => _state = AppState.DATA_NOT_FETCHED);
    }
  }

  retry() async {
    if (hasPermissions.value) {
      fetchData();
    } else {
      authorize().then(
        (value) {
          fetchData();
        },
      );
    }
  }
}
