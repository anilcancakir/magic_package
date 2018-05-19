main() {
  Map<String, dynamic> a = {
    'foo': 'bar',
    'lorem': 'ipsum'
  };

  Uri uri = Uri.parse('users');
  print(uri.toString());

  uri = uri.replace(queryParameters: a);
  print(uri.toString());
}