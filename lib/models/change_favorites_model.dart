class ChangeFavoritesModel{
  late bool status;
  late String message;
  ChangeFavoritesModel.fromJason(Map<String,dynamic>jason)
  {
    status=jason['status'];
    message=jason['message'];

  }

}