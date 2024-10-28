///
/// author: Wouter van der wal <wouter.wal@outlook.com>
/// github: https://github.com/wjtje
///

library skeleton_animation;

import 'package:flutter/material.dart';

/// Different animations for the skeleton object
///
/// Default is the pulse animation
enum SkeletonAnimation {
  /// Static color
  none,

  /// Simple fadeing animation
  pulse
}

/// Different styles of the skeleton
enum SkeletonStyle {
  /// A simple box
  box,

  /// A simple circle
  ///
  /// The width and height will be the same
  circle,

  /// A box with rounded corners
  text
}

/// Creates a simple skeleton animation
///
/// If you want the skeleton to look like text, you can use [SkeletonStyle.text]
class Skeleton extends StatefulWidget {
  /// The text color
  final Color? textColor;

  /// The width of the skeleton
  final double width;

  /// The height of the skeleton
  ///
  /// Height is ignored if the [style] is [SkeletonStyle.circle]
  final double height;

  /// The padding of the object
  final double padding;

  /// Choose your style of animaion.
  /// The default is [SkeletonAnimation.pulse]
  final SkeletonAnimation animation;

  /// Change the duration of the animation
  ///
  /// For [SkeletonAnimation.pulse] it is 750 milliseconds
  final Duration? animationDuration;

  /// Choose your look of the skeleton
  /// The default is [SkeletonStyle.box]
  final SkeletonStyle style;

  /// Add a border around the skeleton
  final BoxBorder? border;

  /// Choose a custom border radius
  final BorderRadiusGeometry? borderRadius;

  /// Everything could be null but we recommend changing the height and the style
  ///
  /// If you want to create a text skelelton you can use [SkeletonText]
  Skeleton({
    // Use default colors
    this.textColor,
    // Use default size
    this.width = 200.0,
    this.height = 60.0,
    this.padding = 0,
    // Use the default animation
    this.animation = SkeletonAnimation.pulse,
    this.animationDuration,
    // Use the default style
    this.style = SkeletonStyle.box,
    // Add border support
    this.border,
    this.borderRadius,
  });

  @override
  _SkeletonState createState() => _SkeletonState();
}

class _SkeletonState extends State<Skeleton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    // Create the correct animation
    if (widget.animation == SkeletonAnimation.pulse) {
      // Create the pulse animation
      _controller = AnimationController(
        // Use the correct duration
        duration: widget.animationDuration ?? Duration(milliseconds: 750),
        reverseDuration:
        widget.animationDuration ?? Duration(milliseconds: 750),
        // Default settings
        vsync: this,
        lowerBound: .4,
        upperBound: 1,
      )..addStatusListener((AnimationStatus status) {
        // Create a loop
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _controller.forward();
        }
      });

      // Start the animation
      _controller.forward();
    } else {
      // Create a dummy animation
      _controller = AnimationController(
        vsync: this,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get the correct text color and calculate the correct opcity
    Color _themeTextColor = Theme.of(context).textTheme.bodyLarge!.color!;
    double _themeOpacity =
    Theme.of(context).brightness == Brightness.light ? 0.11 : 0.13;

    // Calculate the correct border radius
    BorderRadiusGeometry _borderRadius = widget.borderRadius ??
            () {
          switch (widget.style) {
          // A circle has have the width (50%) radius
            case SkeletonStyle.circle:
              return BorderRadius.all(Radius.circular(widget.width / 2));
          // Text has 4px radius
            case SkeletonStyle.text:
              return BorderRadius.all(Radius.circular(4));
          // Other styles has no radius
            default:
              return BorderRadius.zero;
          }
        }();

    return Padding(
      padding: EdgeInsets.all(widget.padding),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) => Opacity(
          opacity: (widget.animation == SkeletonAnimation.pulse)
              ? _controller.value
              : 1,
          child: Container(
            // Get the correct with and height
            // If it's a circle the with and height will be the same
            width: widget.width,
            height: (widget.style == SkeletonStyle.circle)
                ? widget.width
                : widget.height,
            decoration: BoxDecoration(
              // Import the border radius
              borderRadius: _borderRadius,
              // Add the border
              border: widget.border,

              // Have the correct text color
              color: widget.textColor ??
                  _themeTextColor.withOpacity(_themeOpacity),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

/// A custom variant of the [Skeleton] made for displaying text
///
/// If you are using a different background or need a border
/// please use the normal [Skeleton] for that
class SkeletonText extends StatelessWidget {
  /// The height of the text
  final double height;

  /// The padding of the object
  final double padding;

  /// It is required that you set the text correcty
  ///
  /// Examples:
  ///
  /// height: 12, padding: 1
  ///
  /// height: 24, padding: 2
  const SkeletonText({
    required this.height,
    this.padding = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Skeleton(
      style: SkeletonStyle.text,
      height: this.height,
      padding: this.padding,
    );
  }
}
