# Lab 8: API Integration & Asynchronous Programming

A Flutter project demonstrating how to interact with RESTful APIs over the network.

## Mục tiêu của Lab 8

Lab 8 tập trung vào việc hướng dẫn cách kết nối ứng dụng Flutter với các dịch vụ Web API bên ngoài (RESTful API), xử lý các tác vụ bất đồng bộ và quản lý trạng thái giao diện tương ứng. Thông qua bài tập này, bạn sẽ nắm vững:
1. **Giao tiếp HTTP:** Cài đặt và sử dụng thư viện `http` của Dart để gửi các yêu cầu mạng (GET, POST) tới một máy chủ (trong trường hợp này là API giả lập `jsonplaceholder.typicode.com`).
2. **Kỹ thuật Bất đồng bộ (Asynchronous):** Sử dụng `Future`, `async` và `await` để xử lý các dữ liệu mất thời gian tải qua mạng mà không làm khóa (đơ) giao diện ứng dụng.
3. **Quản lý UI theo trạng thái mạng (`FutureBuilder`):** Sử dụng `FutureBuilder` để tự động xây dựng giao diện dựa trên trạng thái của tác vụ mạng: Hiển thị vòng xoay tải (`CircularProgressIndicator`) khi đang chờ chờ dữ liệu (waiting), hiển thị thông báo lỗi nếu tải thất bại (hasError), hoặc hiển thị giao diện danh sách khi tải thành công (hasData).
4. **Phân tích cú pháp JSON từ API:** Cách nhận dữ liệu JSON phản hồi từ server, giải mã (`jsonDecode()`) và ánh xạ thành các đối tượng Dart (Model classes).
5. **Pattern Thiết kế (Service & Model):** Củng cố cấu trúc thư mục tiêu chuẩn với việc tách phần call API ra `ApiService` riêng và phân tách luồng dữ liệu vào `models`.

---

## Cấu trúc mã nguồn chi tiết trong `lib/`

Toàn bộ logic được chia ra làm 3 phần chính rõ rệt nhằm tối ưu hoá khả năng bảo trì:

### 1. Thư mục `models/` (Định nghĩa Dữ liệu)
- **`post_model.dart`**: Định nghĩa lớp `Post` (gồm id, title, body). Đặc biệt chú ý đến phương thức factory `Post.fromJson()`: đây là một "hàm tạo" chuyên dụng nhận đầu vào là một Map (JSON dictionary) từ Internet và chuyển đổi nó thành một đối tượng Dart an toàn, có kiểu dữ liệu rõ ràng.

### 2. Thư mục `services/` (Giao tiếp Mạng)
- **`api_service.dart`**: Trái tim của bài lab. Chứa lớp `ApiService` cô lập mọi logic call mạng.
  - Xây dựng hàm `fetchPosts()` gửi đi yêu cầu `http.get` lấy danh sách. Có ví dụ về cấu hình `headers` và tính năng giới hạn thời gian chạy (`timeout`). Bao gồm biểu thức kiểm tra mã lỗi phản hồi (`statusCode == 200` hay `403`...).
  - Xây dựng hàm `createPost()` gửi đi yêu cầu `http.post` để đăng bài mới. Encode nội dung người dùng nhập từ Dart thành dạng chuỗi JSON `jsonEncode()` trước khi đính kèm vào phần `body` của yêu cầu HTTP.

### 3. Thư mục `screens/` (Giao diện)
- **`post_list_screen.dart`**: 
  - Giao diện màn hình chính. 
  - Khởi tạo kết nối mạng tại hàm `initState` gán cho một biến `_futurePosts`.
  - Tích hợp `RefreshIndicator` quanh `FutureBuilder` để hỗ trợ tính năng "Kéo mảng xuống để làm mới dữ liệu" (Pull to refresh).
  - Tích hợp nút `FloatingActionButton` để mở màn hình "Thêm mới". Khi người dùng ấn Thêm trên màn hình phụ và trở về chung kèm một đối tượng `Post` mới (`result is Post`), ứng dụng lập tức cập nhật mảng local để hiển thị nháy ngay bài vừa đăng.

- **`add_post_screen.dart`**: 
  - Mảng hình chứa Form nhập liệu gồm Tiêu đề và Nội dung bài viết.
  - Có Validate dữ liệu (kiểm tra rỗng) thông qua `GlobalKey<FormState>`.
  - Có quản lý trạng thái tải `_isLoading`. Khi bấm "Đăng bài", nút bấm lập tức ẩn đi và hiện vòng xoay quay (đóng băng thao tác) trong khi đợi hàm `_apiService.createPost` trả về kết quả, ngăn người dùng bấm nhiều lần sinh ra lỗi.
  - Trả về đối tượng `Post` mới tạo cho màn hình trước bằng lệnh `Navigator.pop(context, newPost)`.

---


