import 'package:flutter/material.dart';
import 'package:sikshya/models/notification.dart';
import 'package:sikshya/service/notification_service.dart';

class NNotification extends StatefulWidget {
  const NNotification({super.key});

  @override
  State<NNotification> createState() => _NNotificationState();
}

class _NNotificationState extends State<NNotification> {
  List<OnlibNotification>? notify;
  var isLoaded = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    notify = await NotificationService().getNotify();
    if (notify != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal[200],
          title: const Text(
            "Notification",
            style: TextStyle(fontSize: 25),
          ),
        ),
        body: ListView.builder(
          itemCount: notify?.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              leading: CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(notify![index].imageUrl)),
              title: Text(notify![index].title),
              subtitle: Text(notify![index].message),
              trailing: Text(
                notify![index].timestamp.toString(),
                style: const TextStyle(fontSize: 12),
              ),
            );
          },
        ));
  }
}
