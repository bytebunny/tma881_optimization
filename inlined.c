#include <stdio.h>

int main(){
  #define SIZE 30000
  double as[2*SIZE]; // Requires 0.45 MiB of memory -> all 3 arrays can fit on stack.
  double bs[2*SIZE];
  double cs[2*SIZE];

  for ( size_t ix = 0; ix < 2*SIZE - 1; ix += 2 ) {
    // Initialize both Re and Im parts with 1 to get 2 only in Im part of the product:
    bs[ix] = 1; bs[ix+1] = 1;
    cs[ix] = 1; cs[ix+1] = 1;
    
    as[ix] = bs[ix] * cs[ix] - bs[ix + 1] * cs[ix + 1];
    as[ix + 1] = bs[ix] * cs[ix + 1] + bs[ix + 1] * cs[ix];
  }
  
  return(0);
}
