class Baseurl {
  // static String baseURL = "https://2fvvvgwq-5162.euw.devtunnels.ms/";
  static String baseURL = "http://localhost:8080/";

  /// =============== Authentication APIs ============== ///
  static String signInApi = '${baseURL}Orglx/Login';
  static String changePasswordApi = '${baseURL}MobileHome/ChangePassword';
  /// =============== Authentication APIs ============== ///

  /// ===============   User Data APIs    ============== ///
  static String editUserDataApi = '${baseURL}MobileUser/EditUser';
  static String getUserDataApi = '${baseURL}MobileHome/GetUser';
  static String getPayroll = '${baseURL}MobileHome/getPayroll';
  /// ===============   User Data APIs    ============== ///

  /// ===============   Attendance APIs    ============== ///
  static String getSummary = '${baseURL}Attendance/GetSummary';
  static String getWorkforce = '${baseURL}Attendance/GetWorkforce';
  static String submitLeaveRequest = '$baseURL/Attendance/AddLeaveReq';
  static String checkEmployeeIn = '${baseURL}Attendance/CheckIn';
  static String checkEmployeeOut = '${baseURL}Attendance/CheckOut';
  static String addLeaveRequest = '${baseURL}Attendance/AddLeaveReq';
  static String getDepartmentInfo = '${baseURL}Attendance/GetDepInfo';
  static String getLeaveHistory = '${baseURL}Attendance/GetLeaveHistory';
  static String getAllProductsAPI = '${baseURL}products';
}