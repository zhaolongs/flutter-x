///
/// Created by Maker on 2019/4/9.
/// Description:
///

class ImageUtil{
  static String getImgPath(String name, {String format: 'png'}) {
    return 'assets/images/$name.$format';
  }

  static String getImgsPath(String name,{String format:'png'}){
    return 'images/$name.$format' ;
  }



}