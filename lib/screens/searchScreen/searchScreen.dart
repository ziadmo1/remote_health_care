import 'package:flutter/material.dart';
import 'package:remote_healthcare/screens/loginScreen_admin/models/AuthAdminRes.dart';
import 'package:remote_healthcare/screens/searchScreen/search_widget.dart';
import 'package:remote_healthcare/themes/myTheme.dart';

import '../../api_manager/api_manager.dart';
import 'models/SearchRes.dart';

class PatientsSearch extends SearchDelegate {
    String doctorEmail;
    PatientsSearch(this.doctorEmail);

  @override
  // TODO: implement textInputAction
  TextInputAction get textInputAction => TextInputAction.search;

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      appBarTheme: AppBarTheme(
        toolbarHeight: 80,
        color: MyTheme.lightOrange,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        elevation: 0,
      ),

      scaffoldBackgroundColor: MyTheme.lightOrange,
      inputDecorationTheme: searchFieldDecorationTheme ??
          InputDecorationTheme(
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: MyTheme.lightOrange)
            ),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: MyTheme.lightOrange)
            ),
            focusedBorder:UnderlineInputBorder(
          borderSide: BorderSide(color: MyTheme.lightOrange)
    ),
            fillColor: Colors.white,
            hintStyle: TextStyle(color: Colors.black),
            filled: true,
          ),
      textSelectionTheme: TextSelectionThemeData(cursorColor: MyTheme.lightOrange),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(onPressed: () {
      Navigator.pop(context);
    }, icon: Icon(Icons.clear,size: 35,color: Colors.white,));
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return Text('');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    if (query.isEmpty) {
      return Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.person_outline,size: 150,color: Colors.black,),
          Text('No Patients Found',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
              )
          )
        ],
      ));
    }
    return FutureBuilder<SearchRes>(
      future: ApiManager.patientsSearch(query,doctorEmail),
      builder: (context, snapshot) {
        if(snapshot.hasError){
          return Center(child: Text(snapshot.data?.message??''));
        }
        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(child: CircularProgressIndicator(color: Colors.white,),);
        }
        var searchData = snapshot.data?.data?.patients;
        return ListView.builder(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) => SearchWidget(searchData![index],doctorEmail,),
            itemCount: searchData?.length
        );
      },
    );
  }
}
