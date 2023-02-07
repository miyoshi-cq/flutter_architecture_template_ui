import 'package:flutter/material.dart';
import 'package:flutter_architecture_template_ui/base/list/list_strategy.dart';

class ListScreen<W extends Widget, T> extends StatelessWidget {
  final ListStrategy<W, T> strategy;

  const ListScreen(this.strategy);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(strategy.title),
      ),
      body: FutureBuilder<List<T>>(
        future: strategy.fetch,
        builder: (context, snapshot) {
          return RefreshIndicator(
            onRefresh: () {
              return Future(() => null);
            },
            child: ListView.builder(
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    strategy.onTap(context, index);
                  },
                  child: strategy.itemWidgetBuilder(snapshot.data![index]),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
