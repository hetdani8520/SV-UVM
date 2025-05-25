#include <iostream>
#include <svdpi.h>

using namespace std;

extern "C" int sv_unique(svBitVecVal* arr);
extern "C" void cpp_pass_by_ref(svBitVecVal* arr2);

void cpp_pass_by_ref(svBitVecVal* arr2){
  int unique_elem;
  //arr2 = {1,1,2,2,3,3,4};
  
  unique_elem = sv_unique(arr2);
  
  cout << "unique element in array is " << unique_elem << endl;
  //print arr for debug (arr pass by value from SV world into C++ where C++ initializes it as pass by ref)
  for(int i=0;i<5;i++){
    cout << arr2[i] << endl;
  }
}