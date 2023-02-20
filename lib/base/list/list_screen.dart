import 'package:flutter/material.dart';
import 'package:flutter_architecture_template_ui/base/list/list_strategy.dart';

class ListScreen<W extends Widget, T> extends StatefulWidget {
  final ListStrategy<W, T> strategy;
  final scrollController = ScrollController();

  ListScreen(this.strategy);

  @override
  State<ListScreen<W, T>> createState() => _ListScreenState<W, T>();

  void scrollToTop() {
    scrollController.animateTo(
      0,
      duration: Duration(milliseconds: 300),
      curve: Curves.linear,
    );
  }
}

class _ListScreenState<W extends Widget, T> extends State<ListScreen<W, T>> {
  Future<List<T>>? _fetch;

  @override
  void initState() {
    _fetch = widget.strategy.fetch(false);
    super.initState();
    widget.scrollController.addListener(_scrollListener);
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
          return Stack(
            children: [
              RefreshIndicator(
                onRefresh: () async {
                  setState(() {
                    _fetch = widget.strategy.fetch(false);
                  });
                },
                child: ListView.builder(
                  controller: widget.scrollController,
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
                      child: widget.strategy
                          .itemWidgetBuilder(snapshot.data![index]),
                    );
                  },
                ),
              ),
              Visibility(
                visible: snapshot.connectionState == ConnectionState.waiting,
                child: Container(
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _scrollListener() {
    if (widget.scrollController.position.pixels ==
        widget.scrollController.position.maxScrollExtent) {
      setState(() {
        _fetch = widget.strategy.fetch(true);
      });
    }
  }
}
