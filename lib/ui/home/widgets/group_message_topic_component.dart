import 'package:flutter/material.dart';

class GroupMessageTopicComponent extends StatelessWidget {
  final Map<String, dynamic> mensagem;

  const GroupMessageTopicComponent({super.key, required this.mensagem});

  @override
  Widget build(BuildContext context) {
    double screenSize = MediaQuery.sizeOf(context).width;
    return Container(
      width: screenSize - screenSize / 10,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 4,
            spreadRadius: 1,
          ),
        ],
      ),
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Titulo(
            horario: mensagem['horario'],
            prioridade: mensagem['prioridade'],
          ),
          Column(
            children: List.generate(
              mensagem['poluentes'].length,
              (index) => Column(
                children: [
                  Divider(),
                  PoluenteWidget(
                    nome: mensagem['poluentes'][index]['nome'],
                    prioridade: mensagem['poluentes'][index]['prioridade'],
                    efeitos: mensagem['poluentes'][index]['efeitos'],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PoluenteWidget extends StatelessWidget {
  final String nome;
  final String prioridade;
  final List<String> efeitos;

  const PoluenteWidget({
    super.key,
    required this.nome,
    required this.prioridade,
    required this.efeitos,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Color(0xfff3f4f6),
            borderRadius: BorderRadius.circular(5),
          ),
          height: 40,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.air, color: Color(0xffb7d6f3)),
                SizedBox(width: 7),
                RichText(
                  text: TextSpan(
                    style: const TextStyle(fontSize: 14, color: Colors.black),
                    children: [
                      TextSpan(
                        text: 'Poluente: ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: nome),
                    ],
                  ),
                ),
                Spacer(),
                PrioridadeWidget(prioridade: prioridade),
              ],
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Color(0xfffee2e1),
            border: BoxBorder.fromLTRB(
              left: BorderSide(color: Colors.redAccent, width: 3),
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            children: [
              SizedBox(height: 10),
              Row(
                spacing: 10,
                children: [
                  SizedBox(width: 10),
                  Icon(Icons.warning, color: Colors.amber),
                  Text(
                    "Possíveis efeitos na saúde:",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: const Color.fromARGB(255, 138, 38, 31),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  children: efeitos.map((efeito) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(width: 35),
                        Text(
                          '\u2022',
                          style: TextStyle(
                            fontSize: 18,
                            color: const Color.fromARGB(255, 138, 38, 31),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            efeito,
                            style: TextStyle(
                              color: const Color.fromARGB(255, 138, 38, 31),
                            ),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class PrioridadeWidget extends StatelessWidget {
  final String prioridade;
  const PrioridadeWidget({super.key, required this.prioridade});

  Map<String, Color> _getCores() {
    switch (prioridade) {
      case 'alta':
        return {
          'fundo': Color(0xfffee2e1),
          'fonte': Color.fromARGB(255, 138, 38, 31),
        };
      case 'moderada':
        return {
          'fundo': Color(0xfffef3c4),
          'fonte': Color.fromARGB(255, 151, 134, 57),
        };
      case 'baixa':
        return {'fundo': Color(0xffdbfde5), 'fonte': Colors.green};
      default:
        return {'fundo': Colors.grey, 'fonte': Colors.black};
    }
  }

  @override
  Widget build(BuildContext context) {
    final cores = _getCores();

    return Container(
      decoration: BoxDecoration(
        color: cores['fundo'],
        borderRadius: BorderRadius.circular(5),
      ),
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      child: Text(
        prioridade,
        style: TextStyle(color: cores['fonte'], fontSize: 12),
      ),
    );
  }
}

class Titulo extends StatelessWidget {
  final String horario;
  final String prioridade;

  const Titulo({super.key, required this.prioridade, required this.horario});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Icon(Icons.push_pin),
        SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Mensagem do grupo",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            Text(
              horario,
              style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
            ),
          ],
        ),
        Spacer(),
        PrioridadeWidget(prioridade: prioridade),
      ],
    );
  }
}
