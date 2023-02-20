import 'package:flutter/material.dart';
import 'package:flutter_architecture_template_ui/base/list/list_strategy.dart';

class ListScreen<W extends Widget, T> extends StatefulWidget {
  final ListStrategy<W, T> strategy;

  const ListScreen(this.strategy);

  @override
  State<ListScreen<W, T>> createState() => _ListScreenState<W, T>();
}

class _ListScreenState<W extends Widget, T> extends State<ListScreen<W, T>> {
  final scrollController = ScrollController();
  Future<List<T>>? _fetch;

  @override
  void initState() {
    _fetch = widget.strategy.fetch;
    super.initState();
    scrollController.addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: Text(widget.strategy.title),
      ),
      body: FutureBuilder<List<T>>(
        future: _fetch,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container(
              alignment: Alignment.center,
              child: const CircularProgressIndicator(),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              setState(() {});
            },
            child: ListView.builder(
              controller: scrollController,
              padding: EdgeInsets.all(8),
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

  void _scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      setState(() {
        _fetch = widget.strategy.fetch;
      });
    }
  }
}
