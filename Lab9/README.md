# Lab 9: JSON Data Handling & Local Storage

A Flutter project demonstrating how to work with JSON data and local file storage.

## Mục tiêu của Lab 9

Lab 9 tập trung vào việc xử lý dữ liệu định dạng JSON và cách lưu trữ dữ liệu cục bộ trên thiết bị bằng Flutter. Thông qua 3 bài tập nhỏ (Lab 9.1, 9.2, 9.3), bạn sẽ nắm vững các kỹ năng quan trọng sau:
1. **Đọc dữ liệu JSON từ Assets (Lab 9.1):** Học cách nạp một file JSON tĩnh (`products.json`) đính kèm sẵn trong ứng dụng bằng `rootBundle.loadString` và phân tích cú pháp (decode) JSON thành danh sách các đối tượng Dart để hiển thị lên giao diện `ListView`.
2. **Ghi và Lưu trữ dữ liệu JSON cục bộ (Lab 9.2):** Thực hành tạo dữ liệu mới từ người dùng (nhập qua `TextField`) và tiến hành lưu trữ mảng dữ liệu này vào bộ nhớ trong của thiết bị thiết bị (dưới dạng file `data.json`) bằng thư viện `path_provider` và các lớp quản lý `File` của thư viện `dart:io`.
3. **Thao tác CRUD toàn diện với JSON (Lab 9.3):** Xây dựng một ứng dụng quản lý mini hoàn chỉnh có khả năng Đọc (Read), Thêm (Create) và Xóa (Delete) các mục dữ liệu. Các thay đổi được lưu tự động xuống file. Đồng thời bao gồm cả tính năng Tìm kiếm (Search/Filter) dữ liệu theo từ khóa trực tiếp trên danh sách một cách mượt mà.
4. **Tách biệt Logic xử lý (Service Pattern):** Hiểu được tầm quan trọng của việc tách riêng đoạn code chuyên trách xử lý file (đọc/ghi) ra một file Service riêng biệt (`storage_service.dart`) thay vì nhồi nhét tất cả vào giao diện (UI), giúp mã nguồn sạch sẽ và dễ tái sử dụng.

---

## Cấu trúc mã nguồn chi tiết trong `lib/` và `assets/`

Dự án được chia thành các phần rõ rệt để thực hiện từng mục tiêu bài LAB.

### 1. File cấu hình gốc - `main.dart`
- Chứa `HomeScreen`. Đây là màn hình điều hướng chính với 3 nút bấm tương ứng với 3 bài tập (Lab 9.1, 9.2 và 9.3) để bạn dễ dàng kiểm tra độc lập từng tính năng.

### 2. Thư mục `assets/data/` (Chứa dữ liệu tĩnh)
- **`products.json`**: File dữ liệu JSON cho sẵn chứa danh sách sản phẩm mẫu. Cần được khai báo trong `pubspec.yaml` phần `assets:` để ứng dụng có thể đọc được.

### 3. Thư mục `services/` (Xử lý tập tin)
- **`storage_service.dart`**: Lớp Service trung tâm phụ trách mọi tương tác với File System. 
  - `_getFile()`: Lấy đường dẫn tới thư mục tài liệu an toàn của ứng dụng bằng `getApplicationDocumentsDirectory()` (từ package `path_provider`).
  - `readData()`: Đọc chuỗi JSON từ file và chuyển thành List object để app sử dụng. Xử lý luôn trường hợp file chưa tồn tại thì trả về mảng rỗng `[]`.
  - `writeData(List data)`: Chuyển mảng List thành chuỗi JSON (`jsonEncode`) và ghi đè xuống file.

### 4. Thư mục `screens/` (Các màn hình bài tập)
- **`lab91_screen.dart`**: 
  - Màn hình này demo tính năng nạp mảng JSON từ `assets/data/products.json` lúc khởi tạo (`initState`).
  - Phân tách chuỗi JSON bằng `jsonDecode()` sau đó kết xuất dữ liệu thành danh sách sử dụng `ListTile`.
  
- **`lab92_screen.dart`**: 
  - Giao diện gồm một ô nhập văn bản (`TextField`) và các nút "Add", "Save". 
  - Khi ấn "Add", item được sinh id bằng thời gian hiện tại (`DateTime.now().millisecondsSinceEpoch`) và lưu tạm vào mảng.
  - Khi ấn "Save", gọi `storage.writeData(items)` để lưu mảng này thành file tạm trên máy. Nó sử dụng `ScaffoldMessenger` để hiện thông báo lưu thành công.

- **`lab93_screen.dart`**: 
  - Là phiên bản nâng cấp của 9.2, thực hiện các thay đổi phức tạp hơn.
  - Khi vừa mở lên, nó sẽ nạp dữ liệu từ file local vào (`load()`).
  - **Tự động lưu (autoSave):** Mỗi khi bấm Cọng (Add) hoặc Xoá (Delete), app tự động gọi ghi lại toàn bộ danh sách xuống file nhằm tránh mất dữ liệu thay vì phải bấm Save thủ công.
  - **Tính năng Tìm kiếm:** Gắn sự kiện `onChanged` vào `TextField`, mỗi ký tự gõ vào sẽ qua hàm `search()` để lọc (`.where()`) mảng gốc thành một mảng `filtered` và lập tức hiển thị lên màn hình.

---

