tipo : 

vetorordenado : int := [11 22 33 44 55 66 77 88 99]

global :

x : inteiro
n : inteiro

funcao :

buscabinaria ( x n vetor)

acao:

buscabinaria( int x, int n, int vetor[]) {
 int esquerda, meio, direita;
 esquerda = 0; direita = n-1;
 enquanto (esquerda <= direita) faca
 	meio = (esquerda + direita)/2;
	se (vetor[meio] == x) retorne meio;
 		se (vetor[meio] < x) esquerda = meio + 1;
  direita = meio - 1;
 }
 retorne -1;