# vk_login

A Flutter package for authorization via VK.

## Usage
Add `vk_login` as a [dependency in your pubspec.yaml file](https://flutter.dev/docs/development/platform-integration/platform-channels). If you are targeting Android, make sure to read the *Android Platform Views* section below to choose the platform view mode that best suits your needs.

## Getting Started
1. Set the correct `minSdkVersion` in `android/app/build.gradle` (if it was previously lower than 19):

```gradle
android {
    defaultConfig {
        minSdkVersion 19
    }
}
```
2. Add `android:usesCleartextTraffic="true"` in your `AndroidManifest.xml`
```xml
<manifest ...>
   <application
        android:label="label"
        android:icon="@mipmap/ic_launcher"
        android:usesCleartextTraffic="true">

```
# Example in application
You need to wrap your MaterialApp with ChangeNotifierProvider

```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vk_login/vk_login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => VkProvider(),
      child: MaterialApp(
        title: 'Material App',
        home: Scaffold(
          appBar: AppBar(
            title: Text('Material App Bar'),
          ),
          body: HomePage(),
        ),
      ),
    );
  }
}

```
First you must to call init()
```dart
class HomePage extends StatelessWidget {
  late VkProvider _vk;

  @override
  Widget build(BuildContext context) {
    _vk = Provider.of<VkProvider>(context);
    return FutureBuilder(
        future: _vk.init(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(
              child: Text('Loading...'),
            );
          return Column(
            children: [
              TextButton(
                  onPressed: () => _vk.login(context,
                      permissions: [VKScope.stats, VKScope.groups, VKScope.messages, VKScope.wall, VKScope.offline]),
                  child: Text('login')),
              TextButton(onPressed: () => _vk.logout(), child: Text('logout')),
              if (_vk.profile != null) Text('${_vk.profile!.firstName}'),
            ],
          );
        });
  }
}

```
