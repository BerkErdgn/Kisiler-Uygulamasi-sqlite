
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kisiler_uygulamasi/ui/cubit/anasayfa_cubit.dart';
import 'package:kisiler_uygulamasi/ui/views/detay_sayfa.dart';
import 'package:kisiler_uygulamasi/ui/views/kayit_sayfa.dart';

import '../../data/entity/kisiler.dart';

class Anaysayfa extends StatefulWidget {
  const Anaysayfa({super.key});

  @override
  State<Anaysayfa> createState() => _AnaysayfaState();
}

class _AnaysayfaState extends State<Anaysayfa> {
  bool aramaYapiliyorMu = false;





  @override
  void initState() {
    super.initState();
    context.read<AnasayfaCubit>().kisisleriYukle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: aramaYapiliyorMu ?
         TextField(
           decoration: const InputDecoration(hintText: "Ara"),
           onChanged: (aramaSonucu){
             context.read<AnasayfaCubit>().ara(aramaSonucu);
           },
         ) :
        const Text("Kisiler"),
        actions: [
          aramaYapiliyorMu ?
          IconButton(onPressed: (){
            setState(() {
              aramaYapiliyorMu = false;
              context.read<AnasayfaCubit>().kisisleriYukle();
            });
          },
              icon: Icon(Icons.clear)) :
          IconButton(onPressed: (){
            setState(() {
              aramaYapiliyorMu = true;
            });
          },
              icon: Icon(Icons.search))
        ],
      ),
      body: BlocBuilder<AnasayfaCubit,List<Kisiler>>(
        builder: (context,kisilerListesi){
          if(kisilerListesi.isNotEmpty){
            return ListView.builder(
              itemCount: kisilerListesi.length, //3
              itemBuilder: (context, indeks){//0,1,2
                  var kisi = kisilerListesi[indeks];
                  return GestureDetector(
                    onTap: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context) => DetaySayfa(kisi: kisi)))
                          .then((value) {
                        print("Anasayfaya Dönüldü");
                        context.read<AnasayfaCubit>().kisisleriYukle();
                      });
                    },
                    child: Card(
                      child: SizedBox( height: 100,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(kisi.kisi_ad,style: const TextStyle(fontSize: 20),),
                                  Text(kisi.kisi_tel),
                                ],
                              ),
                            ),
                            const Spacer(),
                            IconButton(onPressed: (){
                              setState(() {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text("${kisi.kisi_ad} silinsin mi ?"),
                                      action: SnackBarAction(
                                        label: "Evet",
                                        onPressed: (){
                                          context.read<AnasayfaCubit>().sil(kisi.kisi_id);
                                        },
                                      ),
                                    )
                                );
                              });
                            },
                                icon: const Icon(Icons.clear,color: Colors.black54,),)
                          ],
                        ),
                      ),
                    ),
                  );
              },
            );
          }else{
            return const Center();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context,MaterialPageRoute(builder: (context) => const KayitSayfa()))
              .then((value) {
            context.read<AnasayfaCubit>().kisisleriYukle();
          });
        },
        child: const Icon(Icons.add),
      ) ,
    );
  }
}
