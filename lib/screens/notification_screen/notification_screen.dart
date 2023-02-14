import 'package:flutter/material.dart';
import 'package:remote_healthcare/screens/notification_screen/notification_widget.dart';

import '../../api_manager/api_manager.dart';
import '../homeScreen_user/models/HomeUserRes.dart';

class NotificationScreen extends StatelessWidget {
  static const String routeName = 'notify';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          toolbarHeight: 60,
          title: Text('Notification'),
        ),
        body: FutureBuilder<HomeUserRes>(
            future: ApiManager.homeDataUser(),
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
              var user = snapshot.data?.data?.patient;
              return ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) => NotificationWidget(user!.adminsRequests![index],user),
                  itemCount: user?.adminsRequests?.length
              );
            }));
  }
}
