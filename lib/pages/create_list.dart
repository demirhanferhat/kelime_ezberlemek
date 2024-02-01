import 'package:flutter/material.dart';
import 'package:kelime_ezberlemek/db/db/db.dart';
import 'package:kelime_ezberlemek/db/models/lists.dart';
import 'package:kelime_ezberlemek/db/models/words.dart';
import 'package:kelime_ezberlemek/global_widget/app_bar.dart';

class CreateList extends StatefulWidget {
  const CreateList({super.key});

  @override
  State<CreateList> createState() => _CreateListState();
}

class _CreateListState extends State<CreateList> {
  final _listName = TextEditingController();

  List<TextEditingController> wordTextEditingList = [];
  List<Row> wordListField = [];

  //Bir sınıf çağrıldığında ilk çalışan sınıf initstate
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (var i = 0; i < 10; i++) {
      wordTextEditingList.add(TextEditingController());
    }

    for (var i = 0; i < 5; i++) {
      debugPrint(
          "=======>" + (2 * i).toString() + "     " + (2 * i + 1).toString());

      wordListField.add(
        Row(
          children: [
            Expanded(
              child: textFieldBuilder(
                  textEditingController: wordTextEditingList[2 * i]),
            ),
            Expanded(
              child: textFieldBuilder(
                  textEditingController: wordTextEditingList[2 * i + 1]),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context,
          left: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          center: Image.asset("assets/images/logo_text.png"),
          right: Image.asset(
            "assets/images/logo.png",
            height: 35,
            width: 35,
          ),
          leftWidgetObClick: () => {Navigator.pop(context)}),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              textFieldBuilder(
                icons: const Icon(Icons.list, size: 28),
                hintTexts: "Liste Adı",
                textEditingController: _listName,
                textAlign: TextAlign.left,
              ),
              Container(
                margin: const EdgeInsets.only(top: 20, bottom: 10),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("İngilizce", style: TextStyle(fontSize: 18)),
                    Text(
                      "Türkçe",
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ...wordListField,
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  actionBtn(() => addRow(), Icons.add),
                  actionBtn(() => saveRow(), Icons.save),
                  actionBtn(() => deleteRow(), Icons.remove)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  // Buton
  InkWell actionBtn(Function() click, IconData icon) {
    return InkWell(
      onTap: () => click(),
      child: Container(
        width: 40,
        height: 40,
        margin: const EdgeInsets.all(25),
        child: Icon(icon, size: 32),
        decoration: BoxDecoration(
          color: Colors.purple.shade200,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  void addRow() {
    wordTextEditingList.add(TextEditingController());
    wordTextEditingList.add(TextEditingController());

    int lastIndex = wordTextEditingList.length - 2;

    wordListField.add(
      Row(
        children: [
          Expanded(
            child: textFieldBuilder(
              textEditingController: wordTextEditingList[lastIndex],
            ),
          ),
          Expanded(
            child: textFieldBuilder(
              textEditingController: wordTextEditingList[lastIndex + 1],
            ),
          ),
        ],
      ),
    );

    setState(() {});
  }

  void saveRow() async {
    int counter = 0;
    bool notEmptyPair = false;

    for (var i = 0; i < wordTextEditingList.length / 2; i++) {
      String eng = wordTextEditingList[2 * i].text;
      String tr = wordTextEditingList[2 * i + 1].text;

      if (eng.isNotEmpty && tr.isNotEmpty) {
        counter++;
      } else {
        notEmptyPair = false;
      }
    }

    debugPrint("Counter: $counter");

    if (counter >= 4) {
      if (!notEmptyPair) {
        Lists addedList =
            await DB.instance.insertList(Lists(name: _listName.text));

        for (var i = 0; i < wordTextEditingList.length / 2; i++) {
          String eng = wordTextEditingList[2 * i].text;
          String tr = wordTextEditingList[2 * i + 1].text;

          Word word = await DB.instance.insertWord(Word(
              list_id: addedList.id,
              word_eng: eng,
              word_tr: tr,
              status: false));

          debugPrint(word.id.toString() +
              " " +
              word.list_id.toString() +
              " " +
              word.word_eng.toString() +
              " " +
              word.word_tr.toString() +
              " " +
              word.status.toString());
        }

        debugPrint("TOAST MESSAGE => Liste oluşturuldu");
        _listName.clear();
        for (var element in wordTextEditingList) {
          element.clear();
        }
      } else {
        debugPrint("TOAST MESSAGE => Boş alanları doldurun veya silin");
      }
    } else {
      debugPrint("TOAST MESSAGE => Minumum 4 çift dolu olmalıdır");
    }
  }

  void deleteRow() {
    if (wordListField.length != 1) {
      wordTextEditingList.removeAt(wordTextEditingList.length - 2);
      wordTextEditingList.removeAt(wordTextEditingList.length - 1);

      wordListField.removeAt(wordListField.length - 1);
      setState(() => wordListField);
    } else {
      debugPrint("Son 1 eleman kaldı");
    }
  }

  Container textFieldBuilder(
      {int height = 40,
      required TextEditingController? textEditingController,
      Icon? icons,
      String? hintTexts,
      TextAlign textAlign = TextAlign.center}) {
    return Container(
      height: double.parse(height.toString()),
      padding: const EdgeInsets.only(left: 16, right: 16),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 102, 102, 102).withOpacity(0.50),
        borderRadius: BorderRadius.circular(4),
      ),
      margin: const EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: 16,
        top: 16,
      ),
      child: TextField(
        keyboardType: TextInputType.name,
        maxLines: 1,
        textAlign: textAlign,
        controller: textEditingController,
        style: const TextStyle(
          color: Colors.black,
          fontFamily: "RobotoMedium",
          decoration: TextDecoration.none,
          fontSize: 18,
        ),
        decoration: InputDecoration(
          icon: icons,
          border: InputBorder.none,
          hintText: hintTexts,
          fillColor: Colors.transparent,
          isDense: true,
        ),
      ),
    );
  }
}
