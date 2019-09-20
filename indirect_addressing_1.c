#include <stdlib.h>
#include <stdio.h>
#include <time.h>

int main(){
  static size_t n = 1000000; 
  static size_t m = 1000;
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
  for (size_t jx=0; jx < m; ++jx) {
    for (size_t kx=0; kx < m; ++kx) {
      p[jx + m*kx] = ix++;
      
      x[jx + m*kx] = (size_t)2;
      y[jx + m*kx] = (size_t)1;
    }
  }
  
  // Perform incrementing of y:
  for (size_t kx=0; kx < n; ++kx) {
    jx = p[kx];
    y[jx] += a * x[jx];
  }
  timespec_get(&t_end, TIME_UTC);
  
  // Calculate the elapsed time:
  t_elapsed = ( (double)(t_end.tv_sec - t_start.tv_sec) +  \
                ((double)(t_end.tv_nsec - t_start.tv_nsec)/1000000000L) );

  printf("Elapsed time: %.9lf msec.\n", t_elapsed*1e3);

  free(x);
  x = NULL;
  free(y);
  y = NULL;
  free(p);
  p = NULL;

  return(0);
}
