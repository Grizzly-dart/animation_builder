part of animation_builder.src;

/// Builds WAAPI keyframes
class Keyframes {
  final List<Keyframe> _keyframes = [];

  UnmodifiableListView<Keyframe> _keyframesUM;

  /// Unmodifiable view of keyframes
  UnmodifiableListView<Keyframe> get keyframes => _keyframesUM;

  Keyframes() {
    _keyframesUM = new UnmodifiableListView<Keyframe>(_keyframes);
  }

  void _add(Keyframe frame) {
    if (frame.offset == null) {
      _keyframes.add(frame);
    } else {
      int i = 0;
      for (; i < _keyframes.length; i++) {
        final Keyframe kf = _keyframes[i];
        if (kf.offset == null) continue;
        if (kf.offset > frame.offset) {
          _keyframes.insert(i, frame);
          break;
        }
        if (kf.offset == frame.offset) {
          _keyframes[i] = frame;
        }
      }
      if (i == _keyframes.length) _keyframes.add(frame);
    }
  }

  void _append(Keyframe frame) {
    if (frame.offset == null) {
      _keyframes.add(frame);
    } else {
      for (Keyframe kf in _keyframes.reversed) {
        if (kf.offset == null) continue;
        if (kf.offset >= frame.offset)
          throw new Exception('Offset out of order!');
      }
      _keyframes.add(frame);
    }
  }

  /// Adds a new [Keyframe] to the keyframes
  ///
  /// The [frame] provided is cloned before addition. If a keyframe with offset
  /// already exists, the old one is replaced. Otherwise the keyframe is added
  /// in a sorted order by offset.
  Keyframes add(Keyframe frame) {
    final Keyframe cloned = frame.clone();
    _add(cloned);
    return this;
  }

  /// Appends a new [Keyframe] to the end of keyframes
  ///
  /// The [frame] provided is cloned before addition. If the keyframe has offset
  /// lower than any of the existing keyframes, an [Exception] is thrown.
  /// [append] is efficient than [add]
  Keyframes append(Keyframe frame) {
    final Keyframe cloned = frame.clone();
    _append(cloned);
    return this;
  }

  /// Adds a provided at specified [offset]
  ///
  /// The [frame] provided is cloned before addition. If a keyframe with offset
  /// already exists, the old one is replaced. Otherwise the keyframe is added
  /// in a sorted order by offset.
  Keyframes addAt(double offset, Keyframe frame) {
    final Keyframe kf = frame.clone().setOffset(offset);
    return add(kf);
  }

  /// Creates a new [Keyframe] from [properties], [offset], [easing] and adds it
  /// to the keyframes
  Keyframes create(Map<String, String> properties,
      {double offset, String easing}) {
    final Keyframe kf =
        new Keyframe.build(properties, offset: offset, easing: easing);
    _add(kf);
    return this;
  }

  /// Creates a new [Keyframe] from [properties], [offset], [easing] and appends
  /// it to the keyframes
  Keyframes createAppend(Map<String, String> properties,
      {double offset, String easing}) {
    final Keyframe kf =
        new Keyframe.build(properties, offset: offset, easing: easing);
    _append(kf);
    return this;
  }

  /// Creates a new [Keyframe] from [offset], [easing] and adds it to the keyframes
  ///
  /// Returns the newly creates [Keyframe]. Useful with Dart's cascade operator
  Keyframe createAt(double offset, [String easing]) {
    final Keyframe kf = Keyframe.at(offset, easing);
    _add(kf);
    return kf;
  }

  /// Creates a new [Keyframe] from [offset], [easing] and appends it to the
  /// keyframes
  ///
  /// Returns the newly creates [Keyframe]. Useful with Dart's cascade operator.
  /// [createAppendAt] is efficient than [createAt]
  Keyframe createAppendAt(double offset, [String easing]) {
    final Keyframe kf = Keyframe.at(offset, easing);
    _append(kf);
    return kf;
  }

  /// Adds style to all keyframes. The value is computed by the [value] function.
  Keyframes addStyle(String name, dynamic value(int keyframeIdx, num offset)) {
    for (int i = 0; i < _keyframes.length; i++) {
      final Keyframe kf = _keyframes[i];
      kf.add(name, value(i, kf.offset));
    }
    return this;
  }

  /// Returns value that can be used with Element.animate
  List<Map<String, dynamic>> make() =>
      _keyframes.map((Keyframe kf) => kf.make()).toList();

  Keyframes backgroundColor(String value(int keyframeIdx, num offset)) {
    for (int i = 0; i < _keyframes.length; i++) {
      final Keyframe kf = _keyframes[i];
      kf.backgroundColor(value(i, kf.offset));
    }
    return this;
  }

