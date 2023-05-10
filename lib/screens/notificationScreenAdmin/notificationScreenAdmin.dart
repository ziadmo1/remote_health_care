import 'package:flutter/material.dart';
import '../../api_manager/api_manager.dart';
import 'models/notifyAdminRes.dart';
import 'notification_admin_widget.dart';

class NotificationAdminScreen extends StatefulWidget {
  static const String routeName = 'notifyAdmin';

  @override
  State<NotificationAdminScreen> createState() => _NotificationAdminScreenState();
}

class _NotificationAdminScreenState extends State<NotificationAdminScreen> {

  @override
  Widget build(BuildContext context) {
    String id = ModalRoute.of(context)?.settings.arguments as String;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          toolbarHeight: 60,
          title: Text('Notification'),
        ),
        body: FutureBuilder<NotifyAdminRes>(
            future: ApiManager.notifyAdmin(id),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text(snapshot.data?.message ?? ''));
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                );
              }
              var notify = snapshot.data?.data?.admin?.emergencies;
              return ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) => NotificationAdminWidget(notify![index]),
                  itemCount: notify?.length
              );
            }));
  }
}


