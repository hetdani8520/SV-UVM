#include <iostream>
#include <svdpi.h>

using namespace std;

extern "C" int fact_sv(int in);
extern "C" int fact_cpp(int a);

int fact_cpp(int a){
  cout << "in c++ world" << endl;
  return fact_sv(a); //calling SV function to compute factorial (context usage)
}
