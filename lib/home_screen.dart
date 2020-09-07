import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'constants.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> animation;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        curve: Curves.easeInOutCirc,
        // curve: Curves.linear,
        parent: animationController,
      ),
    );

    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void toggleAnimation() {
    if (animationController.status == AnimationStatus.completed) {
      animationController.reverse();
    } else {
      animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: toggleAnimation,
      ),
      body: ListenableProvider.value(
        value: animation,
        child: Stack(
          children: [
            const _TopText(),
            _DesertContainer(),
            _SquareButton(),
            _VerticalDots(),
            _ArrowLines(),
            _IconRow(),
          ],
        ),
      ),
    );
  }
}

class _TopText extends StatelessWidget {
  const _TopText({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<Animation<double>>(
      builder: (context, animation, child) {
        return Positioned(
          top: 50.0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'The three largest \ndeserts in the world',
                  style: TextStyle(
                    fontSize: 30.0 - 5.0 * animation.value,
                    color: kBlackColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child
              ],
            ),
          ),
        );
      },
      child: Row(
        children: [
          const Icon(
            Icons.filter_hdr,
            color: kPinkColor,
          ),
          const SizedBox(width: 10.0),
          const Text(
            'Popular',
            style: TextStyle(
              fontSize: 16.0,
              color: kPinkColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _DesertContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Consumer<Animation<double>>(
      builder: (context, animation, child) {
        return Positioned(
          left: 25.0 + 60.0 * animation.value,
          top: 180 - 20 * animation.value,
          right: 40 * (1 - animation.value),
          child: Container(
            padding: const EdgeInsets.all(5.0),
            height: 90.0 + (screenSize.height * .35 * animation.value),
            alignment: Alignment.bottomLeft,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/desert3.jpg'),
              ),
            ),
            child: const Text(
              'Sahara',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
          ),
        );
      },
    );
  }
}

class _SquareButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<Animation<double>>(
      builder: (context, animation, child) {
        return Positioned(
          top: 210 - 80.0 * animation.value,
          right: 20,
          child: Stack(
            children: [
              Transform.translate(
                offset: Offset(-10 * (1 - animation.value), -10 * (1 - animation.value)),
                child: Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(.4),
                  ),
                ),
              ),
              Container(
                height: 80,
                width: 80,
                decoration: const BoxDecoration(
                  color: Colors.black,
                ),
                child: IconButton(
                  icon: const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 35,
                  ),
                  onPressed: () {},
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class _VerticalDots extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<Animation<double>>(
      builder: (context, animation, child) {
        return Positioned(
          top: 280,
          left: 25.0,
          child: FadeTransition(
            opacity: animation,
            child: Column(
              children: [
                _buildCircle(selected: true),
                SizedBox(height: 5 + 15.0 * animation.value),
                _buildCircle(),
                SizedBox(height: 5 + 15.0 * animation.value),
                _buildCircle(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCircle({bool selected = false}) {
    return Container(
      padding: const EdgeInsets.all(5.0),
      height: 20.0,
      width: 20.0,
      decoration: selected
          ? BoxDecoration(
              border: Border.all(
                color: Colors.grey,
              ),
              shape: BoxShape.circle,
            )
          : null,
      child: CircleAvatar(
        radius: 1,
        backgroundColor: Colors.grey.withOpacity(.8),
      ),
    );
  }
}

class _ArrowLines extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<Animation<double>>(
      builder: (context, animation, child) {
        return Positioned(
          top: 510.0,
          left: 85,
          child: FadeTransition(
            opacity: animation,
            child: Container(
              width: 150,
              height: 2,
              child: Row(
                children: [
                  SizedBox(
                    width: 60 - 60 * animation.value,
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.black.withOpacity(.7),
                    ),
                  ),
                  const SizedBox(width: 30),
                  Expanded(
                    child: Container(
                      color: Colors.black.withOpacity(.7),
                    ),
                  ),
                  SizedBox(
                    width: 60 - 60 * animation.value,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _IconRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<Animation<double>>(
      builder: (context, animation, child) {
        return Positioned(
          top: 600,
          left: 85,
          child: Row(
            children: [
              _IconAnimatedScale(
                intervalStart: 0.2,
                intervalEnd: 1,
              ),
              const SizedBox(width: 20.0),
              _IconAnimatedScale(
                icon: Icons.ac_unit,
                intervalStart: 0.5,
                intervalEnd: 1,
              ),
              const SizedBox(width: 20.0),
              _IconAnimatedScale(
                icon: Icons.accessibility_new,
                intervalStart: 0.7,
                intervalEnd: 1,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _IconAnimatedScale extends StatelessWidget {
  final IconData icon;
  final double intervalStart;
  final double intervalEnd;
  _IconAnimatedScale({
    Key key,
    this.icon,
    @required this.intervalStart,
    @required this.intervalEnd,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: context.watch<Animation<double>>(),
          curve: Interval(
            intervalStart,
            intervalEnd,
            curve: Curves.easeInOutBack,
          ),
        ),
      ),
      child: Icon(
        icon ?? Icons.map,
        color: Colors.black.withOpacity(.6),
        size: 30,
      ),
    );
  }
}
