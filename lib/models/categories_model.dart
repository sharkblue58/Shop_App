class CategoriesModel{
  CategoriesModel();
  late bool status;
   CategoriesDataModel data=new CategoriesDataModel();
  CategoriesModel.fromJason(Map<String,dynamic>jason)
  {
    status=jason['status'];
    data=CategoriesDataModel.fromJason(jason['data']);
  }
}
class CategoriesDataModel
{
  CategoriesDataModel();
    late int currentPage;
    List<DataModel>data=[];
    CategoriesDataModel.fromJason(Map<String,dynamic>jason)
    {
      currentPage=jason['current_page'];
      jason['data'].forEach((element) {
        data.add(DataModel.fromJason(element));
      });
    }
}
class DataModel
{
  DataModel();
    late int id;
    late String name;
    late String image;
    DataModel.fromJason(Map<String,dynamic>jason)
    {
      id=jason['id'];
      name=jason['name'];
      image=jason['image'];
    }

}