class ListModel<T> {
  int curPage;
  int offset;
  int pageCount;
  int size;
  int total;
  bool over;
  List<T> datas;


  ListModel.fromParams({curPage, offset, pageCount, size, total, over, datas});

  ListModel.fromJson(jsonRes, Function operator) {
    curPage = jsonRes['curPage'];
    offset = jsonRes['offset'];
    pageCount = jsonRes['pageCount'];
    size = jsonRes['size'];
    total = jsonRes['total'];
    over = jsonRes['over'];
    datas = jsonRes['datas'] == null ? null : [];

    for (var datasItem in datas == null ? [] : jsonRes['datas']) {
      T result = operator(datasItem);
      if (result != null) {
        datas.add(result);
      }
    }
  }

  @override
  String toString() {
    return '{"curPage": $curPage,"offset": $offset,"pageCount": $pageCount,"size": $size,"total": $total,"over": $over,"datas": $datas}';
  }
}
