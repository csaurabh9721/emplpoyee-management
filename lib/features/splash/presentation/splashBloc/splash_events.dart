import 'package:flutter/cupertino.dart';

@immutable
abstract class SplashEvents {
  const SplashEvents();
}

class SplashVersionEvent extends SplashEvents {
  const SplashVersionEvent();
}

class SplashNavigate extends SplashEvents {
  const SplashNavigate();
}
