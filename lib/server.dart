import 'dart:developer';

// import 'dart:io';

import 'package:alfred/alfred.dart';
import 'package:get_storage/get_storage.dart'; // More detail: https://pub.dev/packages/alfred

class LocalServer {
  LocalServer({this.port = 3000});
  int port;

  Future<void> start() async {
    // start server
    final app = Alfred();
    final storage = GetStorage('local-server');
    // Define the routes
    app.post('/sensor', (req, res) async {
      final body = await req.body; //JSON body
      log('Received data: ${body.toString()}');
      storage.write('receivedData', body.toString());
      res.send('ok');
    });
    log('Server is listening on port $port');
    await app.listen(port);
  }
}
