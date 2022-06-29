import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  bool animationCompleted = false;

  @override
  void initState() {
    animationController = AnimationController(vsync: this);
    animationController.addListener(() {
      if (animationController.value == 1) {
        animationController.stop();
        animationCompleted = true;
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xfface0f1),
      body: Stack(
        children: [
          AnimatedContainer(
            duration: const Duration(seconds: 1),
            height: animationCompleted ? screenHeight / 1.5 : screenHeight,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(animationCompleted ? 40.0 : 0.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Lottie.asset(
                    'assets/shopping-cart.json',
                    controller: animationController,
                    onLoaded: (composition) {
                      animationController
                        ..duration = composition.duration
                        ..forward();
                    },
                  ),
                ),
                Center(
                  child: AnimatedOpacity(
                    opacity: animationCompleted ? 1 : 0,
                    duration: const Duration(seconds: 1),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                         Text(
                          'S H O P & ',
                          style: TextStyle(
                            fontSize: 30,
                            color: Color(0xfface0f1),
                          ),
                        ),
                        Text(
                          'D R O P',
                          style: TextStyle(
                            fontSize: 30,
                            color: Color(0xffb8c3e4),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Visibility(
              visible: animationCompleted,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 20.0),
                      Text(
                        'The chances of heading off to the store for a portion of bread and turning out with just a '
                            'portion of bread are three billion to one.',
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.white.withOpacity(0.8),
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          height: 85.0,
                          width: 85.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white,
                              width: 2.0,
                            ),
                          ),
                          child: const Icon(
                            Icons.chevron_right,
                            size: 50.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 50.0),
                    ],
                  ),
                ),

              ),
          ),
        ],
      ),
    );
  }
}
