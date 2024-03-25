import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kisiler_uygulamasi/data/repo/kisilerdao_repository.dart';

import '../../data/entity/kisiler.dart';

class AnasayfaCubit extends Cubit<List<Kisiler>>{
  AnasayfaCubit():super(<Kisiler>[]);

  var krepo = KisilerDaoRepository();

  Future<void> kisisleriYukle () async{
    var list = await krepo.kisisleriYukle();
    emit(list);
  }

  Future<void> ara (String aramaKelimesi) async{
    var list = await krepo.ara(aramaKelimesi);
    emit(list);
  }

  Future<void> sil (int kisi_id) async{
    await krepo.sil(kisi_id);
    await kisisleriYukle();
  }

}