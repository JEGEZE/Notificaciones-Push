import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:async';

class PushNotificationProvider {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  final _mensajesStreamController = StreamController<String>.broadcast();

  Stream<String> get mensajes => _mensajesStreamController.stream;

  dispose() {
    _mensajesStreamController.close();
  }

  initNotification() {
    _firebaseMessaging.requestNotificationPermissions();
    //dvzVqMXyWfM:APA91bEp09ZrCLCZJVieX1fxr-VICmzrWjH1rvQoyY4o-KyqDv40upyw1X3zHP1DqItsqRuBJoHfVvVgUT0C4tU0Q-cqDmHMwh9Vk6OnfOiKI_jreFhWRgOgJXYkaguPCNtYCusrO0iO
    _firebaseMessaging.getToken().then((token) {
      print('Token: "  ' + token);
    });

    _firebaseMessaging.configure(onMessage: (info) async {
      print("==== on Message ======");
      print(info);
      _mensajesStreamController.sink.add(info['data']['comida']);
    }, onLaunch: (info) async {
      print("==== on Launch ======");
      print(info);
    }, onResume: (info) async {
      print("==== on Resume ======");
      print(info);

      final noti = info['data']['comida'];
      //print(noti);

      _mensajesStreamController.sink.add(noti);
    });
  }
}
