// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:ui' show Color, Size, Rect, VoidCallback, lerpDouble;

/// The direction in which an animation is running.
enum AnimationDirection {
  /// The animation is running from beginning to end.
  forward,

  /// The animation is running backwards, from end to beginning.
  reverse
}

/// The status of an animation
enum AnimationStatus {
  /// The animation is stopped at the beginning
  dismissed,

  /// The animation is running from beginning to end
  forward,

  /// The animation is running backwards, from end to beginning
  reverse,

  /// The animation is stopped at the end
  completed,
}

typedef void AnimationStatusListener(AnimationStatus status);

abstract class Animation<T> {
  const Animation();

  /// Calls the listener every time the value of the animation changes.
  void addListener(VoidCallback listener);
  /// Stop calling the listener every time the value of the animation changes.
  void removeListener(VoidCallback listener);
  /// Calls listener every time the status of the animation changes.
  void addStatusListener(AnimationStatusListener listener);
  /// Stops calling the listener every time the status of the animation changes.
  void removeStatusListener(AnimationStatusListener listener);

  /// The current status of this animation.
  AnimationStatus get status;

  /// The current direction of the animation.
  AnimationDirection get direction;

  /// The current value of the animation.
  T get value;

  /// Whether this animation is stopped at the beginning.
  bool get isDismissed => status == AnimationStatus.dismissed;

  /// Whether this animation is stopped at the end.
  bool get isCompleted => status == AnimationStatus.completed;

  String toString() {
    return '$runtimeType(${toStringDetails()})';
  }
  String toStringDetails() {
    assert(status != null);
    assert(direction != null);
    String icon;
    switch (status) {
      case AnimationStatus.forward:
        icon = '\u25B6'; // >
        break;
      case AnimationStatus.reverse:
        icon = '\u25C0'; // <
        break;
      case AnimationStatus.completed:
        switch (direction) {
          case AnimationDirection.forward:
            icon = '\u23ED'; // >>|
            break;
          case AnimationDirection.reverse:
            icon = '\u29CF'; // <|
            break;
        }
        break;
      case AnimationStatus.dismissed:
        switch (direction) {
          case AnimationDirection.forward:
            icon = '\u29D0'; // |>
            break;
          case AnimationDirection.reverse:
            icon = '\u23EE'; // |<<
            break;
        }
        break;
    }
    assert(icon != null);
    return '$icon';
  }
}
