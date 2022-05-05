import 'package:biddano/views/tabbar/api-implementation/api.dart';
import 'package:biddano/views/tabbar/ui-credit-card/ui.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key, this.title}) : super(key: key);
  final String? title;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            title!,
          ),
          bottom: const TabBar(
            tabs: [
              Tab(
                text: 'Api tree',
                icon: Icon(
                  Icons.api,
                ),
              ),
              Tab(
                text: 'Credit card UI',
                icon: Icon(
                  Icons.credit_card,
                ),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            APIPage(),
            UIPage(),
          ],
        ),
      ),
    );
  }
}
