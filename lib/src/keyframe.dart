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

  final Map<String, dynamic> _properties = {};

  Keyframe();

  Keyframe.build(Map<String, String> properties, {double offset, this.easing}) {
    setOffset(offset);
    this._properties.addAll(properties);
  }

  static Keyframe at(num offset, [String easing]) => new Keyframe()
    .._offset = offset
    ..easing = easing;

  Keyframe add(String style, dynamic value) {
    _properties[style] = value;
    return this;
  }

  Keyframe addAll(Map<String, dynamic> map) {
    _properties.addAll(map);
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
    final ret = new Map<String, dynamic>.from(_properties);
    if (offset != null) ret['offset'] = offset;
    if (easing != null) ret['easing'] = easing;
    if (ret['transform'] is Map) {
      final Map<String, String> transformMap = ret['transform'];
      ret['transform'] = transformMap.values.join(' ');
    }
    return ret;
  }

  Keyframe clone() {
    return new Keyframe.build(new Map<String, dynamic>.from(_properties),
        offset: offset, easing: easing);
  }

  Keyframe backgroundColor(String color) {
    _properties['backgroundColor'] = color;
    return this;
  }

  Keyframe color(String color) {
    _properties['color'] = color;
    return this;
  }

  Keyframe width(int width, [String unit = 'px']) {
    _properties['width'] = '${width}${unit}';
    return this;
  }

  Keyframe height(int height, [String unit = 'px']) {
    _properties['height'] = '${height}${unit}';
    return this;
  }

  Keyframe left(int left, [String unit = 'px']) {
    _properties['left'] = '${left}${unit}';
    return this;
  }

  Keyframe top(int top, [String unit = 'px']) {
    _properties['top'] = '${top}${unit}';
    return this;
  }

  Keyframe margin(int margin, [String unit = 'px']) {
    _properties['margin'] = '${margin}${unit}';
    return this;
  }

  Keyframe marginAll(int top, int right, int bottom, int left,
      [String unit = 'px']) {
    _properties['margin'] =
        '${top}${unit} ${right}${unit} ${bottom}${unit} ${left}${unit}';
    return this;
  }

  Keyframe marginV(int v, [String unit = 'px']) {
    _properties['margin'] = '${v}${unit} 0${unit}';
    return this;
  }

  Keyframe marginH(int h, [String unit = 'px']) {
    _properties['margin'] = '0${unit} ${h}${unit}';
    return this;
  }

  Keyframe padding(int margin, [String unit = 'px']) {
    _properties['padding'] = '${margin}${unit}';
    return this;
  }

  Keyframe paddingAll(int top, int right, int bottom, int left,
      [String unit = 'px']) {
    _properties['padding'] =
        '${top}${unit} ${right}${unit} ${bottom}${unit} ${left}${unit}';
    return this;
  }

  Keyframe paddingV(int v, [String unit = 'px']) {
    _properties['padding'] = '${v}${unit} 0${unit}';
    return this;
  }

  Keyframe paddingH(int h, [String unit = 'px']) {
    _properties['padding'] = '0${unit} ${h}${unit}';
    return this;
  }

  Keyframe opacity(num opacity) {
    _properties['opacity'] = opacity.toString();
    return this;
  }

  Keyframe _transform(String operation, String value) {
    if (_properties['transform'] is Map) {
      _properties['transform'][operation] = value;
    } else {
      _properties['transform'] = {operation: value};
    }
    return this;
  }

  Keyframe translate(num x, num y, [String unit = 'px']) {
    _transform('translate', 'translate($x$unit, $y$unit)');
    return this;
  }

  Keyframe translate3D(num x, num y, num z, [String unit = 'px']) {
    _transform('translate', 'translate3d($x$unit, $y$unit, $z$unit)');
    return this;
  }

  Keyframe translateX(num x, [String unit = 'px']) {
    _transform('translate', 'translateX($x$unit)');
    return this;
  }

  Keyframe translateY(num y, [String unit = 'px']) {
    _transform('translate', 'translateY($y$unit)');
    return this;
  }

  Keyframe translateZ(num z, [String unit = 'px']) {
    _transform('translate', 'translateZ($z$unit)');
    return this;
  }

  Keyframe scale(num x, num y, [String unit = 'px']) {
    _transform('scale', 'scale($x$unit, $y$unit)');
    return this;
  }

  Keyframe scale3D(num x, num y, num z, [String unit = 'px']) {
    _transform('scale', 'scale3d($x$unit, $y$unit, $z$unit)');
    return this;
  }

  Keyframe scaleX(num x, [String unit = 'px']) {
    _transform('scale', 'scaleX($x$unit)');
    return this;
  }

  Keyframe scaleY(num y, [String unit = 'px']) {
    _transform('scale', 'scaleY($y$unit)');
    return this;
  }

  Keyframe scaleZ(num z, [String unit = 'px']) {
    _transform('scale', 'scaleZ($z$unit)');
    return this;
  }

  Keyframe rotate(num x, num y, [String unit = 'deg']) {
    _transform('rotate', 'rotate($x$unit, $y$unit)');
    return this;
  }

  Keyframe rotate3D(num x, num y, num z, [String unit = 'deg']) {
    _transform('rotate', 'rotate3d($x$unit, $y$unit, $z$unit)');
    return this;
  }

  Keyframe rotateX(num x, [String unit = 'deg']) {
    _transform('rotate', 'rotateX($x$unit)');
    return this;
  }

  Keyframe rotateY(num y, [String unit = 'deg']) {
    _transform('rotate', 'rotateY($y$unit)');
    return this;
  }

  Keyframe rotateZ(num z, [String unit = 'deg']) {
    _transform('rotate', 'rotateZ($z$unit)');
    return this;
  }

  Keyframe skew(num x, num y, [String unit = 'deg']) {
    _transform('skew', 'skew($x$unit, $y$unit)');
    return this;
  }

  Keyframe skewX(num x, [String unit = 'deg']) {
    _transform('skew', 'skewX($x$unit)');
    return this;
  }

  Keyframe skewY(num y, [String unit = 'deg']) {
    _transform('skew', 'skewY($y$unit)');
    return this;
  }

  Keyframe perspective(num n, [String unit = 'px']) {
    _transform('perspective', 'perspective($n$unit)');
    return this;
  }
}
