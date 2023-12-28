import 'package:bloc_learn/model/users_model.dart';
import 'package:bloc_learn/screens/news_screen.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ViewData extends StatefulWidget {
  UserModel userdata;

  ViewData({Key? key, required this.userdata}) : super(key: key);

  @override
  State<ViewData> createState() => _ViewDataState();
}

class _ViewDataState extends State<ViewData> {
  @override
  Widget build(BuildContext context) {
    UserModel data = widget.userdata;
    return Scaffold(
        appBar: AppBar(
          title: const Text("View Data"),
        ),
        body: Column(
          children: [
            Text(data.name.toString()),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const NewsScreen()));
                },
                child: const Text('Lihat Berita'))
          ],
        ));
  }
}
