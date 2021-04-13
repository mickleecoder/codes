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
  static const address = "";
}
