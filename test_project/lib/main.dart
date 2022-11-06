import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:test_project/home_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Drag and Drop',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home:  HomePage(),
    );
  }
}


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {

  late List<ItemModel> items;
  late List<ItemModel>items2;

  late int score;
  late bool gameOver;

  @override
  void initState() {
    super.initState();
    initGame();
  }

  initGame(){
    gameOver = false;
    score=0;
    items=[
      ItemModel(icon:FontAwesomeIcons.coffee,name:"Coffee", value:"Coffee"),
      ItemModel(icon:FontAwesomeIcons.dog,name:"dog", value:"dog"),
      ItemModel(icon:FontAwesomeIcons.cat,name:"Cat", value:"Cat"),
      ItemModel(icon:FontAwesomeIcons.birthdayCake,name:"Cake", value: "Cake"),
      ItemModel(icon:FontAwesomeIcons.bus,name:"bus", value:"bus"),
    ];
    items2 = List<ItemModel>.from(items);
    items.shuffle();
    items2.shuffle();
  }


  @override
  Widget build(BuildContext context) {
    if(items.length == 0)
      gameOver = true;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Drag and Drop'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Text.rich(TextSpan(
                children: [
                  const TextSpan(text: "Score: "),
                  TextSpan(text: "$score", style: const TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0,
                  ))
                ]
            )
            ),
            if(!gameOver)
              Row(
                children: <Widget>[
                  Column(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                        onPressed: () =>HomeView(),
                        child: const Text('Another Page'),
                      ),
                    ],
                  ),

                  Column(
                      children: items.map((item) {
                        return Container(
                          margin: const EdgeInsets.all(8.0),
                          child: Draggable<ItemModel>(
                            data: item,
                            childWhenDragging: Icon(
                              item.icon, color: Colors.grey,size: 50.0,),
                            feedback: Icon(item.icon,color: Colors.teal,size: 50,),
                            child: Icon(item.icon, color: Colors.teal, size:50,),
                          ),
                        );


                      }).toList()
                  ),
                  Spacer(

                  ),
                  Column(
                      children: items2.map((item){
                        return DragTarget<ItemModel>(
                          onAccept: (receivedItem){
                            if(item.value== receivedItem.value){
                              setState(() {
                                items.remove(receivedItem);
                                items2.remove(item);
                                score+=10;
                                item.accepting =false;
                              });

                            }else{
                              setState(() {
                                score-=5;
                                item.accepting =false;

                              });
                            }
                          },
                          onLeave: (receivedItem){
                            setState(() {
                              item.accepting=false;
                            });
                          },
                          onWillAccept: (receivedItem){
                            setState(() {
                              item.accepting=true;
                            });
                            return true;
                          },
                          builder: (context, acceptedItems,rejectedItem) => Container(
                            color: item.accepting? Colors.red:Colors.teal,
                            height: 50,
                            width: 100,
                            alignment: Alignment.center,
                            margin: const EdgeInsets.all(8.0),
                            child: Text(item.name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold,
                                fontSize: 18.0),),
                          ),


                        );

                      }).toList()

                  ),
                ],
              ),
            if(gameOver)
              Text("GameOver", style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 24.0,
              ),),
            if(gameOver)
              Center(
                child: ElevatedButton(
                  child: Text('Elevated Button'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  onPressed: () {},
                ),
              )

          ],
        ),

      ),
    );
  }
}

class ItemModel {
  final String name;
  final String value;
  final IconData icon;
  bool accepting;
  ItemModel({required this.name, required this.value, required this.icon, this.accepting= false});}

