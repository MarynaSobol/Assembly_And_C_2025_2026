// test.c
#include <stdio.h>
#include <assert.h>

extern long register_adder(long a, long b);

int main() {
    // Basic unit testing
    assert(register_adder(10, 20) == 30);
    assert(register_adder(5, 5) == 10);
    
    printf("Tests passed successfully!\n");
    return 0;
}