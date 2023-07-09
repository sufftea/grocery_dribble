import 'package:flutter/cupertino.dart';
import 'package:flutter/physics.dart';
import 'package:grocery_dribble/utils/utils.dart';

class SnappingScrollPhysics extends ScrollPhysics {
  const SnappingScrollPhysics({super.parent});

  @override
  SnappingScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return SnappingScrollPhysics(parent: ancestor);
  }

  @override
  Simulation? createBallisticSimulation(
    ScrollMetrics position,
    double velocity,
  ) {
    // Scenario 1:
    // If we're out of range and not headed back in range, defer to the parent
    // ballistics, which should put us back in range at the scrollable's boundary.
    if ((velocity <= 0.0 && position.pixels <= position.minScrollExtent) ||
        (velocity >= 0.0 && position.pixels >= position.maxScrollExtent)) {
      return super.createBallisticSimulation(position, velocity);
    }

    // Create a test simulation to see where it would have ballistically fallen
    // naturally without settling onto items.
    final Simulation? testFrictionSimulation =
        super.createBallisticSimulation(position, velocity);

    final landingOffset =
        testFrictionSimulation?.x(double.infinity) ?? position.pixels;

    final double settlingPixels = _calculateSettlingPixels(
      landingOffset,
      position.viewportDimension,
    );

    if (velocity.abs() < toleranceFor(position).velocity &&
        (settlingPixels - position.pixels).abs() <
            toleranceFor(position).distance) {
      return null;
    }

    if (settlingPixels ==
        _calculateSettlingPixels(
          position.pixels,
          position.viewportDimension,
        )) {
      return SpringSimulation(
        spring,
        position.pixels,
        settlingPixels,
        velocity,
        tolerance: toleranceFor(position),
      );
    }

    return SpringSimulation(
      spring,
      position.pixels,
      settlingPixels,
      velocity,
      tolerance: toleranceFor(position),
    );
  }

  double _calculateSettlingPixels(double landingPixels, double maxPixels) {
    return landingPixels < maxPixels / 2 - Utils.collapsedHeight
        ? 0
        : maxPixels - 2 * Utils.collapsedHeight;
  }
}
