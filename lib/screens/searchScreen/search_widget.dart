import 'package:flutter/material.dart';
import 'package:remote_healthcare/api_manager/api_manager.dart';
import 'package:remote_healthcare/screens/searchScreen/models/SearchRes.dart';
import 'package:remote_healthcare/themes/myTheme.dart';

class SearchWidget extends StatefulWidget {
  Patients patient;
  String emailDoctor;
  SearchWidget(this.patient,this.emailDoctor,);

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.all(size.width * 0.03),
      child: Card(
        color: Colors.white,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)
        ),
        child: Container(
          padding: EdgeInsets.all(size.width * 0.05),
          height: size.height * 0.178,
          width: double.infinity,
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text('Name: ${widget.patient.username?.toUpperCase()??''}',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontSize: 16,
                          color: Colors.black
                      ),
                    ),
                    SizedBox(height: size.height * 0.01,),
                    Text('Device Id: ${widget.patient.device?.deviceId?.toUpperCase()??''}',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontSize: 16,
                          color: Colors.black
                      ),
                    ),
                    SizedBox(height: size.height * 0.01,),
                    Text('Gender: ${widget.patient.gender?.toUpperCase()??''}',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontSize: 16,
                          color: Colors.black
                      ),
                    ),
                    SizedBox(height: size.height * 0.01,),
                    Text('Age: ${widget.patient.age??''}',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontSize: 16,
                          color: Colors.black
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: ()async{
                  await ApiManager.sendReqAdmin(widget.patient.device?.deviceId??'', widget.emailDoctor);
                  setState(() {

                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  width: widget.patient.isRequestedAlready == false ? size.width * 0.15 : size.width * 0.28,
                    height: size.height * 0.04,
                    decoration: BoxDecoration(
                        color:  widget.patient.isRequestedAlready == false ? MyTheme.lightOrange : Colors.white,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Text(
                     widget.patient.isRequestedAlready == false? 'Add' : 'Pending...',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontSize: 18,
                      color:  widget.patient.isRequestedAlready == false ? Colors.white : MyTheme.lightOrange
                    ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
