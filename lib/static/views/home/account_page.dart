import 'package:advertisment_fetcher/static/views/home/userProvider.dart';
import 'package:advertisment_fetcher/static/views/home/userProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Editprofilepage.dart';


class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserProvider=Provider.of<userProvider>(context);
    final userModel=UserProvider.user;
    return Scaffold(
      appBar: AppBar(
        title: Text('Account'),
      ),
      body: Center(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('images/profile1.png'),

            ),
            SizedBox(height: 20),
            Text(userModel?.fullName ?? 'Guest User',
              style: TextStyle(fontSize: 20, fontWeight:FontWeight.bold ),
                ),
            Text(userModel?.email?? ''),
            SizedBox(height: 20),
            ElevatedButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>EditProfilePage()));
                },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.edit),
                SizedBox(width: 5),
                Text('Edit Profile'),
                ],
              ),
            ),


          ],
        )
      ),
    );
  }
}
