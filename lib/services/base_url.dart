class Baseurl {
  // static String baseURL = "http://localhost:8080/";
  static String baseURL = "https://arena-flashing-tractor-anniversary.trycloudflare.com/";
  static String baseURLImages = "${baseURL}api/files/";

  /// =============== Authentication APIs ============== ///
  static String loginApi = '${baseURL}auth/login';
  /// =============== Authentication APIs ============== ///

  /// ===============   Customers APIs    ============== ///
  static String getAllCustomersAPI = '${baseURL}customers';
  static String addCustomerAPI = '${baseURL}customers';
  static String updateCustomerAPI = '${baseURL}customers';
  static String deleteCustomerAPI = '${baseURL}customers';
  static String countGovernoratePerCustomerAPI = '${baseURL}customers/countsByGovernorate';
  /// ===============   Customers APIs    ============== ///

  /// ===============   Orders APIs    ============== ///
  static String getAllOrderAPI = '${baseURL}orders';
  static String addOrderAPI = '${baseURL}orders';
  static String updateOrderAPI = '${baseURL}orders';
  static String deleteOrderAPI = '${baseURL}orders';
  static String countGovernoratePerOrderAPI = '${baseURL}orders/countGovernorates';
  static String invoiceAPI = '${baseURL}invoice/pdf';
  /// ===============   Orders APIs    ============== ///

  /// ===============   Products APIs    ============== ///
  static String getAllProductsAPI = '${baseURL}products';
  static String addProductAPI = '${baseURL}products';
  static String updateProductAPI = '${baseURL}products';
  static String deleteProductAPI = '${baseURL}products';
  /// ===============   Products APIs    ============== ///

}