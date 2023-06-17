import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'models/notifyAdminRes.dart';


class NotificationAdminWidget extends StatefulWidget {
  Emergencies emergencies;
  NotificationAdminWidget(this.emergencies,);

  @override
  State<NotificationAdminWidget> createState() => _NotificationAdminWidgetState();
}

class _NotificationAdminWidgetState extends State<NotificationAdminWidget> {

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.all(size.width * 0.03),
      child: Card(
        color: Colors.white,
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
          padding: EdgeInsets.all(size.width * 0.03),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Name: ${widget.emergencies.username}'.toUpperCase(),
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontSize: 16, color: Colors.black),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Text(
                'Phone Number: ${widget.emergencies.phoneNumber}'
                    .toUpperCase(),
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontSize: 16, color: Colors.black),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Text(
                'Device Id: ${widget.emergencies.device?.deviceId}'.toUpperCase(),
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontSize: 16, color: Colors.black),
              ),
              TextButton(
                style: ButtonStyle(
                  padding: MaterialStatePropertyAll(
                    EdgeInsets.zero
                  )
                ),
                onPressed: () {
                  launchUrl(Uri.parse('https://www.google.com/maps/search/?api=1&query=${widget.emergencies.device?.lat},${widget.emergencies.device?.lng}'),mode: LaunchMode.externalNonBrowserApplication);
                }, child: Text('https://www.google.com/maps/search/?api=1&query=${widget.emergencies.device?.lat},${widget.emergencies.device?.lng}',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(
                    decoration: TextDecoration.underline,
                    fontSize: 16, color: Colors.blueAccent),
              ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
