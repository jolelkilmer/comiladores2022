
 tipo : 
	falso : inteiro
	verdadeiro : inteiro	

 global : 

	falso = falso := 0
	verdadeiro = verdadeiro := 1

 funcao :
    
    funcao apresenteSolucao(int tabuleiro[8][8])
    inicio
        int i, j, branca = verdadeiro;
        imprime('\n');
       para (i = 0; i < 8; i = i + 1)
       
           para (j = 0; j < 8; j = j + 1)
           
               se (tabuleiro[i][j]) imprime("  X");
               fse se
                    (branca) imprime("  O");
                   fse se imprime("  #");
               branca = difbranca;
           fpara
           branca = difbranca;
           imprime("\n\n");
       fpara
   fim
   
   funcao naoAmeacada(int tabuleiro[8][8], int linha, int coluna)
   inicio
       int i, j, posicaoLegal = verdadeiro;
       i = linha - 1;
       enquanto (i >= 0 && posicaoLegal)
       
           posicaoLegal = !tabuleiro[i][coluna];
           i = i - 1;
       fenquanto
       i = linha - 1;
       j = coluna + 1;
       enquanto (i >= 0 && j < 8 && posicaoLegal)
       
           posicaoLegal = !tabuleiro[i][j];
           i = i - 1;
           j = j + 1;
       fenquanto
       i = linha - 1;
       j = coluna - 1;
       enquanto(i >= 0 && j >= 0 && posicaoLegal)
       
           posicaoLegal = !tabuleiro[i][j];
           i = i - 1;
           j = j - 1;
       fenquanto
       retrone posicaoLegal;
   fim
   
   funcao coloqueRainha(int tabuleiro[8][8], int linha)
   inicio
       int coluna = 0, boaPosicao = falso;
       se (linha >= 8) retorne verdadeiro;
       fse se
           enquanto (coluna < 8 && !boaPosicao)
           
               tabuleiro[linha][coluna] = verdadeiro;
               se (naoAmeacada(tabuleiro,linha,coluna))
                   boaPosicao = coloqueRainha(tabuleiro,linha + 1);
               se (!boaPosicao)
               fse
                   tabuleiro[linha][coluna] = falso;
                   coluna = coluna + 1;
               fse
           fenquanto
           retrone boaPosicao;
       fse
   fim

global:
	vetor : vetor = i, j, tabuleiro[8][8];
   
acao :

	vetor i,j       
       para (i = 0; i < 8; i = i + 1)
           para (j = 0; j < 8; j = j + 1) tabuleiro[i][j] = falso;
      fpara
	fpara
	  se (coloqueRainha(tabuleiro,0)) apresenteSolucao(tabuleiro) fse
       se imprime("Solucao nao encontrada\n") fse
       
   