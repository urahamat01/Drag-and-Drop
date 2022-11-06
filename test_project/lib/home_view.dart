import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_project/home_controller.dart';



class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Draggable & Drag Targets'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Obx(
                  () => Stack(
                children: controller.numbers.length == 0
                    ? [_builDraggableWithNoItem()]
                    : controller.numbers
                    .map(
                      (num) => Draggable(
                    data: num,
                    child: _buildDraggable(num.toString()),
                    feedback: _buildDraggable(num.toString()),
                    childWhenDragging: Container(
                      height: 100,
                      width: 100,
                    ),
                  ),
                )
                    .toList(),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildDragTarget(
                  text: 'Even',
                  color: Colors.lightBlue,
                  acceptType: 1,
                ),
                _buildDragTarget(
                  text: 'Odd',
                  color: Colors.deepPurple,
                  acceptType: 0,
                ),
              ],
            ),
            ElevatedButton(
              child: Text('Restart'),
              onPressed: () => controller.restartGame(),
            )
          ],
        ),
      ),
    );
  }

  Widget _builDraggableWithNoItem() => Container(
      height: 100,
      width: 100,
      child:
      Text('No Item', style: TextStyle(color: Colors.white, fontSize: 18)),
      alignment: Alignment.center,
      color: Colors.black);

  Widget _buildDraggable(String text) => Container(
      height: 100,
      width: 100,
      child: Text(text, style: TextStyle(color: Colors.white, fontSize: 18)),
      alignment: Alignment.center,
      color: Colors.red);

  Widget _buildDragTarget({required String text, required Color color, required int acceptType}) =>
      DragTarget<int>(
        builder: (context, acceptdata, rejectdata) => Container(
            height: 100,
            width: 100,
            child:
            Text(text, style: TextStyle(color: Colors.white, fontSize: 18)),
            alignment: Alignment.center,
            color: color),
        onWillAccept: (data) {
          return true;
        },
        onAccept: (data) {
          controller.checkCorrectAnswer(data, acceptType);
        },
      );
}
