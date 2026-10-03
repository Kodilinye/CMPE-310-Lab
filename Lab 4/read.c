#include <stdio.h>
#include <stdlib.h>

int sum_array(int *my_array, int count);

int main(int num, char *my_string[]) {
    if (num != 2) {
        printf("Usage: %s <datafile>\n", my_string[0]);
        return 1;
    }

    FILE *file = fopen(my_string[1], "r");
    if (file == NULL) {
        printf("Error opening file.\n");
        return 1;
    }

    int count;
    if (fscanf(file, "%d", &count) != 1 || count < 0) {
        printf("Invalid data file.\n");
        fclose(file);
        return 1;
    }

    int *my_array = malloc((size_t)count * sizeof(int));
    if (count > 0 &&my_array == NULL) {
        printf("Memory allocation failed.\n");
        fclose(file);
        return 1;
    }

    for (int i = 0; i < count; i++) {
        if (fscanf(file, "%d", &my_array[i]) != 1) {
            printf("Invalid data file.\n");
            free(my_array);
            fclose(file);
            return 1;
        }
    }

    fclose(file);

    int sum = sum_array(my_array, count);
    printf("Sum: %d\n", sum);

    free(my_array);
    return 0;
}