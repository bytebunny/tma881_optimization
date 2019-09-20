#include <stdlib.h>

int main() {
  int * as;
  as = (int*)malloc(10*sizeof(int));
  int sum = 0;
  
  for ( int ix = 0; ix < 10; ++ix )
    as[ix] = ix;
  
  for ( int ix = 0; ix < 10; ++ix )
    sum += as[ix];
  
  //free(as);
}
