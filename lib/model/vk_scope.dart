import 'package:flutter/foundation.dart';

/// token permissions
enum VKScope {
  friends,
  photos,
  audio,
  video,
  stories,
  pages,
  status,
  notes,
  messages,
  wall,
  ads,
  offline,
  docs,
  groups,
  notifications,
  stats,
  email,
  market
}

extension VKScopeExtension on VKScope {
  String get name => describeEnum(this);
}
