import 'package:get/get.dart';
import 'package:tp05/controller/produk_controller.dart';
import 'package:tp05/data/app_database.dart';
import 'package:tp05/data/produk_dao.dart';
import 'package:tp05/data/produk_repository.dart';

class AppInjection extends Bindings {
  @override
  void dependencies() {
    Get.put(AppDatabase());
    Get.put(ProdukDao(Get.find<AppDatabase>()));
    Get.put<ProdukRepository>(SqliteProdukRepository(Get.find<ProdukDao>()));
    Get.put(ProdukController(Get.find<ProdukRepository>()));
  }
}
