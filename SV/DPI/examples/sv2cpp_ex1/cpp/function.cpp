#include<iostream>
#include<svdpi.h>

using namespace std;

//extern "C" makes a function-name in C++ have C linkage 
extern "C" void display();

void display(){
  cout << "Hello from C++ World" << endl;
}