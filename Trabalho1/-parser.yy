/*
 * PARSER
 *https://github.com/travmygit/TigerCompiler/blob/master/ch03/tiger.y
 */

%{

/*** C++ Declarations ***/
#include "parser.hh"
#include "scanner.hh"

#define yylex driver.scanner_->yylex

%}

%code requires {
  #include <iostream>
  #include "driver.hh"
  #include "location.hh"
  #include "position.hh"
}

%code provides {
  namespace Simples  {
    // Forward declaration of the Driver class
    class Driver;

    inline void yyerror (const char* msg) {
      std::cerr << msg << std::endl;
    }
  }
}

/* Require bison 2.3 or later */
%require "2.4"
/* enable c++ generation */
%language "C++"
%locations
/* write out a header file containing the token defines */
%defines
/* add debug output code to generated parser. disable this for release
 * versions. */
%debug
/* namespace to enclose parser in */
%define api.namespace {Simples}
/* set the parser's class identifier */
%define api.parser.class {Parser}
/* set the parser */
%parse-param {Driver &driver}
/* set the lexer */
%lex-param {Driver &driver}
/* verbose error messages */
%define parse.error verbose
/* use newer C++ skeleton file */
%skeleton "lalr1.cc"
/* Entry point of grammar */
%start programa

%union
{
 /* YYLTYPE */
  int  			      integerVal;
  double 			    doubleVal;
  std::string*		stringVal;
}

/* Tokens */
%token              TOK_EOF 0     "end of file"
%token			        EOL		        "end of line"
%token <integerVal> INTEIRO		    "inteiro"
%token <doubleVal> 	REAL		    "real"
%token <stringVal> 	ID    "identifier"
%token VAR "var"
%token SE "se"
%token FSE "fse"
%token DE "de"
%token TIPO "tipo"
%token ENQUANTO "enquanto"
%token FENQUANTO "fenquanto"
%token FUNCAO "função"
%token <stringVal> CADEIA "cadeia"
%token RETORNE "retorne"
%token ACAO "ação"
%token REF "ref"
%token VALOR "valor"
%token PARA "para"
%token FPARA "fpara"
%token VERDADEIRO "verdadeiro"
%token FALSO "falso"
%token FACA "faça"
%token INICIO "inicio"
%token PARE "pare"
%token CONTINUE "continue"
%token FIM "fim"
%token LIMITE "limite" 
%token NULO "nulo" 
%token GLOBAL "global" 
%token LOCAL "local" 
%token DOISPONTOS ":"
%token VIRGULA ","
%token PONTOEVIRGULA ";" 
%token PARENTESESESQ "("
%token PARENTESESDIR ")"
%token COLCHETEESQ "["
%token COLCHETEDIR "]"
%token CHAVEESQ "{"
%token CHAVEDIR "}"
%token PONTO "."
%token MAIS "+"
%token MENOS "-"
%token ASTERISCO "*"
%token BARRA "/" 
%token DIFERENTE "!="
%token MENOR "<"
%token MAIOR ">"
%token MENORIGUAL  "<="
%token MAIORIGUAL ">="
%token ECOMERCIAL "&"
%token OU "|"
%token IGUAL "="
%token COMPARACAO_IGUAL "=="
%token INTERROGACAO "?"
%token ATRIBUICAO ":="

%%

programa: declaracoes acao {  }

declaracoes:
  lista_declaracao_de_tipo
  lista_declaracao_de_globais
  lista_declaracao_de_funcoes { }


acao: 
  ACAO DOISPONTOS lista_comandos {  }

lista_declaracao_de_tipo: { }    
  | TIPO DOISPONTOS lista_declaracao_tipo  { }

lista_declaracao_de_globais: { }
  | GLOBAL DOISPONTOS lista_declaracao_variavel { }

lista_declaracao_de_funcoes: { }
  | FUNCAO DOISPONTOS lista_declaracao_funcoes {}
  

descritor_tipo:
  ID { }
  | CHAVEESQ tipo_campos CHAVEDIR { }
  | COLCHETEESQ tipo_constantes COLCHETEDIR DE ID { }

declaracao_tipo:
  ID IGUAL descritor_tipo { }

lista_declaracao_tipo:
  declaracao_tipo { }
  | declaracao_tipo lista_declaracao_tipo{ }

tipo_campos: 
  tipo_campo { }
  |tipo_campos VIRGULA tipo_campo { }

tipo_campo:
  ID DOISPONTOS ID { }

tipo_constantes:
  INTEIRO { }
  | tipo_constantes VIRGULA INTEIRO { }


lista_declaracao_variavel:
  declaracao_variavel { }
  |  declaracao_variavel lista_declaracao_variavel{ }

declaracao_variavel:
  tipo_campo ATRIBUICAO expr { } 


lista_declaracao_funcoes:
  declaracao_funcao { }
  | declaracao_funcao lista_declaracao_funcoes { }

declaracao_funcao:
  ID PARENTESESESQ args PARENTESESDIR IGUAL corpo { }
  | ID PARENTESESESQ args PARENTESESDIR DOISPONTOS ID IGUAL corpo { }

args_list: 
  arg { }
  | arg VIRGULA args_list { }

args: modificador args_list { }

arg: tipo_campo

modificador: 
  VALOR  { }
  | REF { }

corpo:
  declaracoes_de_locais ACAO DOISPONTOS lista_comandos { }

declaracoes_de_locais: { }
  | LOCAL DOISPONTOS lista_declaracao_variavel { }

lista_comandos:
  comando { }
  | lista_comandos PONTOEVIRGULA comando { }

comando:
  local ATRIBUICAO expr { }
  | chamada_de_funcao { }
  | SE expr VERDADEIRO lista_comandos FSE { }
  | SE expr VERDADEIRO lista_comandos FALSO lista_comandos FSE { }
  | PARA ID DE expr LIMITE expr FACA lista_comandos FPARA { }
  | ENQUANTO expr FACA lista_comandos FENQUANTO { }
  | PARE { }
  | CONTINUE { }
  | RETORNE expr { }

expr: 
  expressao_logica { }
  | CHAVEESQ lista_expr CHAVEDIR { }
  | vetor

vetor: COLCHETEESQ lista_expr COLCHETEDIR
  | COLCHETEESQ vetor PONTOEVIRGULA COLCHETEESQ lista_expr COLCHETEDIR COLCHETEDIR

expressao_logica: 
  expressao_logica OU expressao_relacional { }
  | expressao_logica ECOMERCIAL expressao_relacional { }
  | expressao_relacional { }

expressao_relacional: 
  expressao_relacional MENORIGUAL expressao_aritimetica1 { }
   | expressao_relacional MAIORIGUAL expressao_aritimetica1 { }
   | expressao_relacional MENOR expressao_aritimetica1 { }
   | expressao_relacional MAIOR expressao_aritimetica1 { }
   | expressao_relacional DIFERENTE expressao_aritimetica1 { }
   | expressao_relacional COMPARACAO_IGUAL expressao_aritimetica1 { }
   | expressao_aritimetica1

expressao_aritimetica1:
   expressao_aritimetica1 MENOS expressao_aritimetica2 { }
  | expressao_aritimetica1 MAIS expressao_aritimetica2 { }
  | expressao_aritimetica2

expressao_aritimetica2:
  expressao_aritimetica2 BARRA fator { }
  | expressao_aritimetica2 ASTERISCO fator { }
  | fator { }

fator: 
    expressao_com_parenteses { }
  | primitivas
  | local { }
  | nulo
  | chamada_de_funcao { }
  
primitivas:
  CADEIA { }
  | INTEIRO { } 
  | REAL { }

nulo: 
  NULO { }

expressao_com_parenteses: 
  PARENTESESESQ expr PARENTESESDIR { }


chamada_de_funcao: 
  ID PARENTESESESQ lista_expr PARENTESESDIR { }

lista_expr: 
  expr { }
  | lista_expr VIRGULA expr { }

local: 
  ID { }
  | local PONTO ID { }
  | local COLCHETEESQ lista_expr COLCHETEDIR { }


%%

namespace Simples {
   void Parser::error(const location&, const std::string& m) {
        std::cerr << *driver.location_ << ": " << m << std::endl;
        driver.error_ = (driver.error_ == 127 ? 127 : driver.error_ + 1);
   }
}
