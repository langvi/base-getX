# base_getx

A template app Flutter using GetX

## Giới thiệu
### 1. Base controller
 Kế thừa getxController, bổ sung isShowLoading và func setLoading sử dụng cho việc ẩn hoặc hiện loading.
 - isShowLoading = true => show loading
 - isShowLoading = false => hide loading
```
abstract class BaseGetXOldController extends GetxController {
  RxBool isShowLoading = false.obs;
  void setLoading(bool isShow){
    isShowLoading.value = isShow;
  }
  ....
}
```
 Tương tác với view
 example
```
 Widget buildLoading({required Widget child}) {
    return Stack(
      children: <Widget>[
        child,
        Obx(() {
          return Visibility(
              visible: controller.isShowLoading.value,
              child: buildViewLoading());
        }),
      ],
    );
  }
```
### 2. Base getview
```
abstract class BaseGetWidget<T extends BaseGetXOldController> extends GetView<T>{
...
}
```
Khi kế thừa base này sẽ cần 1 controller có type là BaseGetXOldController, đồng thời override lại
func *build* của **GetView**
- Example
```
@override
  Widget build(BuildContext context) {
    return ...;
  }
```
Khởi tạo controller
- Example
```
@override
  WeatherController get controller => Get.put(WeatherController());
```

### 3. Cách sử dụng Get để setState cho widget
- Get có nhiều cách để quản lí 1 state như sử dụng GetBuilder, ValueBuilder, ObxValue, Obx
- GetBuilder thường sẽ được đặt tại widget root(gốc) để render lại toàn bộ các widget con
- Obx là một đối tượng tương tự StreamBuilder, nó sẽ lắng nghe sự thay đổi dữ liệu và render lại view,
thường được sử dụng để render các local widget
- Tham khảo thêm tại (https://pub.dev/packages/get#obxvalue)
- Cách triển khai trong dự án:
#### 3.1 Tạo một controller
- controller này sẽ kế thừa **BaseGetXOldController** 
- Example:
```
class WeatherController extends BaseGetXOldController {
...
}
```
#### 3.2 Tạo một view
- view là giao diện tương ứng với controller đã tạo ở trên
- Example:
```
class WeatherPage extends BaseGetViewApp<WeatherController> {
  @override
  WeatherController get controller => Get.put(WeatherController());

  @override
  Widget build(BuildContext context) {
...
}
```
#### 3.3 setState với Obx
- Tạo một object với type Rx
- Exampe:
```
 Rx<Weather> weather = Weather.init().obs;
 void getWeather(String location) async {
    setLoading(true);
    weather.value = await _repository.getInfoWeatherByLocation(location);
    weather.value.detailWeather =
        await _repository.getDetailWeatherByLocation(weather.value.woeid);
    if (weather.value.detailWeather != null) {
      weather.subject.add(weather.value);
    }
    setLoading(false);
  }
```
- View:
```
 Obx(() {
   return _buildContent();
})
...
Widget _buildContent() {
    final weather = controller.weather.value;

    if (weather.detailWeather == null) {
      return Container();
    }
    return Column(
      children: [
        Text(weather.title),
        Text('Nhiệt độ tại ${weather.title} là ${weather.getTemp()} '),
      ],
    );
  }
```
### 4. Kết nối với API(sử dụng lib Dio)
- Dio sử dụng Restful API để kết nối với server gồm 4 phương thức thường dùng là: GET, POST, PUT, DELETE
- Tham khảo thêm về Restful API tại (https://topdev.vn/blog/restful-api-la-gi/)
- Lớp abstract của request:
```
abstract class BaseRequest {
  Future<dynamic> sendRequest(
      {required String path,
      required RequestMethod requestMethod,
      dynamic body,
      dynamic param,
      bool sendHeader = true,
      bool isHandleError = true,
      void Function(int, int)? onProgress});

  Future<Map<String, dynamic>> getBaseHeader();

  void showError(String error, int statusCode);

  void handleDioError(DioError dioError);
}

```
- Ví dụ về cách implement:
```
class BaseRequestImpl extends BaseRequest {
  static Dio dio = Dio();
  static final _singleton = BaseRequestImpl._internal();
  int _numberOfDialog = 0;

  factory BaseRequestImpl({required String baseUrl}) {
    dio.options.connectTimeout = CONNECT_TIMEOUT;
    dio.options.baseUrl = baseUrl;
    return _singleton;
  }

  BaseRequestImpl._internal();

  @override
  Future<Map<String, dynamic>> getBaseHeader() async {
    final String token = await StorageApp.getTokenAuthen();
    Map<String, String> map = {
      'Authorization': 'Bearer $token',
    };
    return map;
  }

  @override
  Future<dynamic> sendRequest(
      {required String path,
      required RequestMethod requestMethod,
      body,
      param,
      bool sendHeader = true,
      bool isHandleError = true,
      void Function(int, int)? onProgress}) async {
    Response? response;
    try {
      if (requestMethod == RequestMethod.GET) {
        response = await dio.get(
          path,
          queryParameters: param,
          onReceiveProgress: onProgress,
          options: Options(headers: sendHeader ? await getBaseHeader() : null),
        );
      } else if (requestMethod == RequestMethod.POST) {
        response = await dio.post(
          path,
          queryParameters: param,
          data: body,
          onReceiveProgress: onProgress,
          options: Options(headers: sendHeader ? await getBaseHeader() : null),
        );
      } else if (requestMethod == RequestMethod.PUT) {
        response = await dio.put(
          path,
          queryParameters: param,
          data: body,
          onReceiveProgress: onProgress,
          options: Options(headers: sendHeader ? await getBaseHeader() : null),
        );
      } else {
        response = await dio.delete(
          path,
          queryParameters: param,
          data: body,
          options: Options(headers: sendHeader ? await getBaseHeader() : null),
        );
      }
    } catch (err) {
      print(err);
      if (err is DioError && isHandleError) {
        handleDioError(err);
      }
      return null;
    }
    return response.data;
  }
...
}
```
### 5. Xử lí ngoại lệ(Exception) khi kết nối với API(sử dụng lib Dio)
- Khi kết nối với API có thể xảy ra nhiều ngoại lệ như lỗi kết nối, request không chính xác, response trả về lỗi,
convert data từ json lỗi...
Để xử lí các exception này cần override lại 2 function *showError()* và *handleDioError(DioError dioError)*:
```
@override
void showError(String error, int statusCode) async {
  ...
}
@override
void handleDioError(DioError dioError) {
    ...
}
```

### 6. Navigation sử dụng getx
- Chuyển đến một page mới
```
Get.to(NextScreen());
```
- Đóng page hiện tại
```
Get.back();
```
- Chuyển đến một page mới và đóng page trước đó
```
Get.off(NextScreen());
```
- Chuyển đến một page mới và đóng tất cả các page trước đó
```
Get.offAll(NextScreen());
```
