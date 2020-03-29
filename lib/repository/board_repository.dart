import 'package:futaba_client/entity/futaba_board.dart';

class BoardRepository {
  Future<List<FutabaBoard>> fetchBoards() async {
    return [
      FutabaBoard(
        name: '二次元裏may',
        baseUrl: Uri.https('may.2chan.net', '/b/'),
      ),
      FutabaBoard(
        name: '二次元裏img',
        baseUrl: Uri.https('img.2chan.net', '/b/'),
      ),
      FutabaBoard(
        name: '二次元裏jun',
        baseUrl: Uri.https('jun.2chan.net', '/b/'),
      ),
    ];
  }
}
