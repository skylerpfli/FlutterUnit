import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_conch_plugin/annotation/conch_scope.dart';
import 'package:flutter_conch_plugin/conch_dispatch.dart';
import 'package:flutter_unit/plateform_adapter/window/window_size_helper.dart';

import 'app/views/navigation/bloc_wrapper.dart';
import 'app/views/navigation/flutter_unit.dart';

bool useConch = true;

@ConchScope()
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 加载conch
  if (useConch) {
    var source = await rootBundle.load('assets/conch_data/conch_result.dat');
    ConchDispatch.instance.loadByteSource(source);
  }

  //滚动性能优化 1.22.0
  GestureBinding.instance.resamplingEnabled = true;
  runApp(useConch ? ConchDispatch.instance.createObject('package:flutter_unit/main.dart', "RawEntryPage") as Widget : const RawEntryPage());
  WindowSizeHelper.setFixSize();
}

// 原本的页面
class RawEntryPage extends StatelessWidget {
  const RawEntryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const BlocWrapper(child: FlutterUnit());
  }
}
