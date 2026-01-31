String getFileType(String fileExtension){

  List<String> allVideoTypes = ["mp4","flv","mov","mpeg","mpegps","mpg","webm","wmv","3gpp"];
  List<String> imageType = ["jpg","jpeg","png","svg"];
  List<String> audioTypes = ["aac","flac","mp3","mpa","mpeg","mpga","mp4","opus","pcm","wav","webm"];

  if(allVideoTypes.contains(fileExtension)) {
    return "video";
  } else if(imageType.contains(fileExtension)) return 'image';
  else if(audioTypes.contains(fileExtension)) return "audio";
  else return "pdf";


}

String getMimeType (String fileExtension,String type){
  if(type == "audio"){
    if(fileExtension == "mpa"){
      return "audio/m4a";
    }
    else{
      return "audio/$fileExtension";
    }
  }
  else if(type == "image"){
    if(fileExtension == "jpg"){
      return "image/jpeg";
    }
    else{
      return "image/$fileExtension";
    }
  }
  else if(type == "video"){
    Map<String,String> mapToMimeType = {
      "flv":"x-flv",
      "mov":"quicktime"
    };
    return "video/${mapToMimeType[fileExtension] ?? fileExtension}";
  }
  else{
    if(fileExtension =="pdf"){
      return "application/pdf";
    }
    else{
      return "text/plain";
    }
  }
}