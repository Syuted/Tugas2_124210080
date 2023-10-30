import 'package:flutter/material.dart';
import 'package:tujuh/api_data_source.dart';
import 'package:tujuh/detail_user.dart';
import 'package:tujuh/users_model.dart';

class HalamanUsers extends StatelessWidget {
  const HalamanUsers({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Users"), backgroundColor: Colors.lightBlue,
      ),
      body: FutureBuilder(
        future: ApiDataSource.instance.loadUsers(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("ADA ERROR");
          }
          if (snapshot.hasData) {
            UsersModel users = UsersModel.fromJson(snapshot.data!);
            return ListView.builder(
              itemCount: users.data!.length,
              itemBuilder: (BuildContext context, int index) {
                var user = users.data![index];

                return ListTile(
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HalamanDetail(id: user.id!))
                    );
                  },
                  leading: CircleAvatar(
                    foregroundImage: NetworkImage(user.avatar!),
                  ),
                  title: Text(user.firstName! + " " + user.lastName!),
                  //title: Text('${user.firstName} ${user.lastName}'),
                  //subtitle: Text('${user.email}'),
                  subtitle: Text(user.email!),
                );
                // return Text(user.firstName ?? 'Nama');
              },
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
