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

  /// Adds a new [Keyframe] to the keyframes
  ///
  /// The [frame] provided is cloned before addition. If a keyframe with offset
  /// already exists, the old one is replaced. Otherwise the keyframe is added
  AnimationBuilder add(Keyframe frame) {
    keyframes.add(frame);
    return this;
  }

  /// Appends a new [Keyframe] to the end of keyframes
  ///
  /// The [frame] provided is cloned before addition. If the keyframe has offset
  /// lower than any of the existing keyframes, an [Exception] is thrown.
  /// [append] is efficient than [add]
  AnimationBuilder append(Keyframe frame) {
    keyframes.append(frame);
    return this;
  }

  /// Adds a provided at specified [offset]
  ///
  /// The [frame] provided is cloned before addition. If a keyframe with offset
  /// already exists, the old one is replaced. Otherwise the keyframe is added
  /// in a sorted order by offset.
  AnimationBuilder addAt(double offset, Keyframe frame) {
    keyframes.addAt(offset, frame);
    return this;
  }

  /// Creates a new [Keyframe] from [properties], [offset], [easing] and adds it
  /// to the keyframes
  AnimationBuilder create(Map<String, String> properties,
      {double offset, String easing}) {
    keyframes.create(properties, offset: offset, easing: easing);
    return this;
  }

  /// Creates a new [Keyframe] from [properties], [offset], [easing] and appends
  /// it to the keyframes
  AnimationBuilder createAppend(Map<String, String> properties,
      {double offset, String easing}) {
    keyframes.createAppend(properties, offset: offset, easing: easing);
    return this;
  }

  /// Creates a new [Keyframe] from [offset], [easing] and adds it to the keyframes
  ///
  /// Returns the newly creates [Keyframe]. Useful with Dart's cascade operator
  Keyframe createAt(double offset, [String easing]) {
    return keyframes.createAt(offset, easing);
  }

  /// Creates a new [Keyframe] from [offset], [easing] and appends it to the
  /// keyframes
  ///
  /// Returns the newly creates [Keyframe]. Useful with Dart's cascade operator.
  /// [createAppendAt] is efficient than [createAt]
  Keyframe createAppendAt(double offset, [String easing]) {
    return keyframes.createAppendAt(offset, easing);
  }

  /// Adds style to all keyframes. The value is computed by the [value] function.
  AnimationBuilder addStyle(
      String name, dynamic value(int keyframeIdx, num offset)) {
    keyframes.addStyle(name, value);
    return this;
  }

  List<Map<String, dynamic>> makeKeyframes() => keyframes.make();

  Map<String, dynamic> makeOptions() => options.make();
}
