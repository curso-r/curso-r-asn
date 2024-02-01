library(readxl)
library(readr)
library(tidyverse)

# read_excel("imdb_nao_estruturada.xlsx")

imdb <- read_csv2("imdb2.csv")

glimpse(imdb)

# Analisar ----------------------------------------------------------------

# Quais são os filmes mais caros, mais lucrativos e com melhor nota do ano de 2020?

base_filmes_2020 <- imdb |> 
  filter(ano == 2020)

# mais caro ---------------------------------------------------------------

filmes_ordenados_por_orcamento <- base_filmes_2020 |> 
  arrange(desc(orcamento)) 

filmes_ordenados_por_orcamento[1,]
# podemos a primeira linha desse jeito

filmes_ordenados_por_orcamento |> 
  head(1)
# faz a mesma coisa que o comando acima

filmes_ordenados_por_orcamento |> 
  head(3)

# outro jeito de pensar...

base_filmes_2020 |> 
  filter(orcamento == 90000000)
# se eu colocasse uma formula que encontra esse  90 milhões de USD
# esse pipeline ficaria "automático"

maximo <- max(base_filmes_2020$orcamento, na.rm = TRUE)

base_filmes_2020 |> 
  filter(orcamento == max(base_filmes_2020$orcamento, na.rm = TRUE))
# deu errado! o orcamento tá cheio de missing, e o max quando tem missing no meio
# retorna NA e aí já era...

base_filmes_2020 |> 
  filter(orcamento == max(orcamento, na.rm = TRUE))
# funcionou!!!

### BONUS!!!! como eu faria pra encontrar o filme mais caro de fazer em cada ano?

# começo do pensamento:

resultado <- imdb %>%
  group_by(ano) %>%
  summarise(Maior_Valor = max(orcamento, na.rm = TRUE))
# estamos no caminho certo, mas não é exatamente o que a gente queria

# imdb. 
# groupby(['ano']).
# query('orcamento  == np.max(orcamento)')

imdb |> 
  group_by(ano) |> 
  filter(orcamento == max(orcamento, na.rm = TRUE)) |> 
  View()

# a única mudança que precisamos fazer é trocar o "summarise" por "filter"
# que vai dar o resultado que a gente esperava

aggregate(orcamento ~ ano, data = imdb, FUN = max)


# mais lucrativo ----------------------------------------------------------

base_filmes_2020 |> 
  mutate(
    lucro = receita-orcamento
  ) |> 
  # tivemos que fazer um passo intermediário pra gerar a coluna de lucro
  filter(
    lucro == max(lucro, na.rm = TRUE)
  )

# maior nota --------------------------------------------------------------

base_filmes_2020 |> 
  filter(
    nota_imdb == max(nota_imdb)
  ) |> View()

# esse aqui não precisa remover os NA. TOP!

imdb |> 
  group_by(ano) |> 
  filter(
    nota_imdb == max(nota_imdb)
  ) |> View()

# e se quiséssemos os filmes com maior lucro por DÉCADA

filme_lucrativo_1960 <- imdb |> 
  filter(
    ano %in% 1960:1969
  ) |> 
  mutate(
    lucro = receita-orcamento
  ) |> 
  filter(lucro == max(lucro, na.rm = TRUE))

# OPÇÃO 1: repetir com ctrl+c e ctrl+v o mesmo código mudando o ano:

filme_lucrativo_1970 <- imdb |> 
  filter(
    ano %in% 1970:1979
  ) |> 
  mutate(
    lucro = receita-orcamento
  ) |> 
  filter(lucro == max(lucro, na.rm = TRUE))

bind_rows(filme_lucrativo_1960, filme_lucrativo_1970)
# a função "bind_rows" empilha duas tabelas tão bem quanto ela conseguir,
# isso é, se tiver colunas com nome igual nas duas tabelas ela empilha,
# se nao tiver ela mantém as duas e preenche as lacunas com NA etc
# parecido com o concat do python

