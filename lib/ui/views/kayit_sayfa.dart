import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kisiler_uygulamasi/ui/cubit/kayit_sayfa_cubit.dart';

class KayitSayfa extends StatefulWidget {
  const KayitSayfa({super.key});

  @override
  State<KayitSayfa> createState() => _KayitSayfaState();
}

class _KayitSayfaState extends State<KayitSayfa> {
  var tfKisiAdi = TextEditingController();
  var tfKisiTeli = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: const Text("Kayit Sayfa"),),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 50.0, right: 50.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextField(controller: tfKisiAdi,decoration: const InputDecoration(hintText: "Kişi Ad"),),
              TextField(controller: tfKisiTeli,decoration: const InputDecoration(hintText: "Kişi Tel"),),
              ElevatedButton(
                  onPressed: (){
                    context.read<KayitSayfaCubit>().kaydet(tfKisiAdi.text, tfKisiTeli.text);
                  },
                  child: const Text("Kaydet")),
            ],
          ),
        ),
      ),
    );
  }
}
