

class ResumeChecker{

  bool acceptOrReject(List data,String desc ){
    bool result=false;
    if(data.contains(desc.toLowerCase())){
      result=true;
    }
    return result;
  }

}