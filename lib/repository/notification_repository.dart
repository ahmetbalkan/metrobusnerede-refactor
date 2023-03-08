import 'package:awesome_notifications/awesome_notifications.dart';

class NotificationRepository {
  Future<bool> checkPermission() async {
    return await AwesomeNotifications().requestPermissionToSendNotifications(
        channelKey: "metrobus_notification",
        permissions: [
          NotificationPermission.Vibration,
          NotificationPermission.Sound,
          NotificationPermission.FullScreenIntent,
          NotificationPermission.Alert,
          NotificationPermission.Badge,
        ]);
  }

  Future<void> showNotification(String busstopName) async {
    AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: 1,
            channelKey: 'metrobus_notification',
            title: '$busstopName durağına vardınız.',
            body: 'Lütfen kapıya doğru ilerleyiniz.',
            actionType: ActionType.Default));
  }
}
