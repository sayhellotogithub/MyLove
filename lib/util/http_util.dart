//模拟网络请求数据
import 'package:mylove/model/com_model.dart';
import 'package:mylove/model/splash_model.dart';

class HttpUtil {
  Future<SplashModel> getSplash() {
    return Future.delayed(new Duration(milliseconds: 300), () {
      return new SplashModel(
        title: '自已的心得',
        content: '我的简书',
        url: 'https://www.jianshu.com/u/107ee82c3cfd',
        imgUrl:
        'https://raw.githubusercontent.com/Sky24n/LDocuments/master/AppImgs/flutter_common_utils_a.png',
      );
    });
  }

  Future<ComModel> getRecItem() async {
    return Future.delayed(new Duration(milliseconds: 300), () {
      return null;
    });
  }

  Future<List<ComModel>> getRecList() async {
    return Future.delayed(new Duration(milliseconds: 300), () {
      return new List();
    });
  }
}