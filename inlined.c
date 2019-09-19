#include <stdio.h>
#include <time.h>

int main(){
  #define SIZE 30000
  double as[2*SIZE]; // Requires 0.45 MiB of memory -> all 3 arrays can fit on stack.
  double bs[2*SIZE];
  double cs[2*SIZE];

  size_t n_iter = 100000;
  struct timespec t_start, t_end;
  double t_elapsed;

  timespec_get(&t_start, TIME_UTC);
  for ( int iter = 0; iter < n_iter; ++iter ){
    for ( size_t ix = 0; ix < 2*SIZE - 1; ix += 2 ) {
      // Initialize both Re and Im parts with 1 to get 2 only in Im part of the product:
      bs[ix] = 1; bs[ix+1] = 1;
      cs[ix] = 1; cs[ix+1] = 1;
      
      as[ix] = bs[ix] * cs[ix] - bs[ix + 1] * cs[ix + 1];
      as[ix + 1] = bs[ix] * cs[ix + 1] + bs[ix + 1] * cs[ix];
    }
  }
  timespec_get(&t_end, TIME_UTC);
  
  // Calculate the elapsed time:
  t_elapsed = ( (double)(t_end.tv_sec - t_start.tv_sec) +  \
                ((double)(t_end.tv_nsec - t_start.tv_nsec)/1000000000L) );
  
  printf("Elapsed time of %ld repetitions of multiplications: %.9lf msec.\n",
         n_iter, t_elapsed*1e3);
    
  return(0);
}
