/**
 * @author Armyone
 * @date 2019/6/10 17:31
 * @desc 图片工具类
 */
class ImageUtil {
  static String getImgPath(String name, {String format: 'png'}) {
    return 'assets/images/$name.$format';
  }
}