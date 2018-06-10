import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

enum OSInFocusDisplayOption { InAppAlert, Notification, None }

class FlutterOneSignal {
  static MethodChannel _channel = MethodChannel('flutter_one_signal/methods');
  static final EventChannel eventChannel =
      EventChannel('flutter_one_signal/events');

  static startInit({
    @required String appId,
    OSInFocusDisplayOption inFocusDisplaying,
    bool unsubscribeWhenNotificationsAreDisabled,
    void notificationReceivedHandler(dynamic notification),
    void notificationOpenedHandler(dynamic notification),
  }) {
    print('here $appId');
    _channel.invokeMethod("startInit", {
      'appId': appId,
    });

    eventChannel.receiveBroadcastStream().listen((data) {
      var input = data as String;
      if (input.startsWith("opened:")) {
        notificationOpenedHandler(input.substring(7, input.length));
      }
    });
  }
}
