import 'package:flutter/cupertino.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class StaggeredScaleListAnimation extends StatelessWidget {
  const StaggeredScaleListAnimation(
      {super.key, required this.positionIndex, required this.child});
  final int positionIndex;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: AnimationConfiguration.staggeredList(
        position: positionIndex,
        child: ScaleAnimation(
            duration: const Duration(milliseconds: 350), child: child),
      ),
    );
  }
}
