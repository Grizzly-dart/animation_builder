// Copyright (c) 2017, teja. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

/// Fluent and type-safe API to build keyframes and timing for Web Animation API
///
/// Provides [Keyframes] to build keyframes fluently. [AnimationOptions] provides
/// an API to build animation timing options fluently.
///
/// [AnimationBuilder] encapsulates both [Keyframes] and [AnimationOptions] needed
/// to animate an [Element].
library animation_builder;

export 'src/animation_builder_base.dart';
