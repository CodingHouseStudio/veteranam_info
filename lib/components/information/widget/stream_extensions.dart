// import 'dart:async';

// extension StreamExtensions<T> on Stream<T> {
//   Stream<T> throttle(Duration duration) {
//     Timer? throttleTimer;
//     // ignore: omit_local_variable_types, prefer_final_locals
//     StreamController<T> resultStreamController = StreamController<T>();

//     listen((event) {
//       if (throttleTimer == null || !throttleTimer!.isActive) {
//         throttleTimer = Timer(duration, () {});
//         resultStreamController.add(event);
//       }
//     });

//     return resultStreamController.stream;
//   }
// }
