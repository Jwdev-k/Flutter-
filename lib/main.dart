import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:native_app/obj/items.dart';

void main() {
  runApp(Native_App());
  File banner = File("assets/Banner.txt");
  if (kDebugMode) {
    print("\n" + banner.readAsStringSync().replaceAll("\n", "") +
      "\n 네이티브 앱 실행 성공.");
  }
}

class Native_App extends StatefulWidget {
  @override
  State<StatefulWidget> createState(){
    return MainPage();
  }
}

class MainPage extends State<Native_App> {
  int value = 0;

  void plusValue() {
    setState(() {
      value += 1;
    });
  }

  void minusValue(BuildContext context) {
    if (value > 0) {
      setState(() {
        value -= 1;
      });
    } else {
      _showPopup(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Native App",
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Scaffold(
            appBar: AppBar(
              title: Row(
                children: [
                  Image.asset('assets/images/main-star.png', width: 50, height: 50),
                  Text(
                    "NK_Service",
                    style: TextStyle(color: Colors.yellow),
                  ),
                ],
              ),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Builder(
                  builder: (context) {
                    return Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.all(10)),
                        onPressed: () { showDialog(
                            context: context,
                            builder: (con) => AlertDialog(
                              title: Text("알림", style: TextStyle(color: Colors.red),),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  for (Items item in ListTest())
                                    Text("아이디 : ${item.id}\n이름 : ${item.name}\n"),
                                ],
                              ),
                              actions: [
                                TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text("닫기"))
                              ],
                            ));},
                        child: Text("버튼", style: TextStyle(
                            fontWeight: FontWeight.w100),
                            textAlign: TextAlign.center),
                      ),
                    );
                  }
                ),
                Builder(
                    builder: (context) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center, // 세로 중앙 정렬
                        crossAxisAlignment: CrossAxisAlignment.center, // 가로 중앙 정렬
                        children: [
                          Text(
                            "$value",
                            style: TextStyle(
                              fontSize: 20, // 글꼴 크기를 20으로 설정
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center, // 가로 중앙 정렬
                            children: [
                              ElevatedButton(onPressed: plusValue, child: Text("+")),
                              SizedBox(width: 16),
                              ElevatedButton(onPressed: () => minusValue(context), child: Text("-")),
                            ],
                          ),
                        ],
                      );
                    }
                )
,
              ],
            ),
            bottomNavigationBar: BottomAppBar(
              height: 70,
              child: Builder(
                builder: (context) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) => errorAlert(),
                          );
                        },
                        icon: const Icon(Icons.handshake_outlined, color: Colors.black),
                      ),
                      IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) => errorAlert(),
                            );
                          },
                          icon: const Icon(Icons.chat, color: Colors.black)),
                      IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) => errorAlert(),
                            );
                          },
                          icon: const Icon(Icons.settings, color: Colors.black)),
                    ],
                  );
                }
              ),
            )
        )
    );
  }
}

void _showPopup(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('오류', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
        content: Text('0 보다 작은 수가 될 수 없습니다.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('닫기'),
          ),
        ],
      );
    },
  );
}

class errorAlert extends StatelessWidget {
  const errorAlert({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("오류", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
      content: Text("알 수 없는 오류가 발생하였습니다.", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w100)),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text("닫기"),
        ),
      ],
    );
  }
}

List<Items> ListTest() {
  List<Items> item = [];

  item.add(Items(1, "test1"));
  item.add(Items(2, "test2"));
  item.add(Items(3, "test3"));

  return item;
}