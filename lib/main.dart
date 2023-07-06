import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    final c = ScrollController();
    return MaterialApp(
      home: Scaffold(
        body: CustomScrollView(
          controller: controller,
          slivers: [
            for (int i = 0; i < 3; ++i)
              const SliverToBoxAdapter(
                child: Placeholder(),
              ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 500,
                child: NotificationListener<OverscrollNotification>(
                  onNotification: (notification) {
                    final o = notification.dragDetails?.primaryDelta ?? 0;

                    controller.jumpTo(controller.offset - o);

                    return false;
                  },
                  child: ListView.builder(
                    // physics: ClampingScrollPhysics(),
                    itemCount: 5,

                    // itemExtent: 500,
                    itemBuilder: (context, index) {
                      return Container(
                        height: 300,
                        color: Colors.pink,
                        child: const Placeholder(),
                      );
                    },
                  ),
                ),
              ),
            ),
            for (int i = 0; i < 3; ++i)
              const SliverToBoxAdapter(
                child: Placeholder(),
              ),
          ],
        ),
      ),
    );
  }
}
