#include <stdlib.h>
#include <stdio.h>
#include <time.h>

int main(){
  static size_t n = 1000000; 
  size_t *p = (size_t*) malloc( sizeof(size_t) * n );
  size_t *x = (size_t*) malloc( sizeof(size_t) * n );
  size_t *y = (size_t*) malloc( sizeof(size_t) * n );

  size_t ix, jx;
  size_t a = 7;
  
  struct timespec t_start, t_end;
  double t_elapsed;

  timespec_get(&t_start, TIME_UTC);
  // Generate p:
  ix = 0;
  for (ix=0; ix < n; ++ix) {
    p[ix] = ix;
    x[ix] = (size_t)2;
    y[ix] = (size_t)1;
  }
  
  // Perform incrementing of y:
  for (size_t kx=0; kx < n; ++kx) {
    jx = p[kx];
    y[jx] += a * x[jx];
//    printf("%zu\n" ,y[jx]);
  }
  timespec_get(&t_end, TIME_UTC);
  
  // Calculate the elapsed time:
  t_elapsed = ( (double)(t_end.tv_sec - t_start.tv_sec) +  \
                ((double)(t_end.tv_nsec - t_start.tv_nsec)/1000000000L) );

  printf("Elapsed time: %.9lf msec.\n", t_elapsed*1e3);

  return(0);
}
