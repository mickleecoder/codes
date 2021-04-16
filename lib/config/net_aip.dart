class NetApi {
  static const String BASE_URL = "https://flutter-jdapi.herokuapp.com/api/";

  //返回首页请求的json
  static const String HOME_PAGE = BASE_URL + "profiles/homepage";
  //分类页的导航
  static const String CATEGOTY_NAV = BASE_URL + "profiles/navigationLeft";
  //分类商品目录的json数据
  static const String CATEGOTY_CONTENT = BASE_URL + "profiles/navigationRight";
  //商品列表的json数据
  static const String PRODUCTIONS_LIST = BASE_URL + "profiles/productionsList";
  //商品详情的json数据
  static const String PRODUCTIONS_DETAIL =
      BASE_URL + "profiles/productionDetail";

  //socket服务器地址
  //webscocket的地址不是http的协议头，而是ws://
  //如果是基于https的，则是wss://
  static const address = "wws://192.168.128.12:20000";
  // static const address = "ws://192.168.1.103:8080/connect";
}
