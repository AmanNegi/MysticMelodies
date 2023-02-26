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
  late AnimationController startAnimationController;
  late AnimationController endAnimationController;
  late Animation positionAnimation;
  late Animation buttonAnimation;

  _setupAnimations() {
    // Setting up controllers
    startAnimationController = useAnimationController(
      duration: const Duration(seconds: 2),
    );

    endAnimationController = useAnimationController(
      duration: const Duration(seconds: 4),
    );

    // Setting up animations for starting
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
        parent: startAnimationController,
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
        parent: startAnimationController,
      ),
    );

    // Setting up animations for ending
  }

  @override
  Widget build(BuildContext context) {
    _setupAnimations();
    startAnimationController.forward();
    return Scaffold(
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
                bottom: 0.125 * getHeight(context),
                left: positionAnimation.value,
                child: Opacity(
                  opacity: min(startAnimationController.value * 2, 1),
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
            bottom: 0.1 * getHeight(context),
            left: 15,
            right: 15,
            child: AnimatedBuilder(
                animation: startAnimationController,
                builder: (context, child) {
                  return Opacity(
                    opacity: min(startAnimationController.value * 2, 1),
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
                bottom: 15,
                right: buttonAnimation.value,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 20),
                  opacity: startAnimationController.value,
                  child: child ?? Container(),
                ),
              );
            },
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(accentColor)),
              onPressed: () async {
                await startAnimationController.reverse();
                // await Future.delayed(const Duration(seconds: 1));
                Navigator.push(context, FadeRoute(page: const HomePage()));
                // goToPage(context, const HomePage());
              },
              child: const Text(
                "Get started",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FadeRoute extends PageRouteBuilder {
  final Widget page;
  FadeRoute({required this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,

          transitionDuration: const Duration(seconds: 1),
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
}
