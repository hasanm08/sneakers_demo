import 'package:flutter/material.dart';
import 'package:tour_leader/sneaker_card.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  double data = 0;

  double iconHeight = 50;
  double iconWidth = 50;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sneaker Card',
      home: Scaffold(
        backgroundColor: Color(0xFF1E1E2F),
        body: Center(
          child: Column(
            children: [
              const Spacer(),
              Expanded(
                flex: 3,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  children: [
                    SneakerCard(
                      index: '01',
                      title: 'Nike Blue',
                      price: '\$39.9',
                      color: Colors.lightBlue,
                      image: 'assets/nike-blue.png',
                      onDragStarted: (index) {
                        setState(() {
                          iconHeight = 200;
                          iconWidth = 200;
                        });
                      },
                      onDragEnd: (index) {
                        setState(() {
                          iconHeight = 50;
                          iconWidth = 50;
                          data++;
                        });
                      },
                    ),
                    const SizedBox(width: 30),
                    SneakerCard(
                      index: '02',
                      title: 'Nike Purple',
                      price: '\$49.9',
                      color: Colors.deepPurpleAccent,
                      image: 'assets/nike-purple.png',
                      onDragStarted: (index) {
                        setState(() {
                          iconHeight = 200;
                          iconWidth = 200;
                        });
                      },
                      onDragEnd: (index) {
                        setState(() {
                          iconHeight = 50;
                          iconWidth = 50;
                          data++;
                        });
                      },
                    ),
                  ],
                ),
              ),
              const Spacer(),
              data > 0
                  ? Badge(
                    label: Text(data.toString()),
                    child: shoppingBasketIcon(),
                  )
                  : shoppingBasketIcon(),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget shoppingBasketIcon() {
    return DragTarget<String>(
      onWillAcceptWithDetails: (details) {
        setState(() {
          iconHeight = 100;
          iconWidth = 100;
        });
        return true;
      },

      onAcceptWithDetails: (details) {
        setState(() {
          data++;
        });
      },
      builder: (context, candidateData, rejectedData) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: iconHeight,
          width: iconWidth,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(Icons.shopping_basket_outlined),
        );
      },
    );
  }
}
