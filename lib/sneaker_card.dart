import 'package:flutter/material.dart';

class SneakerCard extends StatefulWidget {
  final String index;
  final String title;
  final String price;
  final Color color;
  final String image;
  final Function(String) onDragStarted;
  final Function(String) onDragEnd;

  const SneakerCard({
    super.key,
    required this.index,
    required this.title,
    required this.price,
    required this.color,
    required this.image,
    required this.onDragStarted,
    required this.onDragEnd,
  });

  @override
  State<SneakerCard> createState() => _SneakerCardState();
}

class _SneakerCardState extends State<SneakerCard> {
  double _rotateX = 0;
  double _rotateY = 0;

  void _onHover(PointerEvent event, Size size) {
    final dx = (event.localPosition.dx - size.width / 2) / (size.width / 2);
    final dy = (event.localPosition.dy - size.height / 2) / (size.height / 2);

    setState(() {
      _rotateY = dx * 0.3;
      _rotateX = -dy * 0.3;
    });
  }

  void _onExit(PointerEvent event) {
    setState(() {
      _rotateX = 0;
      _rotateY = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Draggable<String>(
      onDragStarted: () {
        widget.onDragStarted(widget.index);
      },
      onDragEnd: (details) {
        widget.onDragEnd(widget.index);
      },
      feedback: SizedBox(
        width: 300,
        height: 400,
        child: Image.asset(widget.image, height: 150),
      ),
      childWhenDragging: SizedBox.shrink(),
      child: SizedBox(
        width: 300,
        height: 400,
        child: MouseRegion(
          onHover: (event) => _onHover(event, const Size(300, 400)),
          onExit: _onExit,
          child: Stack(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                transform:
                    Matrix4.identity()
                      ..setEntry(3, 2, 0.003)
                      ..rotateX(_rotateX)
                      ..rotateY(_rotateY),
                curve: Curves.easeOut,
                width: 300,
                height: 400,
                alignment: Alignment.bottomLeft,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: widget.color,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black38,
                      blurRadius: 25,
                      offset: Offset(10, 20),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      widget.index,
                      style: const TextStyle(
                        fontSize: 28,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'SNEAKERS',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.price,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    SizedBox.shrink(),
                    const Spacer(),
                    Text(
                      widget.title,
                      style: const TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 300,
                height: 400,
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(),
                    Center(child: Image.asset(widget.image, height: 150)),
                    const Spacer(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
