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
