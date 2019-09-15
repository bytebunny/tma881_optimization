#include <stdio.h>
#include <time.h>

int main(){
  int n_iter;
  size_t sum;
  size_t n_sum = 1000000000;
  struct timespec t_start, t_end;
  double t_elapsed_avg = 0;

  printf("Enter number of times summation should be repeated: ");
  scanf("%d", &n_iter);

  for ( size_t iter = 0; iter < n_iter; ++iter ){
    sum = 0;

    // Time calculation of the sum:
    timespec_get(&t_start, TIME_UTC);
    for ( size_t n = 1; n < n_sum + 1; ++n ){
      sum += n;
    }
    timespec_get(&t_end, TIME_UTC);

    // Calculate the elapsed time:
    double t_elapsed = (double)(t_end.tv_sec - t_start.tv_sec) +    \
      ((double)(t_end.tv_nsec - t_start.tv_nsec)/1000000000L);

    t_elapsed_avg += t_elapsed;

    printf("\nThe sum of the first %e integers is %zu.\n", (double)n_sum, sum);
    printf("Elapsed time of summation %zu: %.9lf sec.\n", iter+1, t_elapsed);
  }
  printf("\nThe average elapsed time is %.9lf sec.\n", t_elapsed_avg / n_iter);
  return(0);
}
