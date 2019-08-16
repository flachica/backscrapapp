import 'package:backscrapapp/src/resources/env.dart';

void main() => ApiFromLocal();

class ApiFromLocal extends Env {
  final String apiURL = 'http://192.168.1.131:8000/';
}