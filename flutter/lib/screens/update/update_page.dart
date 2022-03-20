import 'package:fluent_ui/fluent_ui.dart';

class UpdatePage extends StatefulWidget {
  const UpdatePage({Key? key}) : super(key: key);

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Text("1시간에 60번 요청밖에 안됨.\n서버를 생성, 토큰 관리해야 구현가능.");
  }
}
