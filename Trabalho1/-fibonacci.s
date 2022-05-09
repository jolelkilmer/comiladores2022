tipo:
	numero = inteiro 
global: 
	numero : numero := 0
funcao: 
	fibonacci(numero ) 
	acao: se numero == 1 
		retorne 0;
		falso se numero == 2
			retorne 1;
			falso retorne(fibonacci(numero - 1)+ fibonacci(numero - 2))
			fse
		fse;
	fse
acao:
	fun imprime( " DIGITE QUAL TERMO DESEJA DESCOBRIR: " );
	fun li(numero);
	fun imprime( " O FIBONACCI DO TERMO DIGITADO é: ");
	fibonacci(numero)