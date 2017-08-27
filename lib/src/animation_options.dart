part of animation_builder.src;

/// Builds WAAPI timing options
class AnimationOptions {
  String id;

  int delay = 0;

  String direction = 'normal';

  int duration = 0;

  String easing = 'linear';

  int endDelay = 0;

  String fill = 'none';

  double iterationStart = 0.0;

  int iterations = 1;

  AnimationOptions runReverse() {
    direction = 'backwards';
    return this;
  }

  AnimationOptions runAlternate() {
    direction = 'alternate';
    return this;
  }

  AnimationOptions runAlternateReverse() {
    direction = 'alternate-reverse';
    return this;
  }

  AnimationOptions setEasing(String easing) {
    this.easing = easing;
    return this;
  }

  AnimationOptions ease() {
    this.easing = 'ease';
    return this;
  }

  AnimationOptions easeIn() {
    this.easing = 'ease-in';
    return this;
  }

  AnimationOptions easeOut() {
    this.easing = 'ease-out';
    return this;
  }

  AnimationOptions fillBackwards() {
    fill = 'backwards';
    return this;
  }

  AnimationOptions fillForwards() {
    fill = 'forwards';
    return this;
  }

  Map<String, dynamic> make() {
    final ret = <String, dynamic>{};
    if (id != null) ret['id'] = id;
    if (delay != 0) ret['delay'] = delay;
    if (direction != 'normal') ret['direction'] = direction;
    if (duration != 0) ret['duration'] = duration;
    if (easing != 'linear') ret['easing'] = easing;
    if (endDelay != 0) ret['endDelay'] = endDelay;
    if (fill != 'none') ret['fill'] = fill;
    if (iterationStart != 0) ret['iterationStart'] = iterationStart;
    if (iterations != 1)
      ret['iterations'] = iterations != null ? iterations : double.INFINITY;
    return ret;
  }
}
