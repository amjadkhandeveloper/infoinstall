import 'package:flutter/material.dart';
import 'package:infoinstall/PresentationLayer/Components/common_update.dart';

class Demo extends StatelessWidget {
  const Demo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 100,
          ),
          ValueListenableBuilder(
              valueListenable: CommonUpdate().variableName,
              builder: (context, value, _) {
                return Container(
                  height: value,
                  width: 200,
                  color: Colors.red,
                );
              }),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              CommonUpdate().variableName.value =
                  CommonUpdate().variableName.value + 30;
            },
            child: const Text("Press"),
          ),
          ElevatedButton(
              onPressed: () {
                CommonUpdate().variableName.value = 100;
              },
              child: const Text("Reset"))
        ],
      ),
    );
  }
}
