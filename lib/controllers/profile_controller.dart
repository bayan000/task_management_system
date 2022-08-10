
import '../models/profile_model.dart';
import '../services/profile_service.dart';

class   ProfileController{
  var  profileobj;
var image;
  Future onClickShowProfile()async {

////for testinggggggggggggggggggggggggg
    image= await ProfileService.ShowProfile();
    return image;
  }
  Future onClickAddProfile(String img_path)async{

    ProfileModel profileModel=ProfileModel(

        img_profile:img_path,
        phone:"095554786",
        education:"businesssmmmmmm",
        experience: "4 years as a team leader in many company",
        contact:"telegrambanan00"
    );
    profileobj =await ProfileService.AddProfile(profileModel);


  }


}