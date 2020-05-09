import 'package:addu_sis/addu_sis.dart';
void main() async {
  var sis = SIS('sonraalmerol', 'AdDU2201901285413');
  print((await sis.getUser()).all());
  print((await sis.getCurriculum()).all());
  print((await sis.getRegistration()).all());
  //joe.request('grades').then((value) => print(value['response']));
}
