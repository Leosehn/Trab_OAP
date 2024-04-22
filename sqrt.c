#include <stdio.h>

int sqrt_nr(int x, int i)
{   
    if(i == 0) {
        return 1;
    }
    int temp = sqrt_nr(x, i - 1);
    return (temp + (x / temp)) / 2;
}

void main(void)
{
    printf("Programa de Raiz Quadrada – Newton-Raphson\n\nDesenvolvedores: Gabriel Ferri Schneider e Leonardo Francisco Sehnem dos Santos\n\n");
    while(1) {
        printf("Digite os parâmetros x e i para calcular sqrt_nr (x, i) ou -1 para abortar a execução\n");
        int input_x;
        int input_i;
        scanf("%d",&input_x);
        if(input_x < 0) {
            break;
        }
        scanf("%d",&input_i);
        if(input_i < 0) {
            break;
        }
        printf("sqrt_nr(%d,%d)=%d\n\n",input_x,input_i,sqrt_nr(input_x,input_i));
    }
}