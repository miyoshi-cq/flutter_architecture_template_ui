import 'package:flutter/material.dart';
import 'package:flutter_architecture_template_ui/base/list/list_strategy.dart';
import 'package:flutter_architecture_template_ui/utility/scroll_to_top.dart';

class ListScreen<W extends Widget, T> extends StatefulWidget with ScrollToTop {
  final ListStrategy<W, T> strategy;

  ListScreen(this.strategy);

  @override
  State<ListScreen<W, T>> createState() => _ListScreenState<W, T>();
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
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          title: Text(widget.strategy.title),
        ),
        body: FutureBuilder<List<T>>(
          future: _fetch,
          builder: (context, snapshot) => Stack(
            children: [
              RefreshIndicator(
                onRefresh: () async {
                  setState(() {
                    _fetch = widget.strategy.fetch(false);
                  });
                },
                child: widget.strategy.rowCount > 1
                    ? GridView.count(
                        controller: widget.scrollController,
                        crossAxisCount: widget.strategy.rowCount,
                        children: List.generate(snapshot.data?.length ?? 0,
                            (index) => _cell(index, snapshot.data![index])),
                      )
                    : ListView.builder(
                        controller: widget.scrollController,
                        padding: EdgeInsets.all(8),
                        itemCount: snapshot.data?.length ?? 0,
                        itemBuilder: (BuildContext context, int index) =>
                            _cell(index, snapshot.data![index]),
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
          ),
        ),
      );

  Widget _cell(int index, T data) => GestureDetector(
        onTap: () => {
          widget.strategy.onTap(
            context,
            index,
            data,
          )
        },
        child: widget.strategy.itemWidgetBuilder(data),
      );

  void _scrollListener() {
    if (widget.scrollController.position.pixels ==
        widget.scrollController.position.maxScrollExtent) {
      setState(() {
        _fetch = widget.strategy.fetch(true);
      });
    }
  }
}