  Keyframes color(String value(int keyframeIdx, num offset)) {
    for (int i = 0; i < _keyframes.length; i++) {
      final Keyframe kf = _keyframes[i];
      kf.color(value(i, kf.offset));
    }
    return this;
  }

  Keyframes width(num value(int keyframeIdx, num offset),
      [String unit = 'px']) {
    for (int i = 0; i < _keyframes.length; i++) {
      final Keyframe kf = _keyframes[i];
      kf.width(value(i, kf.offset), unit);
    }
    return this;
  }

  Keyframes height(num value(int keyframeIdx, num offset),
      [String unit = 'px']) {
    for (int i = 0; i < _keyframes.length; i++) {
      final Keyframe kf = _keyframes[i];
      kf.height(value(i, kf.offset), unit);
    }
    return this;
  }

  Keyframes left(num value(int keyframeIdx, num offset), [String unit = 'px']) {
    for (int i = 0; i < _keyframes.length; i++) {
      final Keyframe kf = _keyframes[i];
      kf.left(value(i, kf.offset), unit);
    }
    return this;
  }

  Keyframes top(num value(int keyframeIdx, num offset), [String unit = 'px']) {
    for (int i = 0; i < _keyframes.length; i++) {
      final Keyframe kf = _keyframes[i];
      kf.top(value(i, kf.offset), unit);
    }
    return this;
  }

  Keyframes margin(num value(int keyframeIdx, num offset),
      [String unit = 'px']) {
    for (int i = 0; i < _keyframes.length; i++) {
      final Keyframe kf = _keyframes[i];
      kf.margin(value(i, kf.offset), unit);
    }
    return this;
  }

  Keyframes marginV(num value(int keyframeIdx, num offset),
      [String unit = 'px']) {
    for (int i = 0; i < _keyframes.length; i++) {
      final Keyframe kf = _keyframes[i];
      kf.marginV(value(i, kf.offset), unit);
    }
    return this;
  }

  Keyframes marginH(num value(int keyframeIdx, num offset),
      [String unit = 'px']) {
    for (int i = 0; i < _keyframes.length; i++) {
      final Keyframe kf = _keyframes[i];
      kf.marginH(value(i, kf.offset), unit);
    }
    return this;
  }

  Keyframes padding(num value(int keyframeIdx, num offset),
      [String unit = 'px']) {
    for (int i = 0; i < _keyframes.length; i++) {
      final Keyframe kf = _keyframes[i];
      kf.padding(value(i, kf.offset), unit);
    }
    return this;
  }

  Keyframes paddingV(num value(int keyframeIdx, num offset),
      [String unit = 'px']) {
    for (int i = 0; i < _keyframes.length; i++) {
      final Keyframe kf = _keyframes[i];
      kf.paddingV(value(i, kf.offset), unit);
    }
    return this;
  }

  Keyframes paddingH(num value(int keyframeIdx, num offset),
      [String unit = 'px']) {
    for (int i = 0; i < _keyframes.length; i++) {
      final Keyframe kf = _keyframes[i];
      kf.paddingH(value(i, kf.offset), unit);
    }
    return this;
  }

  Keyframes opacity(num value(int keyframeIdx, num offset)) {
    for (int i = 0; i < _keyframes.length; i++) {
      final Keyframe kf = _keyframes[i];
      kf.opacity(value(i, kf.offset));
    }
    return this;
  }

  Keyframes translate(Point<num> value(int keyframeIdx, num offset),
      [String unit = 'px']) {
    for (int i = 0; i < _keyframes.length; i++) {
      final Keyframe kf = _keyframes[i];
      final Point<num> v = value(i, kf.offset);
      kf.translate(v.x, v.y, unit);
    }
    return this;
  }

  Keyframes translate3D(Point3D value(int keyframeIdx, num offset),
      [String unit = 'px']) {
    for (int i = 0; i < _keyframes.length; i++) {
      final Keyframe kf = _keyframes[i];
      final Point3D v = value(i, kf.offset);
      kf.translate3D(v.x, v.y, v.z, unit);
    }
    return this;
  }

  Keyframes translateX(num value(int keyframeIdx, num offset),
      [String unit = 'px']) {
    for (int i = 0; i < _keyframes.length; i++) {
      final Keyframe kf = _keyframes[i];
      kf.translateX(value(i, kf.offset), unit);
    }
    return this;
  }

  Keyframes translateY(num value(int keyframeIdx, num offset),
      [String unit = 'px']) {
    for (int i = 0; i < _keyframes.length; i++) {
      final Keyframe kf = _keyframes[i];
      kf.translateY(value(i, kf.offset), unit);
    }
    return this;
  }

  Keyframes translateZ(num value(int keyframeIdx, num offset),
      [String unit = 'px']) {
    for (int i = 0; i < _keyframes.length; i++) {
      final Keyframe kf = _keyframes[i];
      kf.translateZ(value(i, kf.offset), unit);
    }
    return this;
  }

