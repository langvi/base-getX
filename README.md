# base_getx

A template app Flutter using GetX

## Giới thiệu
### 1. Base controller
 Kế thừa getxController, bổ sung isShowLoading và func setLoading sử dụng cho việc ẩn hoặc hiện loading.
 - isShowLoading = true => show loading
 - isShowLoading = false => hide loading
```
abstract class BaseGetXController extends GetxController {
  RxBool isShowLoading = false.obs;
  void setLoading(bool isShow){
    isShowLoading.subject.add(isShow);
    isShowLoading = isShow.obs;
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
Getview được implement thêm Bindings để init dependencies
Link thông tin thêm về Bindings (https://medium.com/flutter-community/the-flutter-getx-ecosystem-dependency-injection-8e763d0ec6b9)
```
abstract class GetViewBindings<C extends BaseGetXController> extends GetView<C>
    implements Bindings {
}
```
Khi kế thừa base này sẽ cần 1 controller có type là BaseGetXController, đồng thời override lại
func *build* của **Stateless** và dependencies của **Bindings**
- Example
```
 @override
  void dependencies() {
    initDependencies();
    setCallBackError(handleDioError);
  }
@override
  Widget build(BuildContext context) {
    return builder(context);
  }
```
### 3. Base Stateful get + base stateless get
Class implement lại stateful(stateless), tạo ra controller của Getx để quản lí state
```
abstract class BaseStatefulGet<SF extends StatefulWidget, C extends BaseGetXController> extends State<SF> {
  late final C controller;

  void initController();

  Widget builder(BuildContext context);

  @override
  void initState() {
    initController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<C>(
      builder: (controller) {
        return builder(context);
      },
    );
  }
...
}
```
- Example:
Luôn khởi tạo controller ở trong initController
```
class _MyAppState extends BaseStatefulGet<MyApp, AppController> {
  @override
  void initController() {
    controller = Get.put(AppController());
  }
  @override
  Widget builder(BuildContext context) {
    return Container();
```
GetBuilder là một widget của GetX, nó sẽ render lại các widget con khi gọi đến hàm
```
controller.update();
```
tương tự *setState* trong **StatefulWidget** và *emit()* trong bloc(cubit)

### 4. Cách sử dụng Get để setState cho widget
- Get có nhiều cách để quản lí 1 state như sử dụng GetBuilder, ValueBuilder, ObxValue, Obx
- GetBuilder thường sẽ được đặt tại widget root(gốc) để render lại toàn bộ các widget con
- Obx là một đối tượng tương tự StreamBuilder, nó sẽ lắng nghe sự thay đổi dữ liệu và render lại view,
thường được sử dụng để render các local widget
- Tham khảo thêm tại (https://pub.dev/packages/get#obxvalue)
- Cách triển khai trong dự án:
#### 4.1 Tạo một controller
- controller này sẽ kế thừa **BaseGetXController** 
- Example:
```
class WeatherController extends BaseGetXController {
...
}
```
#### 4.2 Tạo một view
- view là giao diện tương ứng với controller đã tạo ở trên
- Example:
```
class WeatherPage extends BaseGetViewApp<WeatherController> {
  @override
  void initDependencies() {
    Get.lazyPut(() => WeatherController());
  }

  @override
  Widget builder(BuildContext context) {
...
}
```
#### 4.2 setState với Obx
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
    final weather = _weatherController.weather.value;
    if (weather.detailWeather == null) {
      return  Container();
    }
    return Column(
      children: [
        Text(weather.title),
        Text(
            'Nhiệt độ tại ${weather.title} là ${weather.getTemp()} '),
      ],
    );
  }
```
### 5. Kết nối với API(sử dụng lib Dio)
- Dio sử dụng Restful API để kết nối với server gồm 4 phương thức thường dùng là: GET, POST, PUT, DELETE
- Tham khảo thêm về Restful API tại (https://topdev.vn/blog/restful-api-la-gi/)
- Lớp abstract của request:
```
abstract class AbstractRequest {
  Future<dynamic> sendGetRequest(String path, {dynamic queryParams});

  Future<dynamic> sendPostRequest(String path, {dynamic body, Map<String, dynamic>? param, bool sendHeader = true});

  Future<dynamic> sendPutRequest(String path, {Map<String, dynamic>? body, Map<String, dynamic>? param});

  Future<dynamic> sendDeleteRequest(String path, {Map<String, dynamic>? queryParams});

  Future<Map<String, dynamic>> getBaseHeader();
}
```
- Ví dụ về cách implement:
```
class BaseRequest extends AbstractRequest {
  static Dio dio = Dio();
  static final _singleton = BaseRequest._internal();

  factory BaseRequest({required String baseUrl}) {
    dio.options.connectTimeout = CONNECT_TIMEOUT;
    dio.options.baseUrl = baseUrl;
    return _singleton;
  }

  BaseRequest._internal();

  @override
  Future<dynamic> sendGetRequest(String path, {dynamic queryParams, bool sendHeader = true}) async {
    late Response response;
    response = await dio.get(
      path,
      queryParameters: queryParams,
      options: Options(headers: sendHeader ? await getBaseHeader() : null),
    );
    return response.data;
  }
...
}
```
### 6. Xử lí ngoại lệ(Exception) khi kết nối với API(sử dụng lib Dio)
- Khi kết nối với API có thể xảy ra nhiều ngoại lệ như lỗi kết nối, request không chính xác, response trả về lỗi,
convert data từ json lỗi...
Để xử lí các exception này hàm main ta xử lí như sau:
```
void main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    runApp(MyApp());
  }, (error, stackTrace) {
    if (error is DioError) {
      print(error);
      HandleException.instance.handleExceptionAsync(error, stackTrace);
    } else {
      throw error;
    }
  });
}
```
function *handleExceptionAsync* xử lí các ngoại lệ của DiorError, chi tiết hơn thì xem trong project example
### 7. Navigation sử dụng getx
- Chuyển hướng màn hình sử dụng get sẽ không cần truyền context vào
- Dưới đây là navigator đối với các view có implement  bindings:
```
/// Chuyển đến màn mới có sử dụng getview
void navToScreen(
    {required GetViewBindings toPage,
    Transition transition = Transition.leftToRight,
    void Function()? callBack}) async {
  await Get.to(() => toPage, transition: transition, binding: toPage);
  if (callBack != null) {
    callBack();
  }
}
/// Chuyển đến màn mới sử dụng getview và đóng tất cả các màn trước nó
void navToScreenReplaceAll(
    {required GetViewBindings toPage,
    Transition transition = Transition.leftToRight,
    void Function()? callBack}) async {
  Get.offAll(() => toPage, transition: transition, binding: toPage);
  if (callBack != null) {
    callBack();
  }
}
```
- Dưới đây là navigator đối với các view không implement bindings(như stateless, stateful...):
```
/// Chuyển đến màn mới không sử dụng getview
void navToScreenAnother(
    {required Widget toPage, void Function()? callBack}) async {
  await Get.to(() => toPage, transition: Transition.leftToRight);
  if (callBack != null) {
    callBack();
  }
}
/// Chuyển đến màn mới không sử dụng getview và đóng tất cả các màn trước nó
void navToScreenAnotherReplaceAll(
    {required Widget toPage, void Function()? callBack}) async {
  await Get.offAll(() => toPage, transition: Transition.leftToRight);
  if (callBack != null) {
    callBack();
  }
}
```