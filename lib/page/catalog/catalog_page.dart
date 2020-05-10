import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:futaba_client/entity/board.dart';
import 'package:futaba_client/entity/thread.dart';
import 'package:futaba_client/page/catalog/catalog_controller.dart';
import 'package:futaba_client/page/catalog/catalog_state.dart';
import 'package:futaba_client/page/thread_detail/thread_detail_page.dart';
import 'package:futaba_client/type/catalog_sort_type.dart';
import 'package:futaba_client/widget/thread_grid_cell.dart';
import 'package:provider/provider.dart';

class _SortMenuItem {
  _SortMenuItem({this.title, this.sortType});
  final String title;
  final CatalogSortType sortType;
}

class CatalogPage extends StatelessWidget {
  CatalogPage._({Key key}) : super(key: key);

  static Widget withDependencies({Key key, Board board}) {
    return StateNotifierProvider<CatalogController, CatalogState>(
      create: (_) => CatalogController(board),
      child: CatalogPage._(key: key),
    );
  }

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<CatalogController>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.board.name),
      ),
      body: GestureDetector(
        onScaleStart: controller.onScaleStart,
        onScaleUpdate: controller.onScaleUpdate,
        onScaleEnd: controller.onScaleEnd,
        child: _buildBody(context),
      ),
      bottomNavigationBar: _buildBottomAppBar(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    final controller = Provider.of<CatalogController>(context, listen: false);
    final state = Provider.of<CatalogState>(context, listen: true);
    return RefreshIndicator(
      child: state.threads.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: state.columnCount,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
              ),
              itemCount: state.threads.length,
              itemBuilder: (context, index) {
                return ThreadGridCell(
                  thread: state.threads[index],
                  onTap: () => _presentThreadDetailPage(
                    context,
                    state.threads[index],
                  ),
                );
              },
              controller: _scrollController,
            ),
      onRefresh: controller.fetchThreads,
    );
  }

  void _presentThreadDetailPage(BuildContext context, Thread thread) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (context) {
        return ThreadDetailPage.withDependencies(thread: thread);
      }),
    );
  }

  static final List<_SortMenuItem> _sortMenuItems = [
    _SortMenuItem(title: 'カタログ', sortType: CatalogSortType.none),
    _SortMenuItem(title: '新順', sortType: CatalogSortType.createdDateDesc),
    _SortMenuItem(title: '古順', sortType: CatalogSortType.createdDateAsc),
    _SortMenuItem(title: '多順', sortType: CatalogSortType.replyCountDesc),
    _SortMenuItem(title: '少順', sortType: CatalogSortType.replyCountAsc),
  ];

  Widget _buildBottomAppBar(BuildContext context) {
    final controller = Provider.of<CatalogController>(context, listen: false);
    return BottomAppBar(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {},
          ),
          PopupMenuButton(
            onSelected: (_SortMenuItem selectedItem) {
              _scrollController.jumpTo(0);
              controller.selectSortType(selectedItem.sortType);
            },
            icon: Icon(Icons.more_horiz),
            itemBuilder: (context) {
              return _sortMenuItems.map((sortMenuItem) {
                return PopupMenuItem<_SortMenuItem>(
                  value: sortMenuItem,
                  child: Text(sortMenuItem.title),
                );
              }).toList();
            },
          ),
        ],
      ),
    );
  }
}
