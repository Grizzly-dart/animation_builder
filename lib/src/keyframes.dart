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
    _append(frame);
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

  Keyframes width(num value(int keyframeIdx, num offset),
      [String unit = 'px']) {
    for (int i = 0; i < _keyframes.length; i++) {
      final Keyframe kf = _keyframes[i];
      kf.add('width', value(i, kf.offset).toString() + unit);
    }
    return this;
  }

  Keyframes height(num value(int keyframeIdx, num offset),
      [String unit = 'px']) {
    for (int i = 0; i < _keyframes.length; i++) {
      final Keyframe kf = _keyframes[i];
      kf.add('height', value(i, kf.offset).toString() + unit);
    }
    return this;
  }

  Keyframes margin(num value(int keyframeIdx, num offset),
      [String unit = 'px']) {
    for (int i = 0; i < _keyframes.length; i++) {
      final Keyframe kf = _keyframes[i];
      kf.add('margin', value(i, kf.offset).toString() + unit);
    }
    return this;
  }

  Keyframes marginV(num value(int keyframeIdx, num offset),
      [String unit = 'px']) {
    for (int i = 0; i < _keyframes.length; i++) {
      final Keyframe kf = _keyframes[i];
      kf.add('margin', value(i, kf.offset).toString() + unit + ' 0${unit}');
    }
    return this;
  }

  Keyframes marginH(num value(int keyframeIdx, num offset),
      [String unit = 'px']) {
    for (int i = 0; i < _keyframes.length; i++) {
      final Keyframe kf = _keyframes[i];
      kf.add('margin', '0${unit} ' + value(i, kf.offset).toString() + unit);
    }
    return this;
  }

  Keyframes padding(num value(int keyframeIdx, num offset),
      [String unit = 'px']) {
    for (int i = 0; i < _keyframes.length; i++) {
      final Keyframe kf = _keyframes[i];
      kf.add('padding', value(i, kf.offset).toString() + unit);
    }
    return this;
  }

  Keyframes paddingV(num value(int keyframeIdx, num offset),
      [String unit = 'px']) {
    for (int i = 0; i < _keyframes.length; i++) {
      final Keyframe kf = _keyframes[i];
      kf.add('padding', value(i, kf.offset).toString() + unit + ' 0${unit}');
    }
    return this;
  }

  Keyframes paddingH(num value(int keyframeIdx, num offset),
      [String unit = 'px']) {
    for (int i = 0; i < _keyframes.length; i++) {
      final Keyframe kf = _keyframes[i];
      kf.add('padding', '0${unit} ' + value(i, kf.offset).toString() + unit);
    }
    return this;
  }

  Keyframes opacity(num value(int keyframeIdx, num offset)) {
    for (int i = 0; i < _keyframes.length; i++) {
      final Keyframe kf = _keyframes[i];
      kf.add('opacity', value(i, kf.offset).toString());
    }
    return this;
  }
}
