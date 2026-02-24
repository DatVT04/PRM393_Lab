# Lab 5: Movie Detail App

A new Flutter project demonstrating basic to intermediate Flutter skills.

## Mục tiêu của Lab 5

Lab 5 yêu cầu xây dựng một ứng dụng di động cơ bản bằng Flutter có tên là **"Movie Detail App"**. Thông qua dự án này, bạn sẽ thực hành và củng cố các kỹ năng ứng dụng cơ bản tới trung cấp sau:
1. **Quản lý cấu trúc dự án (Architecture & Folder Structure):** Thực hành chia nhỏ mã nguồn khoa học thành các thư mục `models`, `screens` và `widgets` để dễ quản lý, nâng cấp cũng như bảo trì.
2. **Xây dựng UI tổng hợp (UI Building):** Kết hợp nhiều Widget đa dạng như `ListView`, `Card`, `Stack`, `Wrap`, `Chip` để tạo ra một giao diện hiển thị chuyên nghiệp, gọn gàng.
3. **Điều hướng màn hình (Navigation):** Nắm vững cách chuyển đổi qua lại giữa màn hình danh sách và màn hình chi tiết bằng `Navigator.push`, cũng như truyền dữ liệu (`Movie`) từ màn hình này qua màn hình kia.
4. **Quản lý trạng thái cục bộ (Local State Management):** Sử dụng `StatefulWidget` để hiển thị các tương tác của người dùng như bấm nút Yêu thích (Favorite) hoặc Đánh giá (Rate) mà không cần phải load lại toàn bộ màn hình.
5. **Tích hợp thư viện bên ngoài (Third-party Packages):** Ứng dụng gói `url_launcher` để tương tác với hệ điều hành, cụ thể là để mở các liên kết video trailer của phim thông qua trình duyệt hoặc ứng dụng YouTube bên ngoài.

## Cấu trúc mã nguồn chi tiết trong `lib/`

Dự án được tổ chức rất rõ ràng, tách bạch giữa Dữ liệu và Giao diện:

### 1. File cấu hình gốc - `main.dart`
- Đây là điểm bắt đầu (entry point) của ứng dụng.
- Khởi tạo ứng dụng với `MaterialApp`, cấu hình Theme theo chuẩn **Material 3** với tông màu chủ đạo là `deepPurple`. Loại bỏ nhãn debug trên màn hình và thiết lập trang khởi động là `HomeScreen`.

### 2. Thư mục `models/` (Quản lý dữ liệu)
- Chứa file **`movie.dart`**: Nơi định nghĩa cấu trúc của đối tượng Phim (`Movie`) và đoạn xem trước (`Trailer`).
- File này cũng bao gồm class `MovieData`, chứa một phương thức khởi tạo **dữ liệu tĩnh (mock data)** trực tiếp trong app gồm 2 bộ phim nổi bật (như *Dune: Part Two* và *Deadpool & Wolverine*). Dữ liệu này cung cấp đầy đủ: ID, Tên, ảnh Poster, nội dung, thể loại, điểm số và các đường link YouTube.

### 3. Thư mục `screens/` (Các màn hình chính)
- **`home_screen.dart`**: Là màn hình Trang chủ. Màn hình này tiến hành lấy danh sách phim từ Model, sau đó dùng `ListView.builder` để render ra một danh sách cuộn mượt mà các `MovieCard` (Thẻ đại diện phim). 
- **`movie_detail_screen.dart`**: Là màn hình Chi tiết Phim. Màn hình này được tổ chức sử dụng `SingleChildScrollView` phối hợp với `SizedBox`, hiển thị mọi yếu tố như: ảnh bìa khổng lồ, danh sách "Thể loại" (genres), đoạn tóm tắt nội dung (overview), hàng phím chức năng tương tác và cuối cùng là danh sách các Trailer.

### 4. Thư mục `widgets/` (Các thành phần UI nhỏ có khả năng tái sử dụng)
Đây là thư mục chứa các UI Component được trích xuất ra file riêng nhằm giúp các Screens không bị quá dài và phức tạp (file **`widgets.dart`**). Bao gồm:
- **`MovieCard`**: Thẻ hiển thị các thông tin rút gọn cho một phim hiển thị ngoài trang chủ (Icon ảnh, tên phim, điểm sao đánh giá, thể loại).
- **`HeroBanner`**: Tổ hợp UI dùng `Stack` sử dụng ngoài màn hình chi tiết. Nó phủ một lớp `LinearGradient` từ trong suốt dần về màu đen ở cạnh dưới để đảm bảo tên phim hiển thị phía trên lớp ảnh nền luôn nổi bật và dễ đọc chữ.
- **`GenreChips`**: Thành phần UI sử dụng widget `Wrap` chứa nhiều `Chip` nhỏ nối tiếp nhau để hiển thị các thể loại phim.
- **`ActionButtons`**: Đây là thành phần UI tương tác (`StatefulWidget`) quản lý cụm 3 phím: Favorite, Rate và Share. Khi người dùng bấm vào các nút có state như Like hay Rate, trạng thái đổi icon ngay tại chỗ (đã đổ màu hay chưa) và sử dụng `ScaffoldMessenger` để bật một `SnackBar` thông báo dưới đáy màn hình. 
- **`TrailerList`**: Vùng danh sách các trailer. Nó dùng `url_launcher` kiểm tra `canLaunchUrl()` trước khi yêu cầu mở link phim bằng ứng dụng độc lập bên ngoài (`LaunchMode.externalApplication`).

---

