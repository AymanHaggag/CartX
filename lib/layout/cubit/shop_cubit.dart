import 'package:catrx/layout/cubit/shop_states.dart';
import 'package:catrx/models/cart_model.dart';
import 'package:catrx/models/faq_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../models/categories_model.dart';
import '../../models/favorites_model.dart';
import '../../models/home_Model.dart';
import '../../models/search_model.dart';
import '../../modules/categories/categories_screen.dart';
import '../../modules/favorite/favorite_screen.dart';
import '../../modules/products/products_screen.dart';
import '../../modules/settings/settings_Screen.dart';
import '../../shared/constant.dart';
import '../../shared/local/sheared_preferances.dart';
import '../../shared/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> screensList = [
    const ProductsScreen(),
    const CategoriesScreen(),
    const FavoritesScreen(),
    const SettingsScreen(),
  ];
  void changeNavigationBar(index) {
    currentIndex = index;
    emit(ShopChangeNavigationBarState());
  }

  HomeModel? homeModel;
  Map<int, bool> favoritesMap = {};
  Map<int, bool> cartMap = {};
  void getHomeData() {
    emit(ShopGetDataLoadingState());

    DioHelper.getData(
      url: "https://student.valuxapps.com/api/home",
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel!.data!.products.forEach((element) {
        favoritesMap.addAll({element.id as int: element.inFavorites as bool});
        cartMap.addAll({element.id as int: element.inCart as bool});
      });
      emit(ShopGetHomeSuccessfulState());
    }).catchError((error) {
      debugPrint("Error while getting home data ${error.toString()}");
      emit(ShopGetHomeErrorState());
    });
  }

  CategoriesModel? categoriesModel;
  void getCategoriesData() {
    emit(ShopGetDataLoadingState());
    DioHelper.getData(
      url: "https://student.valuxapps.com/api/categories",
      token: token,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      debugPrint(categoriesModel!.data!.data[0].name);
      emit(ShopGetCategoriesSuccessfulState());
    }).catchError((error) {
      debugPrint("Error while getting Categories data ${error.toString()}");
      emit(ShopGetCategoriesErrorState());
    });
  }

  AddRemoveFavoriteItemModel? addRemoveFavoriteModel;
  void changeFavorites(int productId) {
    bool isFav = favoritesMap[productId] as bool;
    isFav = !isFav;
    favoritesMap[productId] = isFav;
    emit(ShopChangeFavoritesState());

    DioHelper.postData(
      url: "https://student.valuxapps.com/api/favorites",
      token: token,
      data: {
        "product_id": productId,
      },
    ).then((value) {
      addRemoveFavoriteModel = AddRemoveFavoriteItemModel.fromJson(value.data);
      //علشان handle زرار favorites لما تكون status ب false
      if (!addRemoveFavoriteModel!.status) {
        isFav = !isFav;
        favoritesMap[productId] = isFav;
      }
      debugPrint(addRemoveFavoriteModel!.message);
      emit(ShopChangeFavoritesSuccessfulState(addRemoveFavoriteModel!));
    }).catchError((error) {
      debugPrint("Error while Change Favorites data ${error.toString()}");
      //علشان handle زرار favorites لما error يحصل
      isFav = !isFav;
      favoritesMap[productId] = isFav;
      emit(ShopChangeFavoritesErrorState());
    });
  }

  ChangeCartModel? changeCartModel;
  void changeCart(int productId) {
    bool isCart = cartMap[productId] as bool;
    isCart = !isCart;
    cartMap[productId] = isCart;
    emit(ShopChangeCartState());

    DioHelper.postData(
      url: "https://student.valuxapps.com/api/favorites",
      token: token,
      data: {
        "product_id": productId,
      },
    ).then((value) {
      changeCartModel = ChangeCartModel.fromJson(value.data);
      //علشان handle زرار favorites لما تكون status ب false
      if (!changeCartModel!.status!) {
        isCart = !isCart;
        cartMap[productId] = isCart;
      }
      debugPrint(changeCartModel!.message);
      emit(ShopChangeCartSuccessfulState());
    }).catchError((error) {
      debugPrint("Error while Change Cart data ${error.toString()}");
      //علشان handle زرار favorites لما error يحصل
      isCart = !isCart;
      cartMap[productId] = isCart;
      emit(ShopChangeCartErrorState());
    });
  }

  FavoritesModel? favoritesModel;
  void getFavorites() {
    DioHelper.getData(
      url: "https://student.valuxapps.com/api/favorites",
      token: token,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      emit(ShopGetFavoritesSuccessfulState(favoritesModel!));
    }).catchError((error) {
      debugPrint("Error while Get Favorites data ${error.toString()}");
      emit(ShopGetFavoritesErrorState());
    });
  }

  CartModel? cartModel;
  void getCart() {
    DioHelper.getData(
      url: "https://student.valuxapps.com/api/carts",
      token: token,
    ).then((value) {
      cartModel = CartModel.fromJson(value.data);
      print(cartModel!.data!.cartItems![0].product!.name as String);
      emit(ShopGetCartSuccessfulState());
    }).catchError((error) {
      debugPrint("Error while Get Cart data ${error.toString()}");
      emit(ShopGetCartErrorState());
    });
  }

  SearchModel? searchModel;
  void search(String searchText) {
    emit(ShopSearchLoadingState());
    debugPrint(token);

    DioHelper.postData(
      url: "https://student.valuxapps.com/api/products/search",
      token: token,
      data: {
        "text": searchText,
      },
    ).then((value) {
      searchModel = SearchModel.fromJson(value.data);
      emit(ShopSearchSuccessfulState());
    }).catchError((error) {
      debugPrint("Search Error ${error.toString()}");
      emit(ShopSearchErrorState());
    });
  }

  bool isDark = false;
  void changeTheme() {
    isDark = !isDark;
    CacheHelper.saveData(key: "isDark", value: isDark);
    emit(ShopChangeThemeState());
  }

  FAQModel? faqModel;
  void getFAQs() {
    emit(ShopSearchLoadingState());


    DioHelper.getData(
      url: "https://student.valuxapps.com/api/faqs",
    ).then((value) {
      faqModel = FAQModel.fromJson(value.data);
      print(faqModel!.data!.data![0].question);
      emit(ShopGetFAQSuccessfulState());
    }).catchError((error) {
      debugPrint("Get FAQs Error ${error.toString()}");
      emit(ShopGetFAQErrorState());
    }
    );
  }

}
