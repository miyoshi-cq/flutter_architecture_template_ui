import 'package:flutter/material.dart';
import 'package:flutter_architecture_template_ui/base/list/list_strategy.dart';

class ListScreen<W extends Widget, T> extends StatefulWidget {
  final ListStrategy<W, T> strategy;

  const ListScreen(this.strategy);

  @override
  State<ListScreen<W, T>> createState() => _ListScreenState<W, T>();
}

class _ListScreenState<W extends Widget, T> extends State<ListScreen<W, T>> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.strategy.title),
      ),
      body: FutureBuilder<List<T>>(
        future: widget.strategy.fetch,
        builder: (context, snapshot) {
          return RefreshIndicator(
            onRefresh: () async {
              setState(() {});
            },
            child: ListView.builder(
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () => {
                    widget.strategy.onTap(
                      context,
                      index,
                      snapshot.data![index],
                    )
                  },
                  child:
                      widget.strategy.itemWidgetBuilder(snapshot.data![index]),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
