import 'package:addu_sis/addu_sis.dart';
void main() async {
  var sis = SIS('username', 'password');
  print((await sis.getUser()).all());
  print((await sis.getCurriculum()).all());
  print((await sis.getRegistration()).all());
  //joe.request('grades').then((value) => print(value['response']));
}
