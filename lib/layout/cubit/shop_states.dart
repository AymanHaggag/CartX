import '../../models/favorites_model.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopChangeNavigationBarState extends ShopStates {}

class ShopGetDataLoadingState extends ShopStates {}

class ShopGetHomeSuccessfulState extends ShopStates {}

class ShopGetHomeErrorState extends ShopStates {}

class ShopGetCategoriesSuccessfulState extends ShopStates {}

class ShopGetCategoriesErrorState extends ShopStates {}

class ShopGetFavoritesSuccessfulState extends ShopStates {
  final FavoritesModel model;

  ShopGetFavoritesSuccessfulState(this.model);
}

class ShopGetFavoritesErrorState extends ShopStates {}

class ShopGetCartSuccessfulState extends ShopStates {
}

class ShopGetCartErrorState extends ShopStates {}

class ShopChangeFavoritesSuccessfulState extends ShopStates {
  final AddRemoveFavoriteItemModel model;

  ShopChangeFavoritesSuccessfulState(this.model);
}

class ShopChangeFavoritesErrorState extends ShopStates {}

class ShopChangeFavoritesState extends ShopStates {}

class ShopChangeCartSuccessfulState extends ShopStates {}

class ShopChangeCartErrorState extends ShopStates {}

class ShopChangeCartState extends ShopStates {}


class ShopLoadingState extends ShopStates {}

class ShopSearchLoadingState extends ShopStates {}

class ShopSearchSuccessfulState extends ShopStates {}

class ShopSearchErrorState extends ShopStates {}

class ShopGetFAQSuccessfulState extends ShopStates {}

class ShopGetFAQErrorState extends ShopStates {}

class ShopChangeThemeState extends ShopStates {}
