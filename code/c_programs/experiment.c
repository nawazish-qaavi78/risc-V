#include<stdio.h>
#include <limits.h>
#include <stdbool.h>
#include <stdint.h>

#define V 32

void set_graph(uint32_t *graph){
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

int min_cost(int *cost, bool *processed) {
    uint8_t min = UINT8_MAX;
    int8_t index = -1;
    for(uint8_t i = 0; i<V; i++){
        if(!processed[i]) {
            if(cost[i]<min){
                index = i;
                min = cost[i];
            } 
        }
    }
    return index;
}

void algo(uint8_t start_node, uint8_t end_node, uint32_t* graph){
    // setting up the variables
    uint8_t cost[V], parent[V];
    bool processed[V];

    for(uint8_t i = 0; i<V; i++){
        parent[i] = -1;
        processed[i] = false;
        if(i != start_node) cost[i] = UINT8_MAX;
        else cost[i] = 0;
    }

    // starting the algo
    for(uint8_t j = 0; j<V; j++){
        uint8_t index = 0;
        int8_t parent_index = 0;
        parent_index = min_cost(cost, processed);
        for(index = 0; index<V; index++){
            if(graph[parent_index] & (1<<index)){
                if(cost[index] > cost[parent_index] + 1) {
                    cost[index] = cost[parent_index] + 1;
                    parent[index] = parent_index;
                }
                if(index == end_node) break; // considering all of equal weight edges
            }
        }
        processed[parent_index] = true;
        if(index == end_node) break;
    }
    
    // decoding the output
    uint8_t j = end_node;
    while(j!=-1){
        printf("%d\n", j);
        j = parent[j];
    }
}

int main(){
    uint32_t graph[V];
    set_graph(graph);
    uint8_t start_node = 0, end_node = 5;
    algo(start_node, end_node, graph);

    return 0;
}