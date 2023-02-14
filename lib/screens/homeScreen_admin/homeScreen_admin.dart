import 'package:flutter/material.dart';
import 'package:remote_healthcare/screens/loginScreen_admin/models/AuthAdminRes.dart';
import 'package:remote_healthcare/screens/searchScreen/searchScreen.dart';
import 'package:remote_healthcare/themes/myTheme.dart';

class HomeScreenAdmin extends StatelessWidget {
  static const String routeName = 'admin';

  @override
  Widget build(BuildContext context) {
    Doctor doctor = ModalRoute.of(context)?.settings.arguments as Doctor;
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 100,
        title: Text('Welcome!'),
      ),
      body: Padding(
        padding:  EdgeInsets.all(size.width * 0.025),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Hey! ${doctor.username}',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              fontSize: 28
            ),
            ),
            SizedBox(height: size.height * 0.02,),
            Card(
              color: Colors.white,
              elevation: 12,
              margin: EdgeInsets.symmetric(horizontal: size.width * 0.02),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)
              ),
              child: Container(
                padding: EdgeInsets.all(size.width * 0.03),
                width: double.infinity,
                height: size.height * 0.72,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text('Your Patients',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontSize: 20,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        Spacer(),
                        IconButton(onPressed: (){
                          showSearch(context: context, delegate: PatientsSearch(doctor.email??''),);
                        }, icon: Icon(Icons.add,color: MyTheme.lightOrange,size: 30,)),
                      ],
                    ),
                    SizedBox(height: size.height * 0.02,),
                    Expanded(
                      child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) => Card(
                              color: MyTheme.lightOrange,
                              elevation: 7,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)
                              ),
                              child: Container(
                                padding: EdgeInsets.all(size.width * 0.02),
                                width: double.infinity,
                                height: size.height * 0.15,
                                child: Row(
                                  children: [
                                    Container(
                                      width: size.width * 0.65,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: [
                                          Text('Name: ${doctor.patients![index].username?.toUpperCase()??''}',
                                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                            fontSize: 16,
                                            color: Colors.black
                                          ),
                                          ),
                                          SizedBox(height: size.height * 0.01,),
                                          Text('Gender: ${doctor.patients![index].gender?.toUpperCase()??''}',
                                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                                fontSize: 16,
                                                color: Colors.black
                                            ),
                                          ),
                                          SizedBox(height: size.height * 0.01,),
                                          Text('Age: ${doctor.patients![index].age??''}',
                                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                                fontSize: 16,
                                                color: Colors.black
                                            ),
                                          ),
                                          SizedBox(height: size.height * 0.01,),
                                          Text('Phone Number: ${doctor.patients![index].phoneNumber??''}',
                                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                                fontSize: 16,
                                                color: Colors.black
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    IconButton(onPressed: (){},
                                        icon: Icon(Icons.arrow_forward_ios,
                                        color: Colors.white,
                                          size: 30,
                                        ))
                                  ],
                                ),
                              ),
                            ),
                            separatorBuilder: (context, index) => SizedBox(height: size.height * 0.02,),
                            itemCount: doctor.patients!.length
                        ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
