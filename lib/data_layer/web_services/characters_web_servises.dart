import '../../helper/global_config.dart';
import 'package:dio/dio.dart';

class CharactersWebServices {
  late Dio dio;
  CharactersWebServices() {
    BaseOptions baseOptions = BaseOptions(
      baseUrl: GlobalConfigs.baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: 20 * 1000,
      sendTimeout: 20 * 1000,
    );

    dio = Dio(baseOptions);

    
  }
  
    Future<dynamic>  getallchatacters() async {
      try {
        Response response = await dio.get('characters');

        print('response data ' + response.data.toString());
        return response.data;
      } catch (e) {
        print(e.toString());
        return {};
      }
    }

     Future<dynamic>  getcharacterQuote(String autherName) async {
      try {
        Response response = await dio.get('quote' ,queryParameters: {'author':autherName});

        print('response data ' + response.data.toString());
        return response.data;
      } catch (e) {
        print(e.toString());
        return {};
      }
    }
}