# OPÇÃO 2: fazer um loop no R que recalcula uma por uma e ao invés de ser com
# ctrl+c e ctrl+v, o computador que se ocupa das repetições

decadas <- c(0, 10, 20, 30, 40, 50, 60, 70, 80, 90)

resultado_final <- NULL
for(decada in decadas){

  #decada <- 70
  
  ranges_do_pedro <- 1900 + decada + 0:9

  aux <- imdb |> 
    filter(
      ano %in% ranges_do_pedro
    ) |> 
    mutate(
      lucro = receita-orcamento,
      decada = decada, .after = ano
    ) |> 
    filter(lucro == max(lucro, na.rm = TRUE))
  
  resultado_final <- bind_rows(resultado_final, aux)
}

# não vou falar do loop agora porque eu quero focar no dplyr:

#isso aqui já sabemos fazer:
imdb |> 
  mutate(lucro = receita-orcamento) |> 
  group_by(ano) |> 
  filter(lucro == max(lucro, na.rm = TRUE))

as.numeric(substr(as.character(1909), 3, 3))*10

imdb |> 
  filter(ano >= 1900, ano < 2000) |>  
  mutate(
    lucro = receita-orcamento,
    decada = as.numeric(substr(as.character(ano), 3, 3))*10,
    .after = ano) |> 
  group_by(decada) |> 
  filter(lucro == max(lucro, na.rm = TRUE)) 

imdb |> 
  filter(ano >= 1900, ano < 2000) |>  
  mutate(
    lucro = receita-orcamento,
    decada = as.numeric(substr(as.character(ano), 3, 3))*10,
    .after = ano) |> 
  group_by(decada) |> 
  summarise(
    maior_lucro = max(lucro, na.rm = TRUE),
    nota_media = mean(nota_imdb),
    freq = n()
  ) 

# estaria perfeito se eu soubesse preencher esse ?????

# o que queremos: uma comando em R que pegue o vetor "ano"
# e transforma na década correspondete. 1970 -> 70, 1984 -> 80. 2000 -> 0 e por aí vai

# ideia do luiz:
# pegar o terceiro dígito do "ano" e multiplicar por 10
# ideia do luiz: as.numeric(substr(as.character(ano), 3, 3))*10

as.numeric(substr(as.character(2012), 3, 3))*10
as.numeric(substr(as.character(1912), 3, 3))*10

imdb |> 
  #filter(ano >= 1900, ano < 2000) |>  
  mutate(
    lucro = receita-orcamento,
    decada = case_when(
      ano < 2000 ~ paste("1. Década de", as.numeric(substr(as.character(ano), 3, 3))*10, "do século XX"),
      ano >= 1900 ~ paste("2. Década de", as.numeric(substr(as.character(ano), 3, 3))*10, "do século XXI")
      ),
    .after = ano) |> 
  group_by(decada) |> 
  summarise(
    maior_lucro = max(lucro, na.rm = TRUE),
    nota_media = mean(nota_imdb),
    freq = n()
  )  |> View()

imdb |> 
  #filter(ano >= 1900, ano < 2000) |>  
  mutate(
    lucro = receita-orcamento,
    decada = case_when(
      ano < 2000 ~ paste("Década de", floor(ano/10)*10, "do século XX"),
      ano >= 1900 ~ paste("Década de", floor(ano/10)*10, "do século XXI")
    ),
    .after = ano) |> 
  group_by(decada) |> 
  summarise(
    maior_lucro = max(lucro, na.rm = TRUE),
    nota_media = mean(nota_imdb),
    freq = n()
  )  |> View()

# sugestão proposta: 

base_filmes_decada <- imdb|>
  mutate(decada = floor(ano/10)*10, lucro = receita - orcamento, .after = ano)

base_filmes_decada |>
  group_by(decada)|>
  filter(lucro == max(lucro, na.rm = TRUE))|>
  arrange(decada)|>
  View()


