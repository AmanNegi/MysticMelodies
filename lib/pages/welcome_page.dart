import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:mysticmelodies/globals.dart';
import 'package:mysticmelodies/pages/home_page.dart';

class WelcomePage extends StatefulHookWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  late AnimationController controller;
  late Animation positionAnimation;
  late Animation buttonAnimation;

  @override
  Widget build(BuildContext context) {
    controller = useAnimationController(
      duration: const Duration(seconds: 2),
    );
    positionAnimation = Tween<double>(
      begin: -0.5 * getWidth(context),
      end: 15,
    ).animate(
      CurvedAnimation(
        curve: const Interval(
          0.0,
          0.4,
          curve: Curves.fastLinearToSlowEaseIn,
        ),
        // curve: Curves.fastLinearToSlowEaseIn,
        parent: controller,
      ),
    );
    buttonAnimation = Tween<double>(
      begin: -0.5 * getWidth(context),
      end: 0.05 * getWidth(context),
    ).animate(
      CurvedAnimation(
        curve: const Interval(
          0.6,
          1.0,
          curve: Curves.fastLinearToSlowEaseIn,
        ),
        // curve: Curves.fastLinearToSlowEaseIn,
        parent: controller,
      ),
    );

    controller.forward();
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          controller.reset();
          await Future.delayed(const Duration(seconds: 1));
          controller.forward();
        },
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/home.png",
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    Colors.black,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          AnimatedBuilder(
            animation: positionAnimation,
            builder: (context, child) {
              return Positioned(
                bottom: 0.1 * getHeight(context),
                left: positionAnimation.value,
                child: Opacity(
                  opacity: min(controller.value * 2, 1),
                  child: child ?? Container(),
                ),
              );
            },
            child: Text(
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 30,
                color: accentColor,
              ),
              "Mystic Melodies ",
            ),
          ),
          Positioned(
            bottom: 0.075 * getHeight(context),
            left: 15,
            right: 15,
            child: AnimatedBuilder(
                animation: controller,
                builder: (context, child) {
                  return Opacity(
                    opacity: min(controller.value * 2, 1),
                    child: Text(
                      "Experience the timeless melodies of India",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.6),
                        fontSize: 14,
                      ),
                    ),
                  );
                }),
          ),
          AnimatedBuilder(
            animation: buttonAnimation,
            builder: (context, child) {
              return Positioned(
                bottom: 10,
                right: buttonAnimation.value,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 20),
                  opacity: controller.value,
                  child: child ?? Container(),
                ),
              );
            },
            child: ElevatedButton(
              onPressed: () {
                goToPage(context, const HomePage());
              },
              child: const Text("Get started"),
            ),
          ),
        ],
      ),
    );
  }
}
