// import 'dart:async';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_health_wrapper/flutter_health_wrapper.dart';
// import 'package:permission_handler/permission_handler.dart';

// void main() => runApp(HealthApp());

// class HealthApp extends StatefulWidget {
//   @override
//   _HealthAppState createState() => _HealthAppState();
// }

// enum AppState {
//   DATA_NOT_FETCHED,
//   FETCHING_DATA,
//   DATA_READY,
//   NO_DATA,
//   AUTHORIZED,
//   AUTH_NOT_GRANTED,
// }

// class _HealthAppState extends State<HealthApp> {
//   List<HealthDataPoint> _healthDataList = [];
//   AppState _state = AppState.DATA_NOT_FETCHED;
//   final Health health = Health();

//   /// All the data types that are available on Android and iOS.
//   /* List<HealthDataType> get types => (Platform.isAndroid)
//       ? dataTypeKeysAndroid
//       : (Platform.isIOS)
//           ? dataTypeKeysIOS
//           : []; */

//   static final types = [
//     HealthDataType.STEPS,
//   ];

//   List<HealthDataAccess> get permissions =>
//       types.map((e) => HealthDataAccess.READ_WRITE).toList();

//   @override
//   void initState() {
//     Health().configure(useHealthConnectIfAvailable: true);
//     super.initState();
//   }

//   /// Install Google Health Connect on this phone.
//   Future<void> installHealthConnect() async {
//     await Health().installHealthConnect();
//   }

//   Future<void> authorize() async {
//     await Permission.activityRecognition.request();
//     await Permission.location.request();

//     bool? hasPermissions =
//         await Health().hasPermissions(types, permissions: permissions);
//     hasPermissions = false;
//     bool authorized = false;
//     if (!hasPermissions) {
//       try {
//         authorized = await Health()
//             .requestAuthorization(types, permissions: permissions);
//       } catch (error) {
//         debugPrint("Exception in authorize: $error");
//       }
//     }
//     setState(() => _state =
//         (authorized) ? AppState.AUTHORIZED : AppState.AUTH_NOT_GRANTED);
//   }

//   Future<void> fetchData() async {
//     setState(() => _state = AppState.FETCHING_DATA);

//     final now = DateTime.now();
//     final yesterday = now.subtract(const Duration(hours: 24));
//     _healthDataList.clear();

//     try {
//       List<HealthDataPoint> healthData = await Health().getHealthDataFromTypes(
//         types: types,
//         startTime: yesterday,
//         endTime: now,
//       );

//       _healthDataList.addAll(
//           (healthData.length < 100) ? healthData : healthData.sublist(0, 100));
//     } catch (error) {
//       debugPrint("Exception in getHealthDataFromTypes: $error");
//     }
//     _healthDataList = Health().removeDuplicates(_healthDataList);
//     for (var data in _healthDataList) {
//       debugPrint(toJsonString(data));
//     }
//     setState(() {
//       _state = _healthDataList.isEmpty ? AppState.NO_DATA : AppState.DATA_READY;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Health Example'),
//         ),
//         body: Column(
//           children: [
//             Wrap(
//               spacing: 10,
//               children: [
//                 TextButton(
//                     onPressed: authorize,
//                     style: const ButtonStyle(
//                         backgroundColor: MaterialStatePropertyAll(Colors.blue)),
//                     child: const Text("Authenticate",
//                         style: TextStyle(color: Colors.white))),
//                 TextButton(
//                     onPressed: fetchData,
//                     style: const ButtonStyle(
//                         backgroundColor: MaterialStatePropertyAll(Colors.blue)),
//                     child: const Text("Fetch Data",
//                         style: TextStyle(color: Colors.white))),
//                 if (Platform.isAndroid)
//                   TextButton(
//                       onPressed: installHealthConnect,
//                       style: const ButtonStyle(
//                           backgroundColor:
//                               MaterialStatePropertyAll(Colors.blue)),
//                       child: const Text("Install Health Connect",
//                           style: TextStyle(color: Colors.white))),
//               ],
//             ),
//             const Divider(thickness: 3),
//             Expanded(child: Center(child: _content))
//           ],
//         ),
//       ),
//     );
//   }

//   Widget get _contentFetchingData => Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           Container(
//               padding: const EdgeInsets.all(20),
//               child: const CircularProgressIndicator(
//                 strokeWidth: 10,
//               )),
//           const Text('Fetching data...')
//         ],
//       );

//   Widget get _contentDataReady => ListView.builder(
//       itemCount: _healthDataList.length,
//       itemBuilder: (_, index) {
//         HealthDataPoint p = _healthDataList[index];
//         if (p.value is AudiogramHealthValue) {
//           return ListTile(
//             title: Text("${p.typeString}: ${p.value}"),
//             trailing: Text(p.unitString),
//             subtitle: Text('${p.dateFrom} - ${p.dateTo}'),
//           );
//         }
//         if (p.value is WorkoutHealthValue) {
//           return ListTile(
//             title: Text(
//                 "${p.typeString}: ${(p.value as WorkoutHealthValue).totalEnergyBurned} ${(p.value as WorkoutHealthValue).totalEnergyBurnedUnit?.name}"),
//             trailing:
//                 Text((p.value as WorkoutHealthValue).workoutActivityType.name),
//             subtitle: Text('${p.dateFrom} - ${p.dateTo}'),
//           );
//         }
//         if (p.value is NutritionHealthValue) {
//           return ListTile(
//             title: Text(
//                 "${p.typeString} ${(p.value as NutritionHealthValue).mealType}: ${(p.value as NutritionHealthValue).name}"),
//             trailing:
//                 Text('${(p.value as NutritionHealthValue).calories} kcal'),
//             subtitle: Text('${p.dateFrom} - ${p.dateTo}'),
//           );
//         }
//         return ListTile(
//           title: Text("${p.typeString}: ${p.value}"),
//           trailing: Text(p.unitString),
//           subtitle: Text('${p.dateFrom} - ${p.dateTo}'),
//         );
//       });

//   final Widget _contentNoData = const Text('No Data to show');

//   final Widget _contentNotFetched =
//       const Column(mainAxisAlignment: MainAxisAlignment.center, children: [
//     Text("Press 'Auth' to get permissions to access health data."),
//     Text("Press 'Fetch Data' to get health data."),
//     Text("Press 'Add Data' to add some random health data."),
//     Text("Press 'Delete Data' to remove some random health data."),
//   ]);

//   final Widget _authorized = const Text('Authorization granted!');

//   final Widget _authorizationNotGranted = const Column(
//     mainAxisAlignment: MainAxisAlignment.center,
//     children: [
//       Text('Authorization not given.'),
//       Text('You need to give all health permissions on Health Connect'),
//     ],
//   );

//   Widget get _content => switch (_state) {
//         AppState.DATA_READY => _contentDataReady,
//         AppState.DATA_NOT_FETCHED => _contentNotFetched,
//         AppState.FETCHING_DATA => _contentFetchingData,
//         AppState.NO_DATA => _contentNoData,
//         AppState.AUTHORIZED => _authorized,
//         AppState.AUTH_NOT_GRANTED => _authorizationNotGranted,
//       };
// }
