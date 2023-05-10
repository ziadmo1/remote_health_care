import 'package:flutter/material.dart';
import 'package:remote_healthcare/api_manager/api_manager.dart';
import 'package:remote_healthcare/screens/homeScreen_user/models/HomeUserRes.dart';

class NotificationWidget extends StatefulWidget {
  AdminsRequests adminsRequests;
  Patient patient;
  NotificationWidget(this.adminsRequests, this.patient);

  @override
  State<NotificationWidget> createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<NotificationWidget> {
  bool isCancel = false;
  bool isAccept = false;
  bool isClicked = false;

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
          height: size.height * 0.16,
          width: double.infinity,
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Name: ${widget.adminsRequests.username}'.toUpperCase(),
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontSize: 16, color: Colors.black),
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    Text(
                      'Phone Number: ${widget.adminsRequests.phoneNumber}'
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
                      'Email: ${widget.adminsRequests.email}'
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
                      'Role: ${widget.adminsRequests.role}'.toUpperCase(),
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontSize: 16, color: Colors.black),
                    ),
                  ],
                ),
              ),
              isClicked == false
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                            child: IconButton(
                                onPressed: () async {
                                  await ApiManager.acceptReqPatient(
                                      widget.patient.device?.deviceId ?? '',
                                      widget.adminsRequests.email ?? '');
                                  isClicked = true;
                                  isAccept = true;
                                  setState(() {});
                                },
                                icon: Icon(
                                  Icons.check,
                                  color: Colors.green,
                                  size: 15,
                                ))),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        CircleAvatar(
                            child: IconButton(
                                onPressed: () async {
                                  await ApiManager.cancelReqPatient(
                                      widget.patient.device?.deviceId ?? '',
                                      widget.adminsRequests.email ?? '');
                                  isClicked = true;
                                  isCancel = true;
                                  setState(() {});
                                },
                                icon: Icon(
                                  Icons.close,
                                  color: Colors.red,
                                  size: 15,
                                ))),
                      ],
                    )
                  : Text(
                      isClicked == true && isCancel == true
                          ? 'Canceled'
                          : 'Accepted',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontSize: 14))
            ],
          ),
        ),
      ),
    );
  }
}
