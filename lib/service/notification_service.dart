import 'package:sikshya/models/notification.dart';
import 'package:http/http.dart' as http;

class NotificationService {
  Future<List<OnlibNotification>?> getNotify() async {
    var client = http.Client();
    var uni = Uri.parse(
        "https://notification-4b0f5-default-rtdb.firebaseio.com/notification.json");
    var response = await client.get(uni);
    if (response.statusCode == 200) {
      var json = response.body;
      return notificationFromJson(json);
    } else {
      return null;
    }
  }
}
