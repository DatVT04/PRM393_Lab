# Lab 7: Form & Validation trong Flutter

A Flutter project demonstrating how to build and validate forms.

## Mục tiêu của Lab 7

Lab 7 tập trung vào một trong những tính năng cốt lõi và quan trọng nhất của mọi ứng dụng thực tế: **Xây dựng và Kiểm tra dữ liệu Biểu mẫu (Form Validation)**. Thông qua dự án Xây dựng màn hình Đăng ký (SignupScreen) này, bạn sẽ nắm vững các kỹ năng:
1. **Sử dụng Form và TextFormField:** Biết cách cấu trúc một biểu mẫu thu thập dữ liệu bằng công cụ `Form` và `TextFormField` của Flutter thay vì dùng `TextField` thông thường để hỗ trợ tính năng validation tự động.
2. **Kiểm tra tính hợp lệ của dữ liệu (Validation):** Thực hành viết và áp dụng các quy tắc kiểm tra dữ liệu đầu vào. Ví dụ: kiểm tra rỗng (`required`), kiểm tra định dạng email (phải có `@` và `.`), kiểm tra độ mạnh mật khẩu (độ dài, chứa chữ số) và xác minh mật khẩu nhập lại (Confirm Password) có khớp hay không.
3. **Quản lý Focus (FocusNode):** Tùy chỉnh trải nghiệm nhập liệu (User Experience) bằng cách sử dụng `FocusNode` và thuộc tính `textInputAction` (như `TextInputAction.next`). Nhờ đó, khi người dùng bấm phím "Next" trên bàn phím ảo, trỏ chuột sẽ tự động nhảy sang ô nhập liệu tiếp theo một cách mượt mà.
4. **Ẩn bàn phím tiện lợi:** Học thủ thuật bọc toàn bộ màn hình bằng `GestureDetector` và gọi hàm `FocusScope.of(context).unfocus()` để tự động ẩn bàn phím ảo khi người dùng chạm vào bất kỳ vùng trống nào trên màn hình.
5. **Xử lý trạng thái tải (Loading State):** Hiển thị thanh tiến trình (`CircularProgressIndicator`) ngay trên nút "Submit" và vô hiệu hóa nút này khi ứng dụng đang giả lập gửi dữ liệu đi, tránh việc người dùng bấm gửi nhiều lần liên tiếp.

---

## Cấu trúc mã nguồn chi tiết trong `lib/`

Toàn bộ logic của Lab 7 được làm gọn gàng trong một file duy nhất để dễ theo dõi:

### File `main.dart`
- Chứa lớp `SignupScreen` (là một `StatefulWidget`).
- **Phân tách các hàm Validation:** Bao gồm chuỗi các hàm trả về thông báo lỗi (kiểu `String?`) như `_validateRequired`, `_validateEmail`, `_validatePassword`, `_validateConfirm`. Nếu dữ liệu hợp lệ, hàm sẽ trả về `null`.
- **GlobalKey:** Cung cấp một `_formKey` (`GlobalKey<FormState>`) được gán cho thẻ `Form`. Nó đóng vai trò là "chìa khoá" để ứng dụng có thể gọi lệnh `_formKey.currentState!.validate()` kiểm tra toàn bộ các trường nhập liệu cùng lúc khi bấm nút Đăng ký.
- **Form UI:** Giao diện gồm 4 ô nhập liệu chính: Tên đầy đủ (Name), Email, Mật khẩu (Password - có tính năng che chữ `obscureText`), và Xác nhận mật khẩu (Confirm Password).
- **Hành động Gửi (Submit):** Đoạn mã `_submit()` sẽ xác thực form, lưu dữ liệu, đổi trạng thái thành "đang tải", giả lập thời gian trễ bằng `Future.delayed`, sau đó kiểm tra và hiển thị kết quả bằng `ScaffoldMessenger` (SnackBar báo lỗi email đã tồn tại hoặc báo đăng ký thành công).

Nắm vững kiến thức của bài Lab 7 sẽ giúp bạn dễ dàng làm chủ các tính năng thu thập dữ liệu người dùng như Đăng nhập, Đăng ký, Cập nhật Hồ sơ cá nhân trong các dự án sau này!

---


