import 'package:flutter/material.dart';
import 'package:flutter_pie/src/common.dart';
import 'package:flutter_pie/src/paper_painter.dart';

class FlutterPie extends StatefulWidget {
  /// 数据源
  final Map<String, double> dataMap;

  /// 默认配置颜色
  final List<Color> colorList;

  ///饼图的半径
  final double chartRadius;

  FlutterPie({
    this.dataMap,
    this.colorList = defaultColorList,
    this.chartRadius,
  });

  @override
  _FlutterPieState createState() => _FlutterPieState();
}

class _FlutterPieState extends State<FlutterPie> {
  ///标题描述
  List destList = [];

  /// 标题对应的 values
  List sourceList = [];

  @override
  void initState() {
    super.initState();
    initData();
  }

  initData() {
    sourceList = widget.dataMap.values.toList(); //提取数据源
    destList = widget.dataMap.keys.toList(); //提取标题
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(color: Colors.red),
            child: Text("??"),
          ),
          renderPie(),
        ],
      ),
    );
  }

  renderPie() {
    return Flexible(
      child: LayoutBuilder(
        builder: (context, constraints) => Container(
          height: widget.chartRadius != null
              ? constraints.maxWidth < widget.chartRadius
                  ? constraints.maxWidth
                  : widget.chartRadius
              : null,
          child: CustomPaint(
            painter: PaperPainter(
              sourceList: sourceList,
              destList: destList,
            ),
            child: AspectRatio(aspectRatio: 1),
          ),
        ),
      ),
    );
  }
}
