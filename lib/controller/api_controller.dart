import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';

import '../model/api_response.dart';
import '../model/reciters.dart';

import 'package:http/http.dart' as http;

class ApiController {
  //get Tafsir of aya
  Future<ApiResponse> getTafsir(
      {required String aya, required String sura}) async {
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      // if (connectivityResult == ConnectivityResult.none) {
      if (connectivityResult.contains(ConnectivityResult.none)) {
        return ApiResponse(message: 'لا يوجد اتصال بالإنترنت', status: false);
      }

      Uri url = Uri.parse('http://api.quran-tafseer.com/tafseer/1/$sura/$aya');
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
        return ApiResponse(message: jsonResponse['text'], status: true);
      } else {
        return ApiResponse(
            message: 'خطأ أثناء استرداد البيانات', status: false);
      }
    } catch (e) {
      return ApiResponse(message: 'حدث خطأ غير متوقع', status: false);
    }
  }

  //get 222 Reciters

  Future<List<Reciters>> getReciters() async {
    Uri url = Uri.parse("https://www.mp3quran.net/api/v3/reciters?language=ar");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var jsonArray = jsonResponse['reciters'] as List;
      List<Reciters> data = jsonArray.map((e) => Reciters.fromJson(e)).toList();
      return data;
    }
    return [];
  }
}
