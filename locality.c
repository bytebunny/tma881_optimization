#include <stdio.h>
#include <stdlib.h>
#include <time.h>

void row_sums( double * sums,
               double ** matrix,
               size_t nrs,
               size_t ncs );

void col_sums( double * sums,
               double ** matrix,
               size_t nrs,
               size_t ncs );

int main(){
  const size_t SIZE = 1000;
  double sums[SIZE]; // Sums of elements in rows. *\/ */
  struct timespec t_start, t_end;
  int n_iter = 10000; // How many times summation needs to be repeated.
  double t_elapsed_avg;

  double * mentries = (double*) malloc(sizeof(double) * SIZE*SIZE);
  double ** m = (double**) malloc(sizeof(double*) * SIZE);
  for ( size_t ix = 0, jx = 0; ix < SIZE; ++ix, jx+=SIZE )
    m[ix] = mentries + jx;

  // Initialize matrix:
  for ( size_t ix = 0; ix < SIZE; ++ix  ) {
    for ( size_t jx = 0; jx < SIZE; ++jx  ) {
      m[ix][jx] = (double)jx; // Sum of each row is SIZE*(SIZE+1)/2, sum of col i={0,SIZE-1} is i*SIZE;
    }
  }
  
  /////////////////////////////////// time row summation ///////////////////////
  timespec_get(&t_start, TIME_UTC);
  for ( int iter = 0; iter < n_iter; ++iter ){
    row_sums( sums, m, SIZE, SIZE );
  }
  timespec_get(&t_end, TIME_UTC);

  // Calculate the elapsed time:
  t_elapsed_avg = ( (double)(t_end.tv_sec - t_start.tv_sec) +  \
                    ((double)(t_end.tv_nsec - t_start.tv_nsec)/1000000000L) \
                    ) / (double)n_iter;
  printf("Average (from %d) elapsed time of row summation: %.9lf msec.\n", n_iter, t_elapsed_avg*1e3);

  /////////////////////////////////// time col summation ///////////////////////
  timespec_get(&t_start, TIME_UTC);
  for ( int iter = 0; iter < n_iter; ++iter ){
    col_sums( sums, m, SIZE, SIZE );
  }
  timespec_get(&t_end, TIME_UTC);

  // Calculate the elapsed time:
  t_elapsed_avg = ( (double)(t_end.tv_sec - t_start.tv_sec) + \
                    ((double)(t_end.tv_nsec - t_start.tv_nsec)/1000000000L) \
                    ) / (double)n_iter;
  printf("Average (from %d) elapsed time of column summation: %.9lf msec.\n", n_iter, t_elapsed_avg*1e3);


  free(m);
  m = NULL;
  free(mentries);
  mentries = NULL;

  return(0);
}


void row_sums( double * sums,
//               const double ** matrix,
               double ** matrix,
               size_t nrs,
               size_t ncs ) {
  for ( size_t ix=0; ix < nrs; ++ix ) {
    double sum = 0;
    for ( size_t jx=0; jx < ncs; jx += 5 ){
      sum += matrix[ix][jx];
      sum += matrix[ix][jx + 1];
      sum += matrix[ix][jx + 2];
      sum += matrix[ix][jx + 3];
      sum += matrix[ix][jx + 4];
    }
//      sum += *(*(matrix) + ncs * ix + jx);
    sums[ix] = sum;
//    printf("%lf\n", sums[ix]);
  }
}

void col_sums( double * sums,
//               const double ** matrix,
               double ** matrix,
               size_t nrs,
               size_t ncs ) {
  for ( size_t jx=0; jx < ncs; ++jx ) {
    double sum = 0;
    for ( size_t ix=0; ix < nrs; ix += 5 ){
      sum += matrix[ix][jx];
      sum += matrix[ix + 1][jx];
      sum += matrix[ix + 2][jx];
      sum += matrix[ix + 3][jx];
      sum += matrix[ix + 4][jx];
      }
    sums[jx] = sum;
  }
}
