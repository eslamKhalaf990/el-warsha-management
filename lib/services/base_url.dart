class Baseurl {
  static String baseURL = "http://localhost:8080/";
  // static String baseURL = "https://accommodation-led-comprehensive-floating.trycloudflare.com/";
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
  static String getAllCategoriesAPI = '${baseURL}category';
  static String addProductAPI = '${baseURL}products';
  static String updateProductAPI = '${baseURL}products';
  static String deleteProductAPI = '${baseURL}products';
  /// ===============   Products APIs    ============== ///

  /// ===============   Cash Flow APIs    ============== ///
  static String getRevenueSummaryAPI = '${baseURL}cashFlow/revenueSummary';
  static String getDailyCashFlowAPI = '${baseURL}cashFlow/daily';
  /// ===============   Products APIs    ============== ///

  /// ===============   Accounting APIs    ============== ///
  static String getAccountsBalanceAPI = '${baseURL}api/bank/accounts';
  static String addTransactionAPI = '${baseURL}api/bank/transaction';
  static String getTransactionsAPI = '${baseURL}api/bank/transactions';
  static String getTransactionCategoriesAPI = '${baseURL}api/bank/transactionCategories';
  /// ===============   Products APIs    ============== ///
}