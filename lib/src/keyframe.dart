part of animation_builder.src;

/// Convenience function to create a [Keyframe]
Keyframe keyframe(Map<String, String> properties,
        {double offset, String easing}) =>
    new Keyframe.build(properties, offset: offset, easing: easing);

/// Builds WAAPI keyframe
class Keyframe {
  num _offset;

  double get offset => _offset;

  String easing;

  final Map<String, dynamic> properties = {};

  Keyframe();

  Keyframe.build(Map<String, String> properties, {double offset, this.easing}) {
    setOffset(offset);
    this.properties.addAll(properties);
  }

  static Keyframe at(num offset, [String easing]) => new Keyframe()
    .._offset = offset
    ..easing = easing;

  Keyframe add(String style, dynamic value) {
    properties[style] = value;
    return this;
  }

  Keyframe addAll(Map<String, dynamic> map) {
    properties.addAll(map);
    return this;
  }

  Keyframe setOffset(final double offset) {
    if (_offset != null && (_offset < 0 || _offset > 1))
      throw new Exception('Offset has to be between 0 and 1.');
    this._offset = offset;
    return this;
  }

  Keyframe setEasing(String easing) {
    this.easing = easing;
    return this;
  }

  Keyframe ease() {
    this.easing = 'ease';
    return this;
  }

  Keyframe easeIn() {
    this.easing = 'ease-in';
    return this;
  }

  Keyframe easeOut() {
    this.easing = 'ease-out';
    return this;
  }

  Map<String, dynamic> make() {
    final ret = new Map<String, dynamic>.from(properties);
    if (offset != null) ret['offset'] = offset;
    if (easing != null) ret['easing'] = easing;
    return ret;
  }

  Keyframe clone() {
    return new Keyframe.build(new Map<String, dynamic>.from(properties),
        offset: offset, easing: easing);
  }

  Keyframe backgroundColor(String color) {
    properties['backgroundColor'] = color;
    return this;
  }

  Keyframe color(String color) {
    properties['color'] = color;
    return this;
  }

  Keyframe width(int width, [String unit = 'px']) {
    properties['width'] = '${width}${unit}';
    return this;
  }

  Keyframe height(int height, [String unit = 'px']) {
    properties['height'] = '${height}${unit}';
    return this;
  }

  Keyframe margin(int margin, [String unit = 'px']) {
    properties['margin'] = '${margin}${unit}';
    return this;
  }

  Keyframe marginAll(int top, int right, int bottom, int left,
      [String unit = 'px']) {
    properties['margin'] =
        '${top}${unit} ${right}${unit} ${bottom}${unit} ${left}${unit}';
    return this;
  }

  Keyframe marginV(int v, [String unit = 'px']) {
    properties['margin'] = '${v}${unit} 0${unit}';
    return this;
  }

  Keyframe marginH(int h, [String unit = 'px']) {
    properties['margin'] = '0${unit} ${h}${unit}';
    return this;
  }

  Keyframe padding(int margin, [String unit = 'px']) {
    properties['padding'] = '${margin}${unit}';
    return this;
  }

  Keyframe paddingAll(int top, int right, int bottom, int left,
      [String unit = 'px']) {
    properties['padding'] =
        '${top}${unit} ${right}${unit} ${bottom}${unit} ${left}${unit}';
    return this;
  }

  Keyframe paddingV(int v, [String unit = 'px']) {
    properties['padding'] = '${v}${unit} 0${unit}';
    return this;
  }

  Keyframe paddingH(int h, [String unit = 'px']) {
    properties['padding'] = '0${unit} ${h}${unit}';
    return this;
  }

  Keyframe opacity(num opacity) {
    properties['opacity'] = opacity.toString();
    return this;
  }
}
