class API<T> {
  /**
   * 请求成功
   */
  static var SCODE_SUCCESS = 1;

  /**
   * 请求错误
   */
  static var SCODE_ERROR = -1;

  /**
   * 请求参数不合法
   */
  static var SCODE_ILLEGAL_PARAMS = -2;

  /**
   * 没有数据
   */
  static var SCODE_NO_DATA = -3;

  String msg;

  int statusCode;

  T result;
}
