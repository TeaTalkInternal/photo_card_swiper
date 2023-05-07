import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Shimmer extends StatefulWidget {
  static ShimmerState? of(BuildContext context) {
    return context.findAncestorStateOfType<ShimmerState>();
  }

  const Shimmer({
    Key? key,
    required this.linearGradient,
    this.child,
  }) : super(key: key);

  final LinearGradient linearGradient;
  final Widget? child;

  @override
  ShimmerState createState() => ShimmerState();
}

class ShimmerState extends State<Shimmer> with SingleTickerProviderStateMixin {
  late AnimationController _shimmerController;
  Listenable get shimmerChanges => _shimmerController;

  @override
  void initState() {
    super.initState();

    _shimmerController = AnimationController.unbounded(vsync: this)
      ..repeat(min: -0.5, max: 1.5, period: const Duration(milliseconds: 1000));
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    super.dispose();
  }

  LinearGradient get gradient => LinearGradient(
        colors: widget.linearGradient.colors,
        stops: widget.linearGradient.stops,
        begin: widget.linearGradient.begin,
        end: widget.linearGradient.end,
        transform:
            _SlidingGradientTransform(slidePercent: _shimmerController.value),
      );

  bool get isSized {
    // print("isSized ${context.findRenderObject()}");
    if ((context.findRenderObject() != null)) {
      return (context.findRenderObject() as RenderBox).hasSize;
    }
    return false;
  }

  //bool get isSized => (context.findRenderObject() as RenderBox).hasSize;

  // Size get size => (context.findRenderObject() as RenderBox).size;
  Size get size {
    //  print("size ${context.findRenderObject()}");
    // if ((context.findRenderObject() is RenderShaderMask)) {
    return (context.findRenderObject() as RenderBox).size;
    //}
    //return Size.zero;
  }

  Offset getDescendantOffset({
    required RenderBox descendant,
    Offset offset = Offset.zero,
  }) {
    //  print("getDescendantOffset ${context.findRenderObject()}");

    ///if ((context.findRenderObject() is RenderShaderMask)) {
    ///print("context.findRenderObject() ${context.findRenderObject()}");
    final shimmerBox = context.findRenderObject() as RenderBox;
    return descendant.localToGlobal(offset, ancestor: shimmerBox);
    // }
    //return offset;
  }

  @override
  Widget build(BuildContext context) {
    return widget.child ?? const SizedBox();
  }
}

class _SlidingGradientTransform extends GradientTransform {
  const _SlidingGradientTransform({
    required this.slidePercent,
  });

  final double slidePercent;

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(bounds.width * slidePercent, 0.0, 0.0);
  }
}
