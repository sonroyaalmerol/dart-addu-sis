import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';

import 'package:addu_sis/src/models/User.dart';
import 'package:addu_sis/src/models/Balance.dart';
import 'package:addu_sis/src/models/Curriculum.dart';
import 'package:addu_sis/src/models/Grades.dart';
import 'package:addu_sis/src/models/Registration.dart';
import 'package:addu_sis/src/models/SearchResults.dart';

import 'package:html/parser.dart' as parser;

class SIS {
  String _url, _username, _password;
  var _dio, _cookieJar, _options;
  
  SIS(String username, String password) {
    _url = 'https://sis2.addu.edu.ph';
    _username = username;
    _password = password;

    _options = BaseOptions(
        baseUrl: _url,
        responseType: ResponseType.plain
    );

    _dio = Dio(_options);
    _cookieJar = CookieJar();

    _dio.interceptors.add(CookieManager(_cookieJar));
    _dio.options.contentType = Headers.formUrlEncodedContentType;
  }

  Future<Response> _request(String url) async {
    var data = {
      'name': _username,
      'pass': _password,
      'form_id': 'user_login_block',
      'op': 'Log in',
    };

    if (_cookieJar.loadForRequest(Uri.parse(_url)).isNotEmpty) {
      var x = await _dio.get('/${url}');
      return x;
    } else {
      try {
        await _dio.post('/node?destination=' + url, data: data);
      } on DioError catch (e) {
        if (e.response != null) {
          if (e.response.statusCode == 302) {
            // Redirects
            var x = await _dio.get('/${url}');
            return x;
          } else {
            print(e.response);
          }
        } else {
          print(e);
        }
      }
    }
    
    return null;
  }

  Future<User> getUser() async {
    var registration = await _request('registration');
    return User(registration.toString());
  }

  Future<Registration> getRegistration() async {
    var registration = await _request('registration');
    return Registration(registration.toString());
  }

  Future<Curriculum> getCurriculum() async {
    var curriculum = await _request('curriculum');
    return Curriculum(curriculum.toString());
  }

  Future<Grades> getGrades() async {
    var allGrades = [];
    Future<void> prevPage(String sem, String year) async {
      var page = await _request('grades/${sem}/${year}');
      if (page != null) {
        allGrades.add(page.toString());
        var document = parser.parse(page.toString());
        var _sem = document.getElementById('view-grade-form').children[0].children[4].children[7].text;
        var _year = document.getElementById('view-grade-form').children[0].children[4].children[8].text;

        if (_sem != null && _year != null) {
          await prevPage(_sem, _year);
        }
      }
    }

    var latestPage = await _request('grades');
    allGrades.add(latestPage.toString());

    var document = parser.parse(latestPage.toString());
    var _sem = document.getElementById('view-grade-form').children[0].children[4].children[7].text;
    var _year = document.getElementById('view-grade-form').children[0].children[4].children[8].text;

    if (_sem != null && _year != null) {
      await prevPage(_sem, _year);
    }

    return Grades(allGrades);
  }

  Future<Balance> getBalance() async {
    var allBalance = [];
    Future<void> prevPage(String sem, String year, String period) async {
      var page = await _request('balance/${sem}/${year}/${period}');
      if (page != null) {
        allBalance.add(page.toString());
        var document = parser.parse(page.toString());
        var _sem = document.getElementById('view-balance-form').getElementsByTagName('div')[0].children[9].text;
        var _year = document.getElementById('view-balance-form').getElementsByTagName('div')[0].children[10].text;
        var _period = document.getElementById('view-balance-form').getElementsByTagName('div')[0].children[11].text;

        if (_sem != null && _year != null) {
          await prevPage(_sem, _year, _period);
        }
      }
    }

    var latestPage = await _request('balance');
    allBalance.add(latestPage.toString());

    var document = parser.parse(latestPage.toString());
    var _sem = document.getElementById('view-balance-form').getElementsByTagName('div')[0].children[9].text;
    var _year = document.getElementById('view-balance-form').getElementsByTagName('div')[0].children[10].text;
    var _period = document.getElementById('view-balance-form').getElementsByTagName('div')[0].children[11].text;

    if (_sem != null && _year != null) {
      await prevPage(_sem, _year, _period);
    }

    return Balance(allBalance);
  }

  Future<SearchResults> searchClass(classCode) async {
    var page = await _request('search_subjects');
    var document = parser.parse(page.toString());
    var form_token = document.getElementById('inquiry-form').getElementsByTagName('div')[0].children[3].text;
    var input = {
      'classcode': classCode,
      'form_id': 'inquiry_form',
      'form_token': form_token,
      'op': 'Search'
    };

    var x = await _dio.post('/search_subjects', data: input);
    
    return SearchResults(x.toString());
  }

}
