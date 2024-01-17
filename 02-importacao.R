
# arquivos ----------------------------------------------------------------

## vamos precisar lidar com caminhos

## vou precisar usar um pacote que se chama readr
library(tidyverse)
library(DBI)
# ^ aqui estamos revendo como chamar pacote pra ter mais funções
# disponíveis

imdb <- read_csv("imdb.csv")
# o padrão sempre vai ser funcao_de_leitura("CAMINHO_ATE_O_ARQUIVO")

class(imdb)

summarise(imdb, mean(nota_imdb))

## dificuldades:

## primeira: eu preciso garantir que os caminhos estejam certinhos

## segundo: garantir que a função de leitura esteja parametrizada corretamente

# no computador, no seu sistema operacional, todo arquivo "mora" em algum lugar
# e o "endereço" de onde ele mora é o que a gente chama de caminho. 

# o "endereço" completo de qualquer arquivo é o que a gente chama de "caminho absoluto"
# que faz menção à primeira pasta do seu computador (onde o sistema operacional instalado)

# no windows a pasta de instalação é C:/
# no linux ou mac a pasta de instalação é "/"

# então, qualquer arquivo que voce baixou, tem um endereço:

# no Windows:
# C:/Users/Fernando/Documentos/meu_arquivo.txt

# no Linux/MAC:
# /home/fernando/meu_arquivo.txt

# eu preciso usar sempre? no exemplo eu não usei...
# não!

# existem também caminhos relativos!!!
# no R, a gente tem sempre uma pasta de referência, escrita como
# um caminho absoluto

getwd()

# tendo essa pasta como referência original, se eu quiser eu posso
# passar caminhos relativos a essa pasta:

imdb <- read_csv("imdb.csv")
# o R está interpretando que, como não se trata de um caminho absoluto
# eu quero que o arquivo que mora em:
# PASTA DE REFERENCIA + imdb.csv
# seja lido:
# /home/shiny-admin/curso-r-asn/imdb.csv

# caminho absoluto vs. relativo

# pró absoluto:
# se mais do que uma pessoa usa o meu computador
# ou uma pasta na nuvem (servidor de empresa) ou algo do tipo
# o caminho relativo é legal até, porque todo mundo vai ter a mesma referência
# independentemente do que sai no "getwd()" todo mundo que usar aquele
# código vai ver caminhos que fazem referência a exatamente os mesmos arquivos
# contra absoluto:
# é uma pessoa criar um código com um caminho que só funciona no PC dela:
# read_csv("C:/Users/Colega/arquivo.csv")

# pró relativo:
# se você passar uma pasta inteira de projeto pra outra pessoa e ela abrir o projeto
# no RStudio, os caminhos relativos vão dar certo. Em outras IDEs a gente tem o mesmo
# comportamento: no VSCode por exemplo vc consegue mandar ele abrir o Python 
# que está "ativo" dentro de uma pasta

# contra relativo:
# é que as vezes não dá pra passar a pasta inteira porque ela é muito grande ou qualquer coisa assim
# daí a gente usa uma mistura das duas estratégias por exemplo lendo tudo do mesmo banco de dados na nuvem

# VEREDITO:
# no geral caminho relativo é melhor porque a situação em que várias pessoas
# mexem no mesmo código no mesmo computador é meio rara

# BÔNUS:
# "~/curso-r-asn/" quer dizer "/home/shiny-admin/curso-r/asn" porque, por padrão
# nem só no R/RStudio, o "~" quer dizer uma pasta específica do seu usuário.

# Em linux e mac isso é /home/usuario
# em Windows é C:/Users/Usuario/Documents

imdb <- read_csv("imdb2.csv")
imdb2 <- read_csv2("imdb2.csv")
imdb_delim <- read_delim("imdb.txt")

library(readr)
imdb2 <- read_delim("imdb2.csv", delim = ";", 
                    escape_double = FALSE,
                    col_types = cols(ano = col_integer(), 
                                     data_lancamento = col_date(format = "%Y-%m-%d"), 
                                     duracao = col_integer()),
                    trim_ws = TRUE)

View(imdb2)


# Excel -------------------------------------------------------------------

library(readxl)
imdb_nao_estruturada <- read_excel("imdb_nao_estruturada.xlsx", 
                                   sheet = "Sheet2", col_names = FALSE, 
                                   skip = 3)

nomes <- read_excel("imdb_nao_estruturada.xlsx", sheet = "Sheet1")

imdb_nao_estruturada <- set_names(imdb_nao_estruturada, nomes$nome)

?read_delim
help(read_delim)

# SQL ---------------------------------------------------------------------

# SQL
# Structured Query Language
# Esse-quê-éle
# SEQUEL

# SISTEMA GERENCIADOR DE BANCO DE DADOS (SGBD)
# DBMS

# programas de documentor que são os "guardiões" dos dados, organizador em um banco
# SGBD são programas como MySQL, PostgreSQL, Spark, SQL Server etc
# pra se comunicar com esses programas nós enviamos comandos em uma linguagem 
# específica que se chama "SQL"

# a lógica básica do SGBD é:

# voce pode imaginar que o sgbd é tipo um robô sorveteiro, e o banco de dados é
# uma vitrine de sorveteria. você chega nele, dá uma instrução do que você quer da cozinha
# ele vai lá, pega, e te devolve.

# "quero um copinho, com duas bolas de sorvete, uma de chocolate e outra de creme"
# nós dizemos pro robô sorveteiro

# "SELECT year, month, day, weight_pounds FROM `publicdata.samples.natality`"
# nós dizemos pro SGBD
# selecione, ano, mês e dia da tabela identificada por "publicdata.samples.natality"

library(bigrquery)
billing <- "curso-r" # replace this with your project ID 
sql <- "SELECT year, month, day, weight_pounds FROM `publicdata.samples.natality`"

library(DBI)

# 1º você precisa criar uma conexão com uma banco de dados
con <- dbConnect(
  bigrquery::bigquery(),
  project = "publicdata",
  dataset = "samples",
  billing = billing
)
con
# esse "con" é como se fosse o canal de comunicação entre vc
# e o SGBD, que está esperando seus comandos

# dbConnect(
# MySQL(),
# host = "publico.minha-empresa.com.br",
# user = "voce",
# senha = "123@"
#)

sql <- "SELECT year, month, day, weight_pounds FROM `publicdata.samples.natality`"

dbListTables(con)

# Eu posso por exemplo mandar "pedidos" de dados ao SGBD 
# que tem um nome especial esses "pedidos":
# query

library(tidyverse)
library(DBI)

conexao_ideb <- dbConnect(
  bigrquery::bigquery(),
  project = "basedosdados",
  dataset = "br_inep_ideb",
  billing = "curso-r"
)

arrow::read_parquet

# usar o dbplyr -----------------------------------------------------------

# dbplyr é uma mistura de DPLYR com SQL que permite que você escreva
# em DPLYR e o R """entenda""" em SQL:

library(dplyr)

#devtools::install_github("r-dbi/bigrquery")

tabela_municipio <- tbl(conexao_ideb, "municipio")
# com esse tbl uma "menção" a uma tabela específica

funcao_minha <- function(x){mean(x)}

linhas_id_municipio_10 <- tabela_municipio |> 
  group_by(sigla_uf, rede, ensino) |> 
  summarise(
    taxa_aprovacao = AVG(taxa_aprovacao)
  ) |> 
  head(10)

linhas_id_municipio_10

linhas_id_municipio_10 |> 
  show_query()

vindo_pro_r_como_tabela <- linhas_id_municipio_10 |> 
  collect()

vindo_pro_r_como_tabela