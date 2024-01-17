# comandos que fazem continhas

10/2

10+2

10-2

10*3

10^3
# exponenciação no R é ^

10**3
# também dá com **  

# como o R pode guardar resultados de contas? (e de muitas outras coisas)
## criar variáveis ou objetos, os dois termos são sinônimos para nós nesse curso
## e eu vou usar os 2 de maneira intercanbiável

valor = 10
valor2 <- 11
# a diferença é que usar a "<-" dá menos margem pra erro em casos avançados
# é uma BOA PRÁTICA

# colocar um sinal de atribuição no comando que o R vai entender que ele
# tem que gaurdar o que tá à direita do sinal de atribuição e eventualmente
# podemos usar de novo

valor+3

valor <- valor+12

valor3 <- 10
valor4 <- 15
# ALT + - é o atalho pra fazer a setinha direto

-+3dre <- 1

# NOMES PROIBIDOS NO R

# 1. começa com caracter especial (pontuação etc) que não seja ., só o . pode:
_asd <- 1
$asdad <- 2  

.x <- 1
# Exceção!!!! mas não use muito isso no começo pelos menos, porque quando começa
# com "." o R entende que é pra deixar escondido... no Environment não aparece
# na lista

# 2. Não pode começar com número

2X <- 1

X2 <- 1

# 3. Não pode sinais reservados no meio do objeto:

a+b <- 1
a-b <- 1

a_b <- 1
a.b <- 1

# CONVENÇÃO 

# snake_case que é separar palavras por _ e usar tudo em minuscula

# Funções -----------------------------------------------------------------

Sys.Date()

# funções são comandos especiais porque elas permitem serem acionadas
# a partir de parametrizações, ou seja, são coisas complicadas que o R
# pode fazer e que vc não precisa programar diretamente, vc pode parametrizar
# de que maneira o R vai executar uma função. Por conta dessa característica
# dos parâmetros toda chamada de função usa ()

Sys.time()
# é uma função que funciona sem parâmetros

length(letters)
# essa função "length" recebe como parâmetro "letters"
# em outras palavras o comando acima diz "aplique a função length em letters"

# o padrão de uma chamada de função vai ser sempre assim
# NOME(PARAMETRO1, PARAMETRO2, PARAMETRO3)

valor3(1)
# aqui o R entende que valor3 deveria ser uma função porque eu coloquei
# parênteses logo depois do seu nominho

# e se eu quiser criar uma função???

minha_funcao <- function(){
  Sys.Date()
}

minha_funcao()
# pra que isso serve?

# pra renomear uma função normal do R...

amanha <- function(){
  Sys.Date()+1
}

amanha()
# eu crio o meu próprio comando que tem uma interpretação por trás...

help(length)
# função "help" pode ser aplicada em outras funções pra me dar a DOCUMENTAÇÃO

valor3/3

help(round)

round(valor3/3, digits = 3)
# escrever explicitamente é uma boa prática!

round(digits = 3, valor3/3)
round(3, valor3/3)
# sem os nomes ele interpreta na ordem que aparece na documentação

# de onde vêm as funções???
# de pacotes

install.packages("readr")
# update.packages()
# dica do anderson!

# como eu uso um pacote??

read_csv
# essa função mora no readr... mas ainda não chamamos ele

library(readr)

tabela_legal <- read_csv("https://github.com/tidyverse/readr/raw/main/inst/extdata/mtcars.csv")

# Tipos de objetos/variáveis ----------------------------------------------

# No R, existe um conceito que é, tudo que é armazenado para ser usado depois, com um certo nome
# ou seja, todos os potinhos que estão na prateleira tem um tipo. O R "sabe" o tipo de coisa
# que está em cada objeto

#podemos usar a função class pra descobrir tipos

class(a.b)
class(amanha)
class(tabela_legal)
# aqui tem vários tipos, porque no R um objeto pode ter vários tipos mesmo...
# mas apareceu um bem especial: o data.frame! que são as nossas tabelas

# números

numero_inteiro_fake <- 1
class(numero_inteiro_fake)

numero_inteiro_de_verdade <- 1L
class(numero_inteiro_de_verdade)

numero_quebrado <- 1.1
class(numero_quebrado)

# E[X] É DEFINIDO COMO MÉDIA(X)
# mean(coluna)
# coluna.mean()

# texto = "string"
# texto.replace("s", "g")
# aqui a "função" mora dentro do objeto, todo objeto carrega um monte de "funções" dentro de si
# e essas "funções" tem um nome especial: método


# characters

nome <- "fernando"
# escrevo entre aspas: ""
# escrevo entre aspas : ''

nome2 <- 'fernando'

class(nome)

numero_como_texto <- "1"
class(numero_como_texto)
numero_como_numeric <- 1

# logical

valor_logico <- TRUE

class(valor_logico)

# isso serve pro R ter um tipo específico de objeto pra ser o que ele retorna
# quando vc usar um operador de comparação lógica

nome == "Fernando"
# isso aqui dá FALSE, que é um objeto do tipo booleano, e é uma operação. parecido com o "="
# só que ao invés de eu mandar o R fazer uma conta, eu mando ele comparar dois valores

# Vetores -----------------------------------------------------------------

# numeric, character, logical, data.frame. 

# não parece que tá faltando algo?

vetor_basico <- c(1, 2, 3)
vetor_basico

class(vetor_basico)
length(vetor_basico)
length(valor3)

# MUITO IMPORTANTE!!!!! NO R OS VETORES SÃO HOMOGÊNEOS:
# OU SEJA.... TODAS AS ENTRADAS TEM QUE TER O MESMO TIPO (resultado que sai do "class")

vetor_normal <- c(1, 2, 3)

vetor_esquisito <- c(1, '2', 3)
class(vetor_esquisito)
# aqui aconteceu o que a gente chama de "coerção" de tipos. algo que na sintaxe
# pode ser interpretado como um número foi armazenado pelo R como um texto

# X = [1, '2', 3]
# aqui não tem coerção no Python ^. é uma lista, não um vetor


#X = [1, 2, 3]
#X+1
#ele dá erro, porque não é pra fazer soma

X = c(1,2,3)
X+1
# isso aqui é o comportamento padrão do array do numpy

X = c(1,2,3)
Y = c(3,4,5)

X+Y

# queremos chegar sempre em fazer contas com colunas:
tabela_legal$mpg-tabela_legal$cyl
