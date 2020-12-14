import 'package:flutter/material.dart';
import 'package:flutter_pie/src/paper_painter.dart';

class FlutterPie extends StatefulWidget {
  /// 数据源
  /// 
  final Map<String, double> dataMap;

  FlutterPie({this.dataMap});
  @override
  _FlutterPieState createState() => _FlutterPieState();
}
//  Map<String, double> dataMap = {
//     "Flutter": 5,
//     "React": 3,
//     "Xamarin": 2,
//     "Ionic": 2,
//   };
class _FlutterPieState extends State<FlutterPie> {
  List  listDesc= [];
  List listSource= [];
  
  @override
  void initState() {
    
    super.initState();
    listSource = widget.dataMap.values.toList(); //数据源
    listDesc = widget.dataMap.keys.toList(); //标题
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomPaint(
        painter: PaperPainter(listSource:listSource,listDesc:listDesc),
      ),
    );
  }
}

