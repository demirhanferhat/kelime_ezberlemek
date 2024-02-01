import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kelime_ezberlemek/global_widget/app_bar.dart';
import 'package:kelime_ezberlemek/pages/list.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:package_info_plus/package_info_plus.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

enum Lang { eng, tr }

final Uri _url = Uri.parse('https://bordotasarim.com');

class _MainPageState extends State<MainPage> {
  Lang? _chooseLang = Lang.eng;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late PackageInfo packageInfo;
  String version = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    packageInfoInit();
  }

  void packageInfoInit() async {
    WidgetsFlutterBinding.ensureInitialized();
    packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      version = packageInfo.version;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.7,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Image.asset(
                    "assets/images/logo.png",
                    height: 80,
                  ),
                  const Text(
                    "FEEYO",
                    style: TextStyle(fontFamily: "RobotoLight", fontSize: 26),
                  ),
                  const Text(
                    "İstediğini Öğren",
                    style: TextStyle(fontFamily: "RobotoLight", fontSize: 16),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: const Divider(
                      color: Colors.black,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 50, right: 8, left: 8),
                    child: const Text(
                      "Bu uygulamanın nasıl yapıldığını öğrenmek için bana yaz",
                      style: TextStyle(fontFamily: "RobotoLight", fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  InkWell(
                    onTap: _launchUrl,
                    child: Text(
                      "Tıkla",
                      style: TextStyle(
                          fontFamily: "RobotoLight",
                          fontSize: 16,
                          color: Colors.blueAccent.shade400),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "V" + version + "\ninfo@bordotasarim.com",
                  style: TextStyle(
                      fontFamily: "RobotoLight",
                      fontSize: 14,
                      color: Colors.blueAccent.shade400),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
      appBar: appBar(context,
          left: const FaIcon(FontAwesomeIcons.bars, color: Colors.black),
          center: Image.asset("assets/images/logo_text.png"),
          leftWidgetObClick: () => {_scaffoldKey.currentState!.openDrawer()}),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Center(
            child: Column(
              children: [
                langRadioButton(
                    text: "İngilzice - Türkçe",
                    group: _chooseLang,
                    value: Lang.tr),
                langRadioButton(
                    text: "Türkçe - İngilizce",
                    group: _chooseLang,
                    value: Lang.eng),
                const SizedBox(
                  height: 25,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ListPage()));
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 55,
                    margin: const EdgeInsets.only(bottom: 20),
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: <Color>[
                            Color(0xff1f005c),
                            Color(0xff5b0060),
                            Color(0xff870160),
                            Color(0xffac255e),
                            Color(0xffca485c),
                            Color(0xffe16b5c),
                            Color(0xfff39060),
                            Color(0xffffb56b),
                          ],
                          tileMode: TileMode.mirror,
                        )),
                    child: const Text(
                      "Listelerim",
                      style: TextStyle(
                          fontSize: 24,
                          fontFamily: "Carter",
                          color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.80,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      card(
                        context,
                        title: "Kelime\nKartları",
                        startColor: "Color.fromRGBO(23, 181, 255, 1)",
                        endColor: "Color.fromARGB(255, 2, 27, 255)",
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 200,
                        width: MediaQuery.of(context).size.width * 0.35,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: <Color>[
                                Color.fromRGBO(255, 10, 104, 1),
                                Color.fromARGB(255, 255, 46, 192),
                              ],
                              tileMode: TileMode.mirror,
                            )),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "Çoktan\nSeçmeli",
                              style: TextStyle(
                                  fontSize: 24,
                                  fontFamily: "Carter",
                                  color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                            Icon(
                              Icons.check_circle_outline,
                              size: 64,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container card(BuildContext context,
      {required String? startColor,
      required String? endColor,
      required String? title}) {
    return Container(
      alignment: Alignment.center,
      height: 200,
      width: MediaQuery.of(context).size.width * 0.35,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[
            Color.fromARGB(255, 54, 32, 247),
            Color.fromARGB(255, 46, 189, 255),
          ],
          tileMode: TileMode.mirror,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            title!,
            style: const TextStyle(
                fontSize: 24, fontFamily: "Carter", color: Colors.white),
            textAlign: TextAlign.center,
          ),
          const Icon(
            Icons.file_copy,
            size: 64,
            color: Colors.white,
          )
        ],
      ),
    );
  }

  SizedBox langRadioButton(
      {required String? text, required Lang value, required Lang? group}) {
    return SizedBox(
      width: 260,
      height: 30,
      child: ListTile(
        title: Text(
          text!,
          style: const TextStyle(fontFamily: "Carter", fontSize: 15),
        ),
        leading: Radio<Lang>(
          value: value,
          groupValue: group,
          onChanged: (Lang? value) {
            setState(() {
              _chooseLang = value;
            });
          },
        ),
      ),
    );
  }
}

Future<void> _launchUrl() async {
  if (!await launchUrl(_url)) {
    throw Exception('Could not launch $_url');
  }
}
