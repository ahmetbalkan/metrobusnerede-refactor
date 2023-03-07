import 'package:awesome_notifications/awesome_notifications.dart';

class NotificationRepository {
  Future<bool> checkPermission() async {
    return await AwesomeNotifications().isNotificationAllowed();
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
