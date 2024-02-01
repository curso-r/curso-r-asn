
# Intepretação ------------------------------------------------------------

### Preparação para o dplyr/Manipulação


library(abjData)
library(tidyverse)
dados_pnud <- pnud_min


# Esse tópico será abordado na aula seguinte, mas o objetivo deste exercício
# é já ir se acostumando com o conteúdo!
# A ideia é que vocês interpretem os códigos a seguir
# (olhando o código e o resultado), e tentem explicar o que acham que aconteceu.
#
# Para ajudar, segue um resumo de algumas funções útes:
#
# - `select()`: seleciona colunas da base de dados
# - `filter()`: filtra linhas da base de dados
# - `arrange()`: reordena as linhas da base de dados
# - `mutate()`: cria novas colunas da base de dados (ou atualiza as colunas existentes)
# - `group_by()` + `summarise()`: agrupa e sumariza da base de dados
# - `count()`: faz uma contagem por grupos
#
# Já vimos que podemos filtar os dados da seguinte forma: no exemplo a seguir
# buscamos as linhas onde o ano seja igual à 2010.
#

filter(dados_pnud, ano == 2010)

#
# Podemos reescrever esse código desta forma, usando o pipe, que é usado para
# criar sequências de códigos:
#

dados_pnud |>
  filter(ano == 2010)

# Vamos ver o pipe em outro exemplo! O que você acha que a função abaixo fez?
# Execute e veja o resultado. Pode escrever com as suas palavras :)
#
# SUA INTERPRETAÇÃO: ...

dados_pnud_2010 |>
  count(uf_sigla)

#
#
# SUA INTERPRETAÇÃO: ...
#
dados_pnud_2010 |>
  count(regiao_nm)

#
#
# SUA INTERPRETAÇÃO: ...
#
dados_pnud_2010 |>
  count(regiao_nm) |>
  arrange(n)

# SUA INTERPRETAÇÃO: ...
#
#
dados_pnud_2010 |>
  select(muni_nm, uf_sigla, pop)

#
# SUA INTERPRETAÇÃO: ...
#
dados_pnud_2010 |>
  select(muni_nm, uf_sigla, pop) |>
  filter(pop > 1000000)

#
# SUA INTERPRETAÇÃO: ...
#
dados_pnud_2010 |>
  select(muni_nm, uf_sigla, pop) |>
  filter(pop > 1000000) |>
  arrange(desc(pop))

#
# SUA INTERPRETAÇÃO: ...
#
dados_pnud_2010 |>
  select(muni_nm, uf_sigla, pop) |>
  filter(pop > 1000000) |>
  arrange(desc(pop)) |>
  mutate(pop_milhoes = pop / 1000000)

#
# SUA INTERPRETAÇÃO: ...
#
dados_pnud_2010 |>
  select(muni_nm, uf_sigla, pop) |>
  filter(pop > 1000000) |>
  arrange(desc(pop)) |>
  mutate(pop_milhoes = round(pop / 1000000, 2))


# Prática -----------------------------------------------------------------

# Treinando as funções:

# dplyr::select()
# dplyr::arrange()
# dplyr::filter()
# dplyr::count()
# dplyr::distinct()

# Carregando dados
library(abjData)
library(tidyverse)
dados_pnud <- pnud_min
dados_pnud |> names()
# "ano"       "muni_id"   "muni_nm"   "uf_sigla"  "regiao_nm" "idhm"
# "idhm_e"    "idhm_l"    "idhm_r"    "espvida"   "rdpc"      "gini"
# "pop"  "lat"       "lon"

# Dica: para alguns exercícios, é importante filtrar os dados de 2010, pois
# a base apresenta dados de 3 anos diferentes, o que triplica os municípios na base.
distinct(dados_pnud, ano)

# Exercicio 1) Crie uma tabela com o número de municípios por estado.

# Exercício 2) Crie uma tabela com o número de municípios por região.

# Exercício 3) Crie uma tabela com o número de municípios por região,
# ordenada por número de municípios.

# Exercício 4) Crie uma tabela com o número de municípios por região,
# ordenada por número de municípios, em ordem decrescente.


# Exercício 5) Crie uma tabela, com dados de 2010, que apresente o nome dos municípios,
# a sigla do estado e a população do município, ordenada de forma decrescente pela
# população.

# DICAS DO PASSO A PASSO:
# a) Usando os dados dados_pnud, selecione as colunas ano, muni_nm,
# uf_sigla e pop, nesta ordem.
# b) Filtre apenas os dados de 2010.
# c) Ordene os dados por população, em ordem decrescente.


# Exercício 6) Crie uma tabela, com dados de 2010, que apresente o nome do
#  município, a sigla do estado e a população, para municípios com mais de 1 milhão
#  de habitantes, ordenada por população, em ordem decrescente.


# Exercício 7) Crie uma tabela, com dados de 2010, que apresente o nome do município,
# a sigla do estado e o IDH municipal (idhm), ordenando para apresentar
# primeiro os municípios com maior IDH municipal.

