

import 'package:flutter/material.dart';
import 'package:mobileapp/Profile.dart';
import 'package:mobileapp/Notification.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:mobileapp/weight_provider.dart';
import 'package:wheel_chooser/wheel_chooser.dart';
import 'package:mobileapp/hero_dialogue_route.dart';

bool isPressed = false;
int addedWater = 20;
double percent = 0;
int oz = 0;
int ml = 0;
class MyHomePage extends StatefulWidget {

  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int _counter = 0;

  int weight = 0;
  void _convertML(){
    ml = (oz * 29.57353).floor();
  }

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    oz = context.watch<Weight>().waterOZ;
    ml = context.watch<Weight>().waterML;

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: ()async{

                await Navigator.push(context, HeroDialogRoute(builder:(context) => _AddWaterCard()));
                setState(() {

                });
              },
              child: const Text('Add Water'),
            ),
            SizedBox(height:50),
            CircularPercentIndicator(
              radius: 100,
              lineWidth: 10.0,
              percent: percent,
              animation: true,
              center: Icon(
                Icons.water,
                size: 50.0,
                color: Colors.blue,
              ),
              backgroundColor: Colors.grey,
              progressColor: Colors.blue,
            ),

            SizedBox(height:50),
             ElevatedButton(onPressed:(){
               setState(() {
                 percent = 0;
                 context.read<Weight>().reset();
               });

             }, child: Text('Reset')),
             IconButton(
                icon: const Icon(Icons.autorenew),
                color: Colors.black,
                onPressed: () {

                  setState((){
                    isPressed = !isPressed;
                  });
                },
              ),

            isPressed == false ? Text("Fluid Ounces: " + context.watch<Weight>().visualOZ.toString()) : Text("Milliliters: " + context.watch<Weight>().visualML.toString())


          ],
        ),
      ),

    );
  }
}

const String _heroAddTodo = 'add-todo-hero';

class _AddWaterCard extends StatefulWidget{
  @override
  _AddWaterCardState createState() => _AddWaterCardState();
}

class _AddWaterCardState extends State<_AddWaterCard>{
  var addedWater = 20;
  @override
  Widget build(BuildContext context) {

    return Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:<Widget> [
              Flexible(
                flex: 3,
                child: Material(
                  shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                  child: SizedBox(

                    height: 500,
                    width: 300,
                    child: WheelChooser.integer(
                      listHeight: 1000,
                      initValue: 20,

                      selectTextStyle: TextStyle(fontSize: 30, color: Colors.black),
                      unSelectTextStyle: TextStyle(fontSize:20, color: Colors.grey),
                      onValueChanged: (i){


                        addedWater = i;
                      },
                      maxValue: 1000,
                      minValue: 1,
                      step: 1,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Flexible(
                child: SizedBox(
                  width: 100,
                  height: 50,
                  child: ElevatedButton(
                      onPressed:(){

                        setState(() {
                          if(!isPressed){
                            if((percent + addedWater/oz) <= 1.0){
                              percent += addedWater/oz;
                              context.read<Weight>().decrement(addedWater,!isPressed);
                            }
                          }else{
                            if((percent + addedWater/ml) <= 1.0) {
                              percent += addedWater / ml;
                              context.read<Weight>().decrement(
                                  addedWater, isPressed);
                            }
                          }


                        });

                        Navigator.pop(context, percent);
                  }, child: const Text("Add")),
                ),
              ),

            ],
          ),
        )






    );
  }
}


