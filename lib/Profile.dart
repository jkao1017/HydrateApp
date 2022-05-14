import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mobileapp/weight_provider.dart';

import 'package:vertical_weight_slider/vertical_weight_slider.dart';

double _weightkg = 100.0;
double _weightlbs = 100.0;
double _savedWeight = 0;
bool isPound = true;

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key, required this.title}) : super(key: key);
  
  final String title;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late WeightSliderController _controller;

  @override
  void initState(){
    super.initState();
    _controller = WeightSliderController(
      initialWeight: _weightlbs, minWeight: 0, interval: 1);

  }
  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
  }

  void convertWeight(){
    _weightkg = (_weightlbs * 0.45359237);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: Column(
        children: [
          Container(
            height : 150.0,
            alignment: Alignment.center,
            child: Text(
              isPound == true ? "${_weightlbs.toStringAsFixed(1)} lbs" : "${_weightkg.toStringAsFixed(1)} kg",
              style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.w500),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.autorenew),
            color: Colors.black,
            onPressed: () {
              convertWeight();

              setState((){
                isPound = !isPound;
              });
            },
          ),
          VerticalWeightSlider(
            controller: _controller,
            decoration: const PointerDecoration(
              width: 130.0,
              height: 3.0,
              largeColor: Color(0xFF898989),
              mediumColor: Color(0xFFC5C5C5),
              smallColor: Color(0xFFF0F0F0),
              gap: 30.0,
            ),
            onChanged: (double value){
              isPound ? setState((){_weightlbs = value;}) : setState((){_weightkg = value;});
            },
            indicator: Container(
              height: 3.0,
              width: 200.0,
              alignment: Alignment.centerLeft,
              color: Colors.red[300]
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if(isPound){
                _savedWeight = _weightlbs;
                context.read<Weight>().setWeight(_savedWeight, isPound);
              }else{
                _savedWeight = _weightkg;
                context.read<Weight>().setWeight(_savedWeight,isPound);
              }


            },

            child: const Text('Save'),
          ),
        ]
      )
    );

  }





}
