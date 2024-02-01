import 'package:flutter/material.dart';
import 'package:kelime_ezberlemek/global_widget/app_bar.dart';
import 'package:kelime_ezberlemek/pages/create_list.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context,
          left: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          center: Image.asset("assets/images/lists.png"),
          right: Image.asset(
            "assets/images/logo.png",
            height: 35,
            width: 35,
          ),
          leftWidgetObClick: () => {Navigator.pop(context)}),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const CreateList()));
        },
        backgroundColor: Colors.purple.withOpacity(0.5),
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Center(
              child: Container(
                width: double.infinity,
                child: Card(
                  color: Colors.purple.shade300,
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  margin: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                          left: 15,
                          top: 5,
                        ),
                        child: const Text("Liste Adı",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontFamily: "RobotoMedium")),
                      ),
                      Container(
                          margin: const EdgeInsets.only(left: 25, top: 10),
                          child: const Text("305 Öğrenildi",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontFamily: "RobotoRegular"))),
                      Container(
                        margin: const EdgeInsets.only(left: 25, top: 10),
                        child: const Text("305 Öğrenilmedi",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: "RobotoRegular")),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
