
import 'dart:convert';

import 'package:api_project/Models/usermodel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {

  List<UserModel> userList =[];

  Future<List<UserModel>>getUserApi () async {
    final response =await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (var i in data) {
        userList.add(UserModel.fromJson(i));
      }
      return userList;
    } else {
      return userList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        titleTextStyle: 
        const TextStyle(
          color: Colors.white, fontSize: 25,
        ),
        title: const Text("Api"),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getUserApi(),
             builder: (context,AsyncSnapshot<List<UserModel>> snapshot){
              if (!snapshot.hasData) {
                return const CircularProgressIndicator();

              }else{

              return ListView.builder(
                itemCount: userList.length,
                itemBuilder: (context , index){
                  return Card(
                    child:Column(
                      children: [
                        ReuseableRow(title: 'Name', value: snapshot.data![index].name.toString()),
                        ReuseableRow(title: 'username', value: snapshot.data![index].username.toString()),
                        ReuseableRow(title: 'email', value: snapshot.data![index].email.toString()),
                        ReuseableRow(title: 'Address', value: snapshot.data![index].address!.city.toString()),
                      ],
                    ) ,
                  );
              },);
              }
             }
            ) ,
          )
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class ReuseableRow extends StatelessWidget {
  String title , value;
   ReuseableRow({super.key , required this.title,required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(title),
                              Text(value)
                            ],
                          ),
    );
  }
}