  Keyframes scale(Point<num> value(int keyframeIdx, num offset),
      [String unit = 'px']) {
    for (int i = 0; i < _keyframes.length; i++) {
      final Keyframe kf = _keyframes[i];
      final Point<num> v = value(i, kf.offset);
      kf.scale(v.x, v.y, unit);
    }
    return this;
  }

  Keyframes scale3D(Point3D value(int keyframeIdx, num offset),
      [String unit = 'px']) {
    for (int i = 0; i < _keyframes.length; i++) {
      final Keyframe kf = _keyframes[i];
      final Point3D v = value(i, kf.offset);
      kf.scale3D(v.x, v.y, v.z, unit);
    }
    return this;
  }

  Keyframes scaleX(num value(int keyframeIdx, num offset),
      [String unit = 'px']) {
    for (int i = 0; i < _keyframes.length; i++) {
      final Keyframe kf = _keyframes[i];
      kf.scaleX(value(i, kf.offset), unit);
    }
    return this;
  }

  Keyframes scaleY(num value(int keyframeIdx, num offset),
      [String unit = 'px']) {
    for (int i = 0; i < _keyframes.length; i++) {
      final Keyframe kf = _keyframes[i];
      kf.scaleY(value(i, kf.offset), unit);
    }
    return this;
  }

  Keyframes scaleZ(num value(int keyframeIdx, num offset),
      [String unit = 'px']) {
    for (int i = 0; i < _keyframes.length; i++) {
      final Keyframe kf = _keyframes[i];
      kf.scaleZ(value(i, kf.offset), unit);
    }
    return this;
  }

  Keyframes rotate(Point<num> value(int keyframeIdx, num offset),
      [String unit = 'deg']) {
    for (int i = 0; i < _keyframes.length; i++) {
      final Keyframe kf = _keyframes[i];
      final Point<num> v = value(i, kf.offset);
      kf.rotate(v.x, v.y, unit);
    }
    return this;
  }

  Keyframes rotate3D(Point3D value(int keyframeIdx, num offset),
      [String unit = 'deg']) {
    for (int i = 0; i < _keyframes.length; i++) {
      final Keyframe kf = _keyframes[i];
      final Point3D v = value(i, kf.offset);
      kf.rotate3D(v.x, v.y, v.z, unit);
    }
    return this;
  }

  Keyframes rotateX(num value(int keyframeIdx, num offset),
      [String unit = 'deg']) {
    for (int i = 0; i < _keyframes.length; i++) {
      final Keyframe kf = _keyframes[i];
      kf.rotateX(value(i, kf.offset), unit);
    }
    return this;
  }

  Keyframes rotateY(num value(int keyframeIdx, num offset),
      [String unit = 'deg']) {
    for (int i = 0; i < _keyframes.length; i++) {
      final Keyframe kf = _keyframes[i];
      kf.rotateY(value(i, kf.offset), unit);
    }
    return this;
  }

  Keyframes rotateZ(num value(int keyframeIdx, num offset),
      [String unit = 'deg']) {
    for (int i = 0; i < _keyframes.length; i++) {
      final Keyframe kf = _keyframes[i];
      kf.rotateZ(value(i, kf.offset), unit);
    }
    return this;
  }

  Keyframes skew(Point<num> value(int keyframeIdx, num offset),
      [String unit = 'deg']) {
    for (int i = 0; i < _keyframes.length; i++) {
      final Keyframe kf = _keyframes[i];
      final Point<num> v = value(i, kf.offset);
      kf.skew(v.x, v.y, unit);
    }
    return this;
  }

  Keyframes skewX(num value(int keyframeIdx, num offset),
      [String unit = 'deg']) {
    for (int i = 0; i < _keyframes.length; i++) {
      final Keyframe kf = _keyframes[i];
      kf.skewX(value(i, kf.offset), unit);
    }
    return this;
  }

  Keyframes skewY(num value(int keyframeIdx, num offset),
      [String unit = 'deg']) {
    for (int i = 0; i < _keyframes.length; i++) {
      final Keyframe kf = _keyframes[i];
      kf.skewY(value(i, kf.offset), unit);
    }
    return this;
  }

  Keyframes perspective(num value(int keyframeIdx, num offset),
      [String unit = 'px']) {
    for (int i = 0; i < _keyframes.length; i++) {
      final Keyframe kf = _keyframes[i];
      kf.perspective(value(i, kf.offset), unit);
    }
    return this;
  }
}

/// Encapsulates a 3D point
class Point3D {
  /// x-coordinate
  num x;

  /// y-coordinate
  num y;

  /// z-coordinate
  num z;

  Point3D(this.x, this.y, this.z);
}
