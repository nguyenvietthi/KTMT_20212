#include <stdio.h>

void swap(int* a, int* b);
void BubbleSort(int arr[], int N);
int partition (int arr[], int low, int high);
void quickSort(int arr[], int low, int high);
void printArray(int arr[], int size);

int main(int argc, char** argv){
    int n = atoi(argv[2]);
    int array[n];

    // read data
    FILE *in_file  = fopen("data.txt", "r"); 
    int i = 0;
    for (i = 0; i < n; i++)
    {
        fscanf(in_file, "%d", &array[i]);
    }
    
    // mode
    if(!strcmp(argv[1], "bubble_sort")) {
        printf("Bubble sort\n");
        BubbleSort(array, n);
    } else if(!strcmp(argv[1], "quick_sort")){
        printf("Quick sort");
        quickSort(array, 0, n - 1);
    } else {
        printf("nothing");
    }

    // printArray(array, n);
}

void swap(int* a, int* b)
{
   int temp;
   temp = *a;
   *a = *b;
   *b = temp;
}

void BubbleSort(int arr[], int N)
{
   int i, j;
   for (i = 0; i < N; i++)
   {
       for (j = N-1; j > i; j--)
       {
           if(arr[j] < arr[j-1])
               swap(&arr[j], &arr[j-1]);
       }
   }
}

int partition (int arr[], int low, int high)
{
    int pivot = arr[high]; // pivot
    int i = (low - 1); // Index of smaller element and indicates the right position of pivot found so far
    
    int j;
    for(j = low; j <= high - 1; j++)
    {
        // If current element is smaller than the pivot
        if (arr[j] < pivot)
        {
            i++; // increment index of smaller element
            swap(&arr[i], &arr[j]);
        }
    }
    swap(&arr[i + 1], &arr[high]);
    return (i + 1);
}
 
/* The main function that implements QuickSort
arr[] --> Array to be sorted,
low --> Starting index,
high --> Ending index */
void quickSort(int arr[], int low, int high)
{
    if (low < high)
    {
      /* pi is partitioning index, arr[p] is now
      at right place */
      int pi = partition(arr, low, high);

      // Separately sort elements before
      // partition and after partition
      quickSort(arr, low, pi - 1);
      quickSort(arr, pi + 1, high);
    }
}
void printArray(int arr[], int size)
{
    int i;
    for (i = 0; i < size; i++)
        printf("%d: %d\n", i, arr[i]);
}