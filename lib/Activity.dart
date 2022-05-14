

import 'package:day_picker/day_picker.dart';
import 'package:flutter/material.dart';
import 'package:mobileapp/hero_dialogue_route.dart';
import 'package:mobileapp/weight_provider.dart';
import 'package:provider/provider.dart';

List<String> days = [];
List<List<String>> activities = [];
List<String>level_of_fitness = [];


class ActivityPage extends StatefulWidget {

  const ActivityPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _ActivityPageState createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(

              child: ListView.builder(
                shrinkWrap: true,
                itemCount: activities.length,
                itemBuilder:(BuildContext context, int index){
                  return ListTile(
                      shape: RoundedRectangleBorder(side: BorderSide(color: Colors.black, width: 1), borderRadius: BorderRadius.circular(5)),

                    onTap:(){
                      Navigator.of(context).push(HeroDialogRoute(builder: (context){
                        return const _ActivityPopupCard();
                      }));
                    },
                    onLongPress: (){
                        setState(() {
                          activities.removeAt(index);
                        });

                    },
                    title: Row(
                      children:[

                       Text('${activities[index].join(', ')} '),

                        Expanded(child: Text('${level_of_fitness[index]}', textAlign: TextAlign.right)),

                      ]
                    ),

                  );
                }
              ),
            ),
            Container(
              margin: EdgeInsets.only(top:5, bottom:10),
              child: GestureDetector(
                onTap: ()async{
                  await Navigator.push(context, HeroDialogRoute(builder:(context) => _AddActivityPopupCard()));
                  setState(() {

                  });
                },
                child: Hero(
                  tag:_heroAddTodo,
                  child: Material(
                    //color: Colors.blue,
                    elevation: 2,
                    shape:
                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
                    child: const Icon(
                      Icons.add_circle,
                      size: 56,
                    )
                  )
                )
              ),
            )
          ],

        )
      )
    );
  }
}

const String _heroAddTodo = 'add-todo-hero';

class _AddActivityPopupCard extends StatefulWidget {
 // const _AddActivityPopupCard({Key? key}) : super(key: key);

  @override
  _AddActivityPopupCardState createState() => _AddActivityPopupCardState();
}

class _AddActivityPopupCardState extends State<_AddActivityPopupCard> {


    final List<DayInWeek> _days = [
      DayInWeek(
        "Sun",
      ),
      DayInWeek(
        "Mon",
      ),
      DayInWeek(
        "Tue",

      ),
      DayInWeek(
        "Wed",
      ),
      DayInWeek(
        "Thu",
      ),
      DayInWeek(
        "Fri",
      ),
      DayInWeek(
        "Sat",
      ),
    ];
    String dropdownValue = 'Low';
    @override
    Widget build(BuildContext context) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
            child: Material(
              color: Colors.blue,
              elevation: 2,
              shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: [
                          Container(
                              margin:EdgeInsets.only(left: 16,right: 20),
                              child: Text('Level of Fitness:', style: TextStyle(color:Colors.white, fontSize: 20, fontWeight: FontWeight.bold))
                          ),
                          DropdownButton<String>(
                            value: dropdownValue,
                            icon: const Icon(Icons.arrow_downward),
                            elevation: 16,
                            style: const TextStyle(color: Colors.black),
                            underline: Container(
                              height: 2,
                              color: Colors.white,
                            ),
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownValue = newValue!;
                                print(dropdownValue);

                              });
                            },
                            items: <String>['Low', 'Moderate', 'High']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                      SelectWeekDays(
                        fontSize:14,
                        fontWeight: FontWeight.w500,
                        days: _days,
                        border: true,
                        boxDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),

                        ),
                        onSelect: (values) { // <== Callback to handle the selected days
                          //returns List<String>

                          days = values;
                          print(days);
                        },

                      ),
                      ElevatedButton(
                        onPressed: () {
                          context.read<Weight>().setDays(days,dropdownValue);
                          setState(() {
                            activities.add(days);
                            level_of_fitness.add(dropdownValue);
                          });
                          Navigator.pop(context, activities);
                        },

                        child: const Text('Add'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
      );
    }
}


class _ActivityPopupCard extends StatelessWidget {
  const _ActivityPopupCard({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Center(

      child: SizedBox(
        //padding: const EdgeInsets.only(top: 200.0, bottom: 250.0, left: 50.0, right: 50.0),
        height: 300,
        width: 300,
        child: Material(
          borderRadius: BorderRadius.circular(16),
          color: Colors.blue,
          child: SizedBox(

            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}



