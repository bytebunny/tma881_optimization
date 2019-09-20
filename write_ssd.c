#include <stdio.h>
#include <stdlib.h>

int main(){
  static size_t n_int = 1048576; // == 2^20
  size_t * a = (size_t*) malloc(sizeof(size_t) * n_int);
  FILE *fp;

  for (size_t ix = 0; ix < n_int; ++ix) {
    a[ix] = ix;
  }
  
  // --------------- Writing to file --------------
  fp = fopen("/run/mount/scratch/hpcuser121/first_2exp20_int.txt", "w");  
  fwrite(a, sizeof(size_t), n_int, fp);
  fclose(fp);

  // --------------- Reading from file --------------
  fp = fopen("/run/mount/scratch/hpcuser121/first_2exp20_int.txt", "r");
  fread(a, sizeof(size_t), n_int, fp);
  fclose(fp);

  free(a);
  a = NULL;

  return(0);
}
