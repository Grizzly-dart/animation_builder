// Copyright (c) 2017, teja. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
library animation_builder.src;

import 'dart:collection';

part 'animation_options.dart';
part 'keyframe.dart';
part 'keyframes.dart';

/// Fluent API to build WAAPI animations
class AnimationBuilder {
  final Keyframes keyframes = new Keyframes();

  final AnimationOptions options = new AnimationOptions();

  AnimationBuilder([String id]) {
    options.id = id;
  }

  AnimationBuilder duration(int duration) {
    options.duration = duration;
    return this;
  }

  AnimationBuilder delay(int delay) {
    options.delay = delay;
    return this;
  }

  AnimationBuilder time(int delay, int duration) {
    options.delay = delay;
    options.duration = duration;
    return this;
  }

  AnimationBuilder iterations(int iterations) {
    options.iterations = iterations;
    return this;
  }

  AnimationBuilder infiniteIterations() {
    options.iterations = null;
    return this;
  }

  AnimationBuilder runReverse() {
    options.direction = 'backwards';
    return this;
  }

  AnimationBuilder runAlternate() {
    options.direction = 'alternate';
    return this;
  }

  AnimationBuilder runAlternateReverse() {
    options.direction = 'alternate-reverse';
    return this;
  }

  AnimationBuilder setEasing(String easing) {
    options.easing = easing;
    return this;
  }

  AnimationBuilder ease() {
    options.easing = 'ease';
    return this;
  }

  AnimationBuilder easeIn() {
    options.easing = 'ease-in';
    return this;
  }

  AnimationBuilder easeOut() {
    options.easing = 'ease-out';
    return this;
  }

  AnimationBuilder fillBackwards() {
    options.fill = 'backwards';
    return this;
  }

  AnimationBuilder fillForwards() {
    options.fill = 'forwards';
    return this;
  }

  AnimationBuilder add(Keyframe frame) {
    keyframes.add(frame);
    return this;
  }

  AnimationBuilder append(Keyframe frame) {
    keyframes.append(frame);
    return this;
  }

  AnimationBuilder addAt(double offset, Keyframe frame) {
    keyframes.addAt(offset, frame);
    return this;
  }

  AnimationBuilder addStyle(
      String name, dynamic value(int keyframeIdx, num offset)) {
    keyframes.addStyle(name, value);
    return this;
  }

  List<Map<String, dynamic>> makeKeyframes() => keyframes.make();

  Map<String, dynamic> makeOptions() => options.make();
}
