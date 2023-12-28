import 'package:bloc_learn/model/users_model.dart';
import 'package:bloc_learn/screens/news_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ViewData extends StatefulWidget {
  const ViewData({Key? key, required this.userdata}) : super(key: key);
  final UserModel userdata;

  @override
  State<ViewData> createState() => _ViewDataState();
}

class _ViewDataState extends State<ViewData> {
  @override
  Widget build(BuildContext context) {
    UserModel data = widget.userdata;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                SystemNavigator.pop();
              },
              icon: const Icon(Icons.arrow_back)),
          title: const Text("View Data"),
        ),
        body: Center(
          child: Card(
            color: Colors.blue.shade800,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    height: 200,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              'https://hsi-proteksi.com${data.picturePath.toString()}',
                            )))),
                Text(
                  data.name.toString(),
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
                Text(
                  data.deviceId.toString(),
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        minimumSize: const Size.fromHeight(50),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const NewsScreen()));
                      },
                      child: const Text('Lihat Berita')),
                )
              ],
            ),
          ),
        ));
  }
}
