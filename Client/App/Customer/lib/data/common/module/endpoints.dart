class Endpoints {
  Endpoints._();

  static const String baseURL = 'http://192.168.1.56:3000/api';

  static const Duration receiveTimeout = Duration(milliseconds: 6000);

  static const Duration connectionTimeout = Duration(milliseconds: 5000);

  static const String users = '/users';
  static const String login = '/login';
  static const String register = '/register';
  static const String logout = '/logout';
  static const String getList = '/list';
}

// Đoạn code trên định nghĩa một lớp Endpoints chứa các hằng số và phương thức tĩnh liên quan đến các điểm cuối (endpoints) của một API. Dưới đây là giải thích cho từng phần của mã:

// Endpoints._();: Đây là một constructor riêng tư (private) không cho phép tạo thể hiện mới của lớp Endpoints bên ngoài. Mục đích của constructor này có thể là để ngăn chặn việc tạo đối tượng từ lớp Endpoints và chỉ cho phép sử dụng các phương thức và thuộc tính tĩnh của lớp.

// static const String baseURL = 'https://gorest.co.in/public/v2';: Đây là một hằng số tĩnh kiểu chuỗi (String) được gán giá trị là URL cơ sở (baseURL) cho API. URL này có thể là điểm cuối chung cho tất cả các yêu cầu API trong ứng dụng.

// static const int receiveTimeout = 5000;: Đây là một hằng số tĩnh kiểu số nguyên (int) đại diện cho thời gian chờ nhận phản hồi từ API, được định dạng theo đơn vị mili giây (milliseconds). Trong trường hợp này, giá trị là 5000ms (tức là 5 giây).

// static const int connectionTimeout = 3000;: Đây là một hằng số tĩnh kiểu số nguyên (int) đại diện cho thời gian chờ kết nối tới API, được định dạng theo đơn vị mili giây (milliseconds). Trong trường hợp này, giá trị là 3000ms (tức là 3 giây).

// static const String users = '/users';: Đây là một hằng số tĩnh kiểu chuỗi (String) đại diện cho endpoint "/users" trong API. Endpoint "/users" có thể đề cập tới tài nguyên người dùng trong hệ thống API.

// Với các hằng số và phương thức tĩnh trong lớp Endpoints, bạn có thể sử dụng chúng để xây dựng các yêu cầu API, chỉnh sửa thời gian chờ kết nối và nhận phản hồi, và truy cập đường dẫn (endpoint) của nguồn tài nguyên cụ thể trong API.