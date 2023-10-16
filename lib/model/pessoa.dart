import 'dart:math';
import 'package:hive/hive.dart';

part 'pessoa.g.dart';

@HiveType(typeId: 1)
class Pessoa extends HiveObject {
  @HiveField(0)
  String _nome = "";

  @HiveField(1)
  double _peso = 0.0;

  @HiveField(2)
  double _altura = 0.0;

  Pessoa();

  Pessoa.criar(String nome, double peso, double altura) {
    setNome(nome);
    setPeso(peso);
    setAltura(altura);
  }

  String get nome => _nome;
  void setNome(String nome) {
    final numero = double.tryParse(nome);
    if (numero != null) throw ArgumentError("Nome inválido!");

    _nome = nome;
  }

  String get peso => _peso.toStringAsFixed(2);
  void setPeso(double peso) {
    _peso = peso;
  }

  String get altura => _altura.toStringAsFixed(2);
  void setAltura(double altura) {
    _altura = altura;
  }

  String calcularIMC() {
    double imc = _peso / pow(_altura, 2);
    return imc.toStringAsFixed(2);
  }

  String classificacaoIMC() {
    double imc = double.parse(calcularIMC());

    if (imc < 16) return "Magreza grave";
    if (imc < 17) return "Magreza moderada";
    if (imc < 18.5) return "Magreza leve";
    if (imc < 25) return "Saudável";
    if (imc < 30) return "Sobrepeso";
    if (imc < 35) return "Obesidade Grau I";
    if (imc < 40) return "Obesidade Grau II (severa)";
    if (imc >= 40) return "Obesidade Grau III (mórbida)";
    return "";
  }

  @override
  String toString() {
    return {
      "Nome": _nome,
      "Peso": _peso,
      "Altura": _altura,
      "IMC": "${calcularIMC()} - ${classificacaoIMC()}"
    }.toString();
  }
}
