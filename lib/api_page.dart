// https://reqres.in/api

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DemoAPI extends StatefulWidget {
  const DemoAPI({Key? key}) : super(key: key);

  @override
  State<DemoAPI> createState() => _DemoAPIState();
}

class _DemoAPIState extends State<DemoAPI> {
  final String baseUrl = "https://reqres.in/api";
  late List<dynamic> userData;

  @override
  void initState() {
    super.initState();
    fetchData('users');
  }

  Future<void> fetchData(String endpoint) async {
    final response = await http.get(Uri.parse('$baseUrl/$endpoint?page=2'));

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        userData = data['data'];
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Demo API'),
      ),
      body: null == userData
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemExtent:
                  80, // Adjust this value based on your design requirements
              itemBuilder: (context, index) {
                final user = userData[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(user['avatar']),
                  ),
                  title: Text('${user['first_name']} ${user['last_name']}'),
                  subtitle: Text('${user['email']}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserDetailsPage(user: user),
                      ),
                    );
                  },
                );
              },
              itemCount: userData.length,
            ),
    );
  }
}

class UserDetailsPage extends StatelessWidget {
  final dynamic user;

  UserDetailsPage({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${user['first_name']} ${user['last_name']} Details'),
      ),
      body: Card(
        margin: EdgeInsets.all(16),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(user['avatar']),
              SizedBox(height: 8),
              Text('Email: ${user['email']}'),
              SizedBox(height: 8),
              Text('ID: ${user['id']}'),
              SizedBox(height: 8),
              Text('first name: ${user['first_name']}'),
              SizedBox(height: 8),
              Text('last name: ${user['last_name']}'),
            ],
          ),
        ),
      ),
    );
  }
}
