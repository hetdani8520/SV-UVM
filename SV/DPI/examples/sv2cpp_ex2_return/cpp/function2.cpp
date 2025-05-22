#include <iostream>
#include <svdpi.h>

using namespace std;

extern "C" svBit display(svBit inp);

svBit display(svBit inp){
  //cout << "returning val= " << inp << " from C++ world" << endl;
  return inp;
}