import 'package:dio_calculadora_imc_hive_flutter/model/pessoa.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

class PessoaRepository {
  static late Box _box;

  PessoaRepository._criar();

  static Future<PessoaRepository> carregar() async {
    if (Hive.isBoxOpen("pessoas")) {
      _box = Hive.box("pessoas");
    } else {
      var documentsDirectory =
          await path_provider.getApplicationDocumentsDirectory();
      Hive.init(documentsDirectory.path);
      _box = await Hive.openBox("pessoas");
    }

    return PessoaRepository._criar();
  }

  void salvar(Pessoa pessoa) {
    _box.add(pessoa);
  }

  List<Pessoa> obterDados() {
    return _box.values.cast<Pessoa>().toList();
  }
}
