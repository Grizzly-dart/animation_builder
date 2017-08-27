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

  /// Adds a new [Keyframe] to the keyframes
  ///
  /// The [frame] provided is cloned before addition. If a keyframe with offset
  /// already exists, the old one is replaced. Otherwise the keyframe is added
  /// in a sorted order by offset.
  Keyframes add(Keyframe frame) {
    final Keyframe cloned = frame.clone();
    if (frame.offset == null) {
      _keyframes.add(cloned);
    } else {
      int i = 0;
      for (; i < _keyframes.length; i++) {
        final Keyframe kf = _keyframes[i];
        if (kf.offset == null) continue;
        if (kf.offset > frame.offset) {
          _keyframes.insert(i, cloned);
          break;
        }
        if (kf.offset == frame.offset) {
          _keyframes[i] = cloned;
        }
      }
      if (i == _keyframes.length) _keyframes.add(cloned);
    }
    return this;
  }

  /// Appends a new [Keyframe] to the end of keyframes
  ///
  /// The [frame] provided is cloned before addition. If the keyframe has offset
  /// lower than any of the existing keyframes, an [Exception] is thrown.
  Keyframes append(Keyframe frame) {
    final Keyframe cloned = frame.clone();
    if (frame.offset == null) {
      _keyframes.add(cloned);
    } else {
      for (Keyframe kf in _keyframes.reversed) {
        if (kf.offset == null) continue;
        if (kf.offset >= frame.offset)
          throw new Exception('Offset out of order!');
      }
      _keyframes.add(cloned);
    }
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

  Keyframes width(num value(int keyframeIdx, num offset), [String unit = 'px']) {
    for (int i = 0; i < _keyframes.length; i++) {
      final Keyframe kf = _keyframes[i];
      kf.add('width', value(i, kf.offset).toString() + unit);
    }
    return this;
  }

  Keyframes height(num value(int keyframeIdx, num offset), [String unit = 'px']) {
    for (int i = 0; i < _keyframes.length; i++) {
      final Keyframe kf = _keyframes[i];
      kf.add('height', value(i, kf.offset).toString() + unit);
    }
    return this;
  }

  Keyframes margin(num value(int keyframeIdx, num offset), [String unit = 'px']) {
    for (int i = 0; i < _keyframes.length; i++) {
      final Keyframe kf = _keyframes[i];
      kf.add('margin', value(i, kf.offset).toString() + unit);
    }
    return this;
  }

  Keyframes marginV(num value(int keyframeIdx, num offset), [String unit = 'px']) {
    for (int i = 0; i < _keyframes.length; i++) {
      final Keyframe kf = _keyframes[i];
      kf.add('margin', value(i, kf.offset).toString() + unit + ' 0${unit}');
    }
    return this;
  }

  Keyframes marginH(num value(int keyframeIdx, num offset), [String unit = 'px']) {
    for (int i = 0; i < _keyframes.length; i++) {
      final Keyframe kf = _keyframes[i];
      kf.add('margin', '0${unit} ' + value(i, kf.offset).toString() + unit);
    }
    return this;
  }

  Keyframes padding(num value(int keyframeIdx, num offset), [String unit = 'px']) {
    for (int i = 0; i < _keyframes.length; i++) {
      final Keyframe kf = _keyframes[i];
      kf.add('padding', value(i, kf.offset).toString() + unit);
    }
    return this;
  }

  Keyframes paddingV(num value(int keyframeIdx, num offset), [String unit = 'px']) {
    for (int i = 0; i < _keyframes.length; i++) {
      final Keyframe kf = _keyframes[i];
      kf.add('padding', value(i, kf.offset).toString() + unit + ' 0${unit}');
    }
    return this;
  }

  Keyframes paddingH(num value(int keyframeIdx, num offset), [String unit = 'px']) {
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