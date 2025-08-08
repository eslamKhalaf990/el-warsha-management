class Baseurl {
  // static String baseURL = "https://warshaerp-production.up.railway.app/";
  static String baseURL = "http://localhost:8080/";
  static String baseURLImages = "${baseURL}products/getImage?filename=";

  /// =============== Authentication APIs ============== ///
  /// =============== Authentication APIs ============== ///

  /// ===============   Customers APIs    ============== ///
  static String getAllCustomersAPI = '${baseURL}customers';
  static String addCustomerAPI = '${baseURL}customers';
  /// ===============   Customers APIs    ============== ///


  /// ===============   Orders APIs    ============== ///
  static String getAllOrderAPI = '${baseURL}orders';
  static String addOrderAPI = '${baseURL}orders';
  /// ===============   Orders APIs    ============== ///

  /// ===============   Products APIs    ============== ///
  static String getAllProductsAPI = '${baseURL}products';
  static String addProductAPI = '${baseURL}products';
  /// ===============   Products APIs    ============== ///

}