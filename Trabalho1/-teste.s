 tipo : 
 vet = [3] de inteiro
 mat = [2,3] de inteiro
 reg = { x: inteiro, y: cadeia }
 teste1 = cadeia 
 teste2 = inteiro 
 teste3 = real 

 global: 
 teste1: teste1:= "cadeia"
 teste2: teste2:= 123
 teste3: teste3:= 12.3
 cont: teste2:=0

 função: 
 fun1( valor teste1:teste1)= 
    local: teste4: teste2 := 4
            n: teste2 := 0
            x: teste2:=1
    
    ação: 
    enquanto teste4 > n faça
        x := x * cont;
        cont := cont +1
    fenquanto

 fun2( valor x:teste2)= 
    ação: 
        enquanto x > 1 faça
            imprimei(x);
            x := x - 1
        fenquanto

 fun3( ref r:teste3): r=
    local: var1: teste3 := r

    ação: 
        se var1 == 1.0 verdadeiro 
            var1:= 2.1
        falso   
            var1:= 0.0
        fse;  
    retorne var1
ação : 
fun1("teste") ;
fun1(12);
teste3:= fun3(1.2);
imprimer(teste3)