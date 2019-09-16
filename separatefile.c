#include <stdio.h>
#include "mul_cpx_separatefile.h"

int main(){
  #define SIZE 30000
  double as[2*SIZE]; // Requires 0.45 MiB of memory -> all 3 arrays can fit on stack.
  double bs[2*SIZE];
  double cs[2*SIZE];

  for ( size_t ix = 0; ix < 2*SIZE - 1; ix += 2 ) {
    // Initialize both Re and Im parts with 1 to get 2 only in Im part of the product:
    bs[ix] = 1; bs[ix+1] = 1;
    cs[ix] = 1; cs[ix+1] = 1;
    
    mul_cpx_mainfile( &as[ix], &as[ix + 1], \
                      &bs[ix], &bs[ix + 1], \
                      &cs[ix], &cs[ix + 1] );    
  }
  printf("as[0] = %lf, as[1] = %lf\n", as[0], as[1]);
  
  return(0);
}
