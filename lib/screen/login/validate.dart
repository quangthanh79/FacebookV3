class Validate {
  static String? isValidPhone(String phone) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(pattern);
    if (phone.length == 0) {
      return 'Vui lòng nhập số điện thoại.';
    } else if (!regExp.hasMatch(phone)) {
      return 'Số điện thoại không đúng định dạng';
    }
    return null;
  }

  static String? isValidPassword(String password) {
    String pattern = r'(^[a-zA-Z0-9]*$)';
    RegExp regExp = new RegExp(pattern);
    if (password.length == 0) {
      return 'Vui lòng nhập mật khẩu';
    } else if (!regExp.hasMatch(password)) {
      return 'Mật khẩu không chứa ký tự đặc biệt';
    }
    return null;
  }
}
