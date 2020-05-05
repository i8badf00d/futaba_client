import 'package:flutter/material.dart';
import 'package:futaba_client/entity/board.dart';
import 'package:futaba_client/entity/thread.dart';
import 'package:futaba_client/page/catalog/catalog_page_model.dart';
import 'package:futaba_client/page/thread_detail/thread_detail_page.dart';
import 'package:futaba_client/store/catalog_cross_axis_count_store.dart';
import 'package:futaba_client/store/catalog_sort_type_store.dart';
import 'package:futaba_client/type/catalog_sort_type.dart';
import 'package:futaba_client/widget/thread_grid_cell.dart';
import 'package:provider/provider.dart';

class _SortMenuItem {
  _SortMenuItem({this.title, this.sortType});
  final String title;
  final CatalogSortType sortType;
}

class CatalogPage extends StatelessWidget {
  const CatalogPage._({Key key}) : super(key: key);

  static Widget withDependencies({
    Key key,
    Board board,
    CatalogCrossAxisCountStore store,
  }) {
    return ChangeNotifierProvider<CatalogPageModel>(
      create: (_) => CatalogPageModel(board, store),
      child: CatalogPage._(key: key),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pageModel = Provider.of<CatalogPageModel>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(pageModel.board.name),
      ),
      body: GestureDetector(
        onScaleStart: pageModel.onScaleStart,
        onScaleUpdate: pageModel.onScaleUpdate,
        onScaleEnd: pageModel.onScaleEnd,
        child: _buildBody(context),
      ),
      bottomNavigationBar: _buildBottomAppBar(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    final pageModel = Provider.of<CatalogPageModel>(context);
    final catalogSortTypeStore = Provider.of<CatalogSortTypeStore>(context);
    pageModel.selectSortType(catalogSortTypeStore.value);
    return RefreshIndicator(
      child: pageModel.threads.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: pageModel.crossAxisCount,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
              ),
              itemCount: pageModel.threads.length,
              itemBuilder: (context, index) {
                return ThreadGridCell(
                  thread: pageModel.threads[index],
                  onTap: () => _presentThreadDetailPage(
                    context,
                    pageModel.threads[index],
                  ),
                );
              },
              controller: pageModel.scrollController,
            ),
      onRefresh: pageModel.fetchThreads,
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
    final pageModel = Provider.of<CatalogPageModel>(context, listen: false);
    final catalogSortTypeStore = Provider.of<CatalogSortTypeStore>(context);
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
              pageModel.scrollController.jumpTo(0);
              catalogSortTypeStore.selectSortType(selectedItem.sortType);
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