# Treinar verbos do dplyr
# count()
# filter()
# mutate()


# Carregando dados
library(abjData)
library(tidyverse)
dados_pnud <- pnud_min
dados_pnud |> names()
# "ano"       "muni_id"   "muni_nm"   "uf_sigla"  "regiao_nm" "idhm"
# "idhm_e"    "idhm_l"    "idhm_r"    "espvida"   "rdpc"      "gini"
# "pop"  "lat"       "lon"

# Dica: para alguns exercícios, é importante filtrar os dados de 2010, pois
# a base apresenta dados de 3 anos diferentes, o que triplica os municípios na base.
distinct(dados_pnud, ano)



# Exercício 1) Crie uma tabela chamada dados_pnud_2010, com apenas os dados de 2010.
# Vamos usar esse objeto daqui em diante!


# Exercicio 2) Crie uma tabela com o número de municípios por estado.



# Exercício 3) Crie uma tabela com o número de municípios por região.




# Exercício 4) Crie uma tabela com municípios que tinham uma população maior que 1 milhão
# de habitantes em 2010, ordenada por população, em ordem decrescente.



# Exercício 5) Usando a tabela acima, crie uma coluna de população em milhões de habitantes,
# chamada pop_milhoes, para facilitar a visualização dos dados. Exemplo:

# # A tibble: 14 × 4
#    muni_nm        uf_sigla      pop pop_milhoes
#    <chr>          <chr>       <int>       <dbl>
#  1 SÃO PAULO      SP       11166543       11.2
#  2 RIO DE JANEIRO RJ        6262802        6.26
#  3 SALVADOR       BA        2647972        2.65
#  4 BRASÍLIA       DF        2541714        2.54
#  5 FORTALEZA      CE        2424565        2.42
#  6 Belo Horizonte MG        2356178        2.36
#  7 MANAUS         AM        1787596        1.79
#  8 CURITIBA       PR        1740627        1.74
#  9 RECIFE         PE        1522583        1.52
# 10 PORTO ALEGRE   RS        1393799        1.39
# 11 BELÉM          PA        1381212        1.38
# 12 GOIÂNIA        GO        1297017        1.30
# 13 GUARULHOS      SP        1212934        1.21
# 14 CAMPINAS       SP        1071443        1.07

# Treinar verbos do dplyr

# Ex 1: Volte no exercício 4, onde interpretamos alguns códigos de
# manipulação de dados feitos com dplyr.
# Revise o exercício, e note se a sua interpretação inicial estava
# correta!

# Ex 2: Leia o capítulo 7.2 do livro "Ciência de Dados em R"
# sobre o pacote dplyr
# https://livro.curso-r.com/7-2-dplyr.html

#para instalar o abjData
#install.packages("devtools")
#devtools::install_packages("abjData")

# Carregando dados
library(abjData)
library(tidyverse)
dados_pnud <- pnud_min
dados_pnud_uf <- pnud_uf




# Ex 3: Usando a tabela `dados_pnud`, vamos criar uma tabela com as seguintes informações:
#  Soma da população em milhões, no ano de 2010, agrupado por região do Brasil.
# A tabela deve estar ordenada de forma decrescente segundo a população em milhões.
# Exemplo do que queremos gerar:

# |Região	         |População em milhões (2010)|
# |----------------|---------|
# |Sudeste	       |  79.48  |
# |Nordeste	       |  52.01  |
# |Sul	           |  27.14  |
# |Norte	         |  15.18  |
# |Centro-Oeste	   |  13.84  |

# Escreva o código para gerar essa tabela a seguir:


# Ex 4: Usando as tabelas dados_pnud_uf e dados_pnud, responda as perguntas:


dados_pnud_uf |>
  glimpse()

dados_pnud |>
  glimpse()



# a) Qual a média de IDHM em 2010 para cada região do Brasil?

# b) Qual a média de IDHM em 2010 para cada estado do Brasil?

# c) A tabela abaixo (esp_vida_uf) apresenta a esperança de vida para cada estado do Brasil,
# nos diferentes anos do censo. Usando essa tabela e as funções do dplyr vistas
# no curso, busque responder: qual é o estado onde a esperança de vida mais cresceu entre
# 1991 e 2010? Qual é o estado onde a esperança de vida menos cresceu entre 1991 e 2010?

esp_vida_uf <- dados_pnud_uf |>
  select(ano, ufn, espvida) |>
  # alterando o formato da tabela: cada ano vira uma coluna, e os valores
  # de espvida são colocados em cada coluna.
  # essa função NÃO foi vista no curso, é conteúdo do R para Ciência de Dados II!
  pivot_wider(names_from = ano, values_from = espvida, names_prefix = "espvida_")






# Ex 4: Caso se sinta confortável lendo em inglês,
# leia este capítulo do livro R for Data Science sobre o pacote dplyr:
# https://r4ds.hadley.nz/data-transform

# Ex 5: Caso se sinta confortável lendo em inglês,
# leia este capítulo do livro R for Data Science sobre joins:
# https://r4ds.hadley.nz/joins
