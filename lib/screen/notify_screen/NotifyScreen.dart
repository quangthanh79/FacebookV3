import 'package:flutter/material.dart';
import 'package:facebook_auth/screen/notify_screen/models/notifications.dart';

class NotifyScreen extends StatefulWidget {
  const NotifyScreen({super.key});

  @override
  NotifyScreenState createState() => NotifyScreenState();
}

class NotifyScreenState extends State<NotifyScreen> {
  ListNotification list = ListNotification();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
              title: Text(
                "Notifications",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              backgroundColor: Colors.white,
              centerTitle: false,
              actions: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).highlightColor,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.search, size: 30.0),
                    color: Colors.black,
                    disabledColor: Colors.black,
                    splashColor: Theme.of(context).colorScheme.secondary,
                    onPressed: () {},
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 10),
                ),
              ]),
          SliverList(
            delegate: SliverChildListDelegate(_getNotificationWidgets()),
          )
        ],
      ),
    );
  }

  List<Widget> _getNotificationWidgets() {
    List<Widget> notifications = [];
    List<MyNotification> ls = list.list;
    for (int i = 0; i < ls.length; i++){
      notifications.add(_getNotificationWidget(ls[i]));
    }
    return notifications;
  }

  Widget _getNotificationWidget(MyNotification notification) {
    return Container(
      decoration: BoxDecoration(
          color:
              notification.read == "false" ? Theme.of(context).highlightColor : Colors.transparent),
      child: ListTile(
        title: Text(
          notification.title,
          style: const TextStyle(fontWeight: FontWeight.w400),
        ),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(notification.avatar),
          radius: 28,
        ),
        subtitle: Text(
          '\n${notification.created}',
          style: const TextStyle(
            fontSize: 12,
          ),
        ),
        isThreeLine: true,
        trailing: IconButton(
          icon: const Icon(Icons.more_horiz),
          disabledColor: Colors.black,
          onPressed: () {},
        ),
        onTap: (){
          setState(() {
            notification.read = "true";
          });
        },
      ),
    );
  }
}
