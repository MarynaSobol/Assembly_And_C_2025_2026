#include <stdio.h>


extern int add(int a, int b, int c); 
extern int sub(int a, int b);        

int main() {
    int sum = add(10, 20, 30);
    int difference = sub(50, 20);

    printf("--- Practical 09: Part 4 ---\n");
    printf("Addition Result (10 + 20 + 30): %d\n", sum);
    printf("Subtraction Result (50 - 20): %d\n", difference);

    return 0;
}