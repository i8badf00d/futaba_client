import 'package:futaba_client/entity/board.dart';

class BoardRepository {
  Future<List<Board>> fetchBoards() async {
    return [
      Board(
        name: '二次元裏may',
        baseUrl: Uri.https('may.2chan.net', '/b/'),
      ),
      Board(
        name: '二次元裏img',
        baseUrl: Uri.https('img.2chan.net', '/b/'),
      ),
      Board(
        name: '二次元裏jun',
        baseUrl: Uri.https('jun.2chan.net', '/b/'),
      ),
    ];
  }
}
