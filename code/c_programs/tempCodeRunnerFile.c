#include<stdio.h>
#include <stdint.h>
int main(){
    int8_t parent[6] = {[0 ... (5)] = -1};
    for(int i=0; i<6; printf("%d\n",parent[i++]));
    return 0;
}