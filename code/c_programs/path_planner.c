
/*
* EcoMender Bot (EB): Task 2B Path Planner
*
* This program computes the valid path from the start point to the end point.
* Make sure you don't change anything outside the "Add your code here" section.
*/

#include <stdlib.h>
#include <stdbool.h>
#include <stdint.h>
#include <limits.h>
#define V 32

#ifdef __linux__ // for host pc

    #include <stdio.h>

    void _put_byte(char c) { putchar(c); }

    void _put_str(char *str) {
        while (*str) {
            _put_byte(*str++);
        }
    }

    void print_output(uint8_t num) {
        if (num == 0) {
            putchar('0'); // if the number is 0, directly print '0'
            _put_byte('\n');
            return;
        }

        if (num < 0) {
            putchar('-'); // print the negative sign for negative numbers
            num = -num;   // make the number positive for easier processing
        }

        // convert the integer to a string
        char buffer[20]; // assuming a 32-bit integer, the maximum number of digits is 10 (plus sign and null terminator)
        uint8_t index = 0;

        while (num > 0) {
            buffer[index++] = '0' + num % 10; // convert the last digit to its character representation
            num /= 10;                        // move to the next digit
        }
        // print the characters in reverse order (from right to left)
        while (index > 0) { putchar(buffer[--index]); }
        _put_byte('\n');
    }

    void _put_value(uint8_t val) { print_output(val); }

#else  // for the test device

    void _put_value(uint8_t val) { }
    void _put_str(char *str) { }

#endif

void set_graph(uint32_t *graph){
    // there are 32 bits and each bit shows if there is a linked between it and current index
    graph[0] = 0b00000000000000000000010001000010;
    graph[1] = 0b00000000000000000000100000000101;
    graph[2] = 0b00000000000000000000000000111010;
    graph[3] = 0b00000000000000000000000000000100;
    graph[4] = 0b00000000000000000000000000000100;
    graph[5] = 0b00000000000000000000000000000100;
    graph[6] = 0b00000000000000000000001110000001;
    graph[7] = 0b00000000000000000000000001000000;
    graph[8] = 0b00000000000000000000000001000000;
    graph[9] = 0b00000000000000000000000001000000;
    graph[10] = 0b00000101000000000000100000000001;
    graph[11] = 0b00000000000010000001010000000010;
    graph[12] = 0b00000000000000000110100000000000;
    graph[13] = 0b00000000000000000001000000000000;
    graph[14] = 0b00000000000000011001000000000000;
    graph[15] = 0b00000000000000000100000000000000;
    graph[16] = 0b00000000000001100100000000000000;
    graph[17] = 0b00000000000000010000000000000000;
    graph[18] = 0b00000000001010010000000000000000;
    graph[19] = 0b00000000000101000000100000000000;
    graph[20] = 0b00000000000010000000000000000000;
    graph[21] = 0b00000000110001000000000000000000;
    graph[22] = 0b00000000001000000000000000000000;
    graph[23] = 0b01000001001000000000000000000000;
    graph[24] = 0b00000010100000000000010000000000;
    graph[25] = 0b00000001000000000000000000000000;
    graph[26] = 0b00011000000000000000010000000000;
    graph[27] = 0b00000100000000000000000000000000;
    graph[28] = 0b01100100000000000000000000000000;
    graph[29] = 0b00010000000000000000000000000000;
    graph[30] = 0b10010000100000000000000000000000;
    graph[31] = 0b01000000000000000000000000000000;
}

int min_cost(uint8_t *cost, uint32_t processed) {
    uint8_t min = UINT8_MAX;
    int8_t index = -1;
    for(uint8_t i = 0; i<V; i++){
        if((!(processed & (1<<i))) && (cost[i]<min)) {
                index = i;
                min = cost[i];
        }
    }
    return index;
}

// main function
int main(int argc, char const *argv[]) {

    #ifdef __linux__

        const uint8_t START_POINT   = atoi(argv[1]);
        const uint8_t END_POINT     = atoi(argv[2]);
        uint8_t NODE_POINT          = 0;
        uint8_t CPU_DONE            = 0;

    #else
        // Address value of variables for RISC-V Implementation
        #define START_POINT         (* (volatile uint8_t * ) 0x02000000)
        #define END_POINT           (* (volatile uint8_t * ) 0x02000004)
        #define NODE_POINT          (* (volatile uint8_t * ) 0x02000008)
        #define CPU_DONE            (* (volatile uint8_t * ) 0x0200000c)

    #endif

    // array to store the planned path
    uint8_t path_planned[V];
    // index to keep track of the path_planned array
    uint8_t idx = 0;


    /* Functions Usage

    instead of using printf() function for debugging,
    use the below function calls to print a number, string or a newline

    for newline: _put_byte('\n');
    for string:  _put_str("your string here");
    for number:  _put_value(your_number_here);

    Examples:
            _put_value(START_POINT);
            _put_value(END_POINT);
            _put_str("Hello World!");
            _put_byte('\n');
    */

    // ############# Add your code here #############
    // prefer declaring variable like this
    #ifdef __linux__
        uint32_t graph[V];
    #else
        uint32_t *graph = (uint32_t *) 0x02000010;
    #endif

    set_graph(graph);
    
    // setting up the variables
    #ifdef __linux__
        uint8_t cost[V] = {[0 ... (V-1)] = UINT8_MAX};
        int8_t parent[V] = {[0 ... (V-1)] = -1};
    #else
        uint8_t *cost = (uint8_t *) 0x02000100; 
        int8_t *parent = (int8_t *) 0x02000200; 
        for (uint8_t i = 0; i < V; i++) {
            cost[i] = UINT8_MAX;
            parent[i] = -1;
        }
    #endif    
    
    cost[START_POINT] = 0;

    uint32_t processed = 0;

    // starting the algo
    for(uint8_t j = 0; j<V; j++){
        uint8_t index = 0;
        int8_t parent_index = 0;
        parent_index = min_cost(cost, processed);
        if(parent_index>=0){
            for(index = 0; index<V; index++){
                if((graph[parent_index] & (1<<index)) && (cost[index] > cost[parent_index] + 1)){
                        cost[index] = cost[parent_index] + 1;
                        parent[index] = parent_index;
                        if(index == END_POINT) break; // considering all of equal weight edges
                }
            }

            processed = processed | (1<<parent_index);
            if(index == END_POINT) break;
        }
        
    }

    // decoding the output
    for (int8_t temp = END_POINT; temp != -1; temp = parent[temp], idx++);


    path_planned[idx-1] = END_POINT;
    for(int8_t i = idx-2; i>=0; i--){
        path_planned[i] = parent[path_planned[i+1]];
    }


    // ##############################################

    // the node values are written into data memory sequentially.
    for (int i = 0; i < idx; ++i) {
        NODE_POINT = path_planned[i];
    }
    // Path Planning Computation Done Flag
    CPU_DONE = 1;

    #ifdef __linux__    // for host pc

        _put_str("######### Planned Path #########\n");
        for (int i = 0; i < idx; ++i) {
            _put_value(path_planned[i]);
        }
        _put_str("################################\n");

    #endif

    return 0;
}

