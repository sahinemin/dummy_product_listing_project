import 'dart:convert';
import 'dart:io';

dynamic fixture(String fileName) =>
    jsonDecode(File('test/fixtures/$fileName').readAsStringSync());
