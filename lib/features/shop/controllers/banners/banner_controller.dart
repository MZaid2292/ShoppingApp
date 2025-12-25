
import 'package:carousel_slider/carousel_controller.dart';

import 'package:e_commerce/data/repositories/banners/banner_repository.dart';
import 'package:e_commerce/features/shop/models/banners_model.dart';
import 'package:e_commerce/utils/popups/snackbar_screen.dart';
import 'package:get/get.dart';

class BannerController extends GetxController{

  static BannerController get instance => Get.find();


  /// Variables
  final _repository = Get.put(BannerRepository());
  RxList<BannerModel> banners = <BannerModel> [].obs;
  RxBool isLoading = false.obs;

  ///Variables
  final carouselController = CarouselSliderController();
  RxInt currentIndex = 0.obs;


  @override
  void onInit() {
    fetchBanners();
    super.onInit();
  }



  ///On Carousel Page Changed
  void onPageChanged(int index){
    currentIndex.value = index;
  }

  /// Fetch All Banners
  Future<void> fetchBanners() async{

    try{

      // Start Loading
      isLoading.value = true;

      List<BannerModel> activeBanners = await _repository.fetchActiveBanners();
      banners.assignAll(activeBanners);

    }catch(e){
      ZSnackBarHelpers.errorSnackBar(title: "Failed",message: e.toString());
    }finally{
      isLoading.value = false;
    }
  }
}