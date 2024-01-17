library(tidyverse)

# vamos agora falar do pacote dplyr 
# o dplyr junto com o tidyr são o equivalente mais ou menos do
# pandas dentro do R

imdb <- read_csv("https://raw.githubusercontent.com/curso-r/main-r4ds-1/master/dados/imdb.csv")

nrow(imdb)

# se o seu código for uma sequências de funções aplicadas sobre
# tabelas, o seu código vai ficar legal semanticamente
# isso é, vai ser razoavelmente fácil de um ser humano
# entender o que o código faz e mais
# é fácil de imaginar os códigos que precisam

# pro seu código de parecer com uma frase, seria legal se 
# as nossas funções fossem verbos, de ordem que eu dou pro computador fazer

# existem 6 verbos, que vão ser cristalizados em funções
# que se eu misturar eles várias vezes em ordens diferentes eu consigo
# descrever muitas e muitas manipulações que eu vou precisar com dados
# esses 6 verbos atendem uma grande parte (digamos 80%) dos comandos 
# de manipulação que a gente vai querer fazer

# select() - SELECIONAR colunas de uma tabela pra ficar, e o resto vai embora
# arrange() - REORDENAR linhas de uma tabela a partir de colunas
# filter() - FILTRAR linhas de uma tabela mantendo algumas e jogando outras fora
# mutate() - CRIAR colunas novas a partir de comandos em R
# summarise() + groupby() - SUMARIZAR uma tabela em partes menores, extraindo resumos estatísticos etc
# o groupby vai ordenar que as SUMARIZAÇÕES respeitem agrupamentos
# ***_joins - JUNTAR tabelas diferentes de acordo com algum critério de correspondência

# summarise ---------------------------------------------------------------

# padrão summarise(TABELA, RESUMO)
# será interpretado pelo R como SUMARIZE a TABELA, aplicando a fórmula que está em RESUMO

summarise(imdb, mean(nota_imdb), sd(nota_imdb), var(nota_imdb), max(nota_imdb), min(nota_imdb))
# mean(imdb$nota_imdb)


summarise(imdb, mean(nota_imdb), sd(nota_imdb), var(nota_imdb), max(nota_imdb), min(nota_imdb))
# se eu quiser dar nomes pros sumários eu posso... só que eu vou precisar
# usar "=" ao invés de "<-", dentro das funções do dplyr só pode usar "=" e nunca "<-"

summarise(imdb, nota_media = mean(nota_imdb), desvio_padrao = sd(nota_imdb))

# filter ------------------------------------------------------------------

#filter(TABELA, CRITERIO)
# o R vai interpretar assim: FILTRE apenas as linhas de TABELA que satisfizerem CRITERIO
# CRITERIO tem que ser uma comparação lógica, necessariamente...
# compração lógica é qualquer comando que envolva uma coluna, números/textos e
# um sinal de >, <, !=, ==, entre outros 

filter(imdb, ano > 2000)

# pra fazer a nota média dos filmes que vieram depois de 2000 eu posso então
# fazer uma mistura dos dois comandos:

filmes_recentes <- filter(imdb, ano > 2000)

summarise(filmes_recentes, nota_media = mean(nota_imdb))

# vamos tentar fazer a nota dos filmes velhos

filmes_velhos <- filter(imdb, ano < 1970)

summarise(filmes_velhos, nota_media = mean(nota_imdb))

# alguém (pode ser eu mesmo...) quer saber se os filmes antigos são melhores do que
# os novos. Sendo assim eu posso pensar que seria legal ter das médias de filmes antigos
# e as médias de filmes novos pra eu comparar...

# as funções do dplyr juntinhas me dão um jeito de fazer isso!

# 1º eu filtro só filmes velhos/novos

# 2º eu mando o R calcular uma média das notas pra mim...

# a gente poderia ter feito não em 2 passos, mas direto:

summarise(filter(imdb, ano < 1970), nota_media = mean(nota_imdb))

# é mais ou menos a lógica acima ^ que o dplyr vai tentar te ajudar a implementar...

# o estilo incentivado no dplyr é outro...

# um estilo que inverte essa ordem ^

filter(imdb, ano < 1970)
# eu gostaria de poder reescrever esse comando me aproximando da seguinte frase:
# a partir de IMDB, FILTRE apenas as linhas em que ANO < 1970

# FILTRE de IMDB as linhas em que ANO < 1970
# o dplyr oferece um jeito de eu tirar o imdb de dentro do filter usando um sinal
# |>

imdb |> filter(ano < 1970)
# a partir de IMDB, FILTRE apenas as linhas em que ANO < 1970

# a vantagem dessa notação é que eu posso colocar novos se eu quiser!
summarise(filter(imdb, ano < 1970), nota_media = mean(nota_imdb))

imdb |> filter(ano < 1970) |> summarise(nota_media = mean(nota_imdb))
# o sinal de |> dá uma noção de ordem pro comando que nós estamos mandando o R fazer!
# o meu código então agora parece uma receita, ou uma lista de instruções:

# 1. quebre os ovos
# 2. misture a farinha e os ovos
# 3. jogue um pouco de água
# 4. sove a massa
# ....
# 5. unte a assadeira
# 6. coloque a massa na assadeira
# 7. coloque a massa no forno

imdb |>
  filter(ano < 1970) |>
  summarise(nota_media = mean(nota_imdb))
# o ideal é pular linhas entre as aplicações dos verbos!!

# imdb seria um pandas DataFrame
# imdb.query("ano < 1970").aggregate('mean')

# a proposta do dplyr é te dar quase como que uma linguagem pra vc
# produzir os seus pipelines de dado. de um lado (em cima) entra uma tabela
# e depois dai outra no final. os dados vão "escorrendo" pelos verbos do dplyr
# que vão transformado os dados várias vezes

# mais sobre o filter -----------------------------------------------------

# como eu poderia parametrizar outras seleções de linhas pra calcular a média?

imdb |>
  filter(ano < 1970) |>
  summarise(nota_media = mean(nota_imdb))

# pra isso vou precisar usar os maquinários de comparações e operações lógicas do R

imdb$ano < 1970
# o filter, e tudo do dplyr, me poupa o trabalho de ter que escrever
#"coluna 'ano' que mora dentro de imdb
# imdb$ano
# o filter mantém apenas os TRUE, e joga fora os FALSE

# aquele CRITERIO do filter na verdade pode ser qualquer coisa que no R
# consegue trazer pra TRUE e FALSE só dá TRUE, FALSE no R comandos que não usem atribuição e usem
# pelo menos um dos símbos dentre

# COMPARADORES LÓGICOS (comparam o que está à esquerda e à direita)
# ==, <, >, !=, %in%
# OPERADORES LÓGICOS
# & (e), | (ou), () parênteses, ~ (não)
# ano > 1970 & ano < 1975 ---------> ano MAIOR que 1970 E ano MENOR que 1975

# um CRITERIO pode ficar arbitrariamente complicado conforme eu misturo operadores e comparadores

imdb |>
  filter(ano < 1970 & ano > 1960) |>
  # filmes da década de 1960
  summarise(nota_media = mean(nota_imdb))

imdb |>
  filter((ano < 1970 & ano >= 1960) | (ano >= 1980 & ano < 1990)) |>
  # filmes da década de 1960 ou da década de 80
  summarise(nota_media = mean(nota_imdb))

(imdb$ano < 1970 & imdb$ano >= 1960) | (imdb$ano >= 1980 & imdb$ano < 1990)

# todas linguagens são equipadas com a álgebra lógica, inclusive a tabela verdade:
# TRUE | FALSE dá TRUE
# TRUE & FALSE dá FALSE


# dplyr vs data.table -----------------------------------------------------

# data.table é mais performático?? resposta: sim
# o que é ser mais performático: rodar mais rápido para a mesma tarefa em outras linguagens
# e as vezes usar menos memória RAM pra rodar (ou até HD em certos casos).
# consequentemente se vc tiver uma RAM limitada, só o data.table vai dar conta (às vezes)

# utiliza menos linhas??? resposta: não exatamente,
# o código tende a ser mais aninhado
# tabela[tabela$ano > 1970, coluna_nova := log(tabela$nota_imdb)]

# dtplyr, que vc escreve em dplyr, ele traduz pra data.table por trás
# e roda em data.table e te devolve a saída como se fosse dplyr

# Filtos e NA -------------------------------------------------------------

# no R, por ser uma linguagem de estatística, quem a fez se preocupa muitoooo
# com dados faltantes uma coisa que é diferente no R com relação a outras linguagens
# é o que acontece quando vc tenta fazer uma media com numeros faltantes:

imdb |> 
  summarise(mean(orcamento))
# como tem NA na coluna, o R na função "mean" não calcula a média
# se tem NA no meio, naturalmente a média também seria faltante

# não é o padrão do SQL
# não é o padrão do PANDAS
# no PANDAS np.nan que é parecido com o NA do R, a diferença é que
# o np.nan é removido por padrão no np.mean

# na verdade no SQL a gente nem tem um jeito de representar NA que seja diferente
# do "vazio matemático" NULL

# no R tem NA (que é faltante) e NULL que é vazio matemático/computacional

imdb |> 
  summarise(mean(orcamento, na.rm = TRUE))

imdb |> 
  summarise(max(orcamento, na.rm = TRUE))

# uma exceção importante é o filter, em que o R efetivamente remove os NA

imdb |> 
  filter(orcamento > 1000000)

imdb$orcamento > 1000000
imdb$orcamento == NA
# isso aqui, embora intuitivo não funciona
# o que funciona é
is.na(imdb$orcamento)

imdb |> 
  filter((orcamento > 1000000) | is.na(orcamento))

# agora vamos voltar pra regra, que é que o NA é considerado sempre de alguma foram

# arrange -----------------------------------------------------------------

imdb_ordenado_por_ano <- imdb |> 
  arrange(ano)
#por padrão o arrange ordena em ordem crescente

imdb |> 
  arrange(desc(ano))
# eu posso querer fazer uma ordem descrescente, basta aplicar a função "desc" na coluna

imdb |>
  arrange(desc(orcamento)) |>
  View()

# select ------------------------------------------------------------------

melhores_filmes_spielberg <- imdb |> 
  filter(direcao == "Steven Spielberg") |> 
  arrange(desc(nota_imdb)) |> 
  select(titulo, nota_imdb)

write_csv2(melhores_filmes_spielberg, "melhores_filmes.csv")

# como o select funciona... 

# select(TABELA, COLUNA1, COLUNA2, COLUNA3, ...)
# TABELA |> select(COLUNA1, COLUNA2, COLUNA3, ...)

imdb |> 
  filter(direcao == "Steven Spielberg") |> 
  arrange(desc(nota_imdb)) |> 
  select(titulo, nota_imdb)

imdb |> 
  filter(direcao == "Steven Spielberg") |> 
  arrange(desc(nota_imdb)) |> 
  select(titulo:nota_imdb)

imdb |> 
  filter(direcao == "Steven Spielberg") |> 
  arrange(desc(nota_imdb)) |> 
  select(titulo, nota_imdb, starts_with("num"))

imdb |> 
  filter(direcao == "Steven Spielberg") |> 
  arrange(desc(nota_imdb)) |> 
  select(titulo, nota_imdb, ends_with("cao"))

imdb |> 
  filter(direcao == "Steven Spielberg") |> 
  arrange(desc(nota_imdb)) |> 
  select(titulo, nota_imdb, contains("cri"))

# group_by + summarise ----------------------------------------------------

imdb |> 
  summarise(
    nota_media = mean(nota_imdb),
    numero_de_filmes = n()
  )

# as vezes a gente precisa de uma nota por valor distintos
# em uma coluna:

imdb |> 
  filter(direcao == "'Evil' Ted Smith") |> 
  summarise(nota_media = mean(nota_imdb))

imdb |> 
  filter(direcao == "'Philthy' Phil Phillips") |> 
  summarise(nota_media = mean(nota_imdb))

# isso pra todos os diretores...

imdb |>
  group_by(direcao) |> 
  summarise(
    nota_media = mean(nota_imdb),
    numero_de_filmes = n()) |> 
  filter(numero_de_filmes > 10) |> 
  arrange(desc(nota_media))
# esse aqui ^ é o tipo de pipeline do dplyr
# em que ele começa a brilhar...

# 1. pegue o imdb
# 2. agrupe por direcao
# 3. realize sumarizacoes de contagem do numero de filmes por
# direcao e nota_media por direcao
# 4. filtre apenas aquelas sumarizacoes em que o numero de filmes
# é maior do que 10
# 5. ordene a tabela de maior nota para a menor nota

# SQL <-> DPLYR -----------------------------------------------------------

# imdb <- dbplyr::src_memdb() %>%
#   copy_to(imdb, name = "mtcars2-cc", overwrite = TRUE)
# esse comando cria a tabela imdb em um abnco de dados descartável
# e guarda uma representação dessa tabela em R

con <- DBI::dbConnect(
  host = "externo.banco-tiago.com",
  user = "usuario",
  senha = "senha"
)

notas_medias_diretores <- imdb |> 
  group_by(direcao) |> 
  summarise(
    nota_media = mean(nota_imdb)
  )

imdb |> 
  left_join(notas_medias_diretores) |> 
  show_query()

tbl(con, "tabela_fato") |>
  group_by(direcao) |> 
  summarise(
    nota_media = mean(nota_imdb),
    numero_de_filmes = n()) |> 
  filter(numero_de_filmes > 10) |> 
  arrange(desc(nota_media)) |> 
  collect()
# essa show_query serve pra mostrar que o dplyr
# tem uma integração suave com SQL. eu posso escrever em dplyr
# e existe uma função de tradução que já executa lá se eu quiser

# voltando ao group by ----------------------------------------------------

nota_media_direcao <- imdb |>
  group_by(direcao) |> 
  summarise(
    nota_media = mean(nota_imdb),
    numero_de_filmes = n())

nota_media_direcao_diretores_mais_frequentes <- nota_media_direcao |>
  filter(numero_de_filmes > 10) |> 
  arrange(direcao, desc(nota_media)) |> 
  ungroup()


# coisas que podem dar errado no dplyr ------------------------------------

# TOP COISA NUMERO 1 voce chamar uma coluna que não existe

imdb |> 
  filter(Ano > 2010)
# não existe o objeto "Ano", na vdd a coluna se chama "ano"

# TOP COISA NUMERO 2 é vc esquecer o pipe:

imdb #|> 
  filter(ano > 2010)
  
# TOP COISA NUMERO 3 quando vc faz um summarise cujo resultado não
# é uma sumarização
  
imdb |> 
  summarise(
    mean(duracao/60)
  )

# menções honrosas

# esquecer do na.rm

# esquecer da ","

imdb |> 
  arrange(ano direcao)
# aqui o R até te avisa, então é um erro um pouco menos pior

# esquecer de dar library(tidyverse)

imdb |> 
  filter(ano > 2010)
# porque não é o filter do dplyr que tá sendo usado...
# é o filter do R básico, que mora no pacote stats

# esquecer que existe is.na

library(dplyr)

imdb |> 
  filter(orcamento == NA)

# outro erro comum no filter...
# esquecer de colocar o CRITERIO

imdb |> 
  filter(ano)

class(TRUE)

# usar o pipe incorretamente também pode dar problema

imdb |> 
  select(imdb, ano)
# se eu passei imdb no pipe, ele já vai pegar o que vem antes do pipe
# e passar pra próxima função, não precisa repetir.
# se eu repetir, o R fica confuso


# mutate ------------------------------------------------------------------

## vou precisar usar um pacote que se chama readr
library(tidyverse)
library(DBI)
# ^ aqui estamos revendo como chamar pacote pra ter mais funções
# disponíveis

imdb <- read_csv("imdb.csv")

imdb

# serve pra criar colunas! tem uma sintaxe meio parecida com a do summarise

imdb |> 
  filter(ano == 2010)

imdb |> 
  summarise(
    duracao = mean(duracao)
  )

imdb_duracao_horas <- imdb |> 
  mutate(
    duracao_horas = duracao/60
  )

imdb |> 
  mutate(
    duracao_horas = duracao/60, .after = duracao
  )

imdb |> 
  mutate(duracao_horas = duracao/60) |> 
  summarise(
    duracao_horas_media = mean(duracao_horas)
  )

imdb |> 
  summarise(
    duracao_horas_media = mean(duracao/60)
  )
# os dois dão a mesma coisa!

tabela_nota_media <- imdb |> 
  mutate(
    saldo = receita-orcamento,
    lucrou = saldo > 0, .after = idioma
  ) |> 
  filter(lucrou) |> 
  summarise(nota_media = mean(nota_imdb))

# mutate + filter + summarise com SQL -------------------------------------

# exemplo do bigquery


tabela_municipio <- tbl(conexao_ideb, "municipio")
# com esse tbl uma "menção" a uma tabela específica

funcao_minha <- function(x){mean(x)}

mutate_filter_summarise <- tabela_municipio |> 
  mutate(
    taxa_aprovacao_grande = taxa_aprovacao > 70
  ) |> 
  filter(taxa_aprovacao_grande) |> 
  summarise(
    nota_ideb = mean(ideb)
  )

mutate_filter_summarise |> 
  show_query()

# voltando ao mutate ------------------------------------------------------

imdb_resumida <- imdb |> 
  select(titulo, ano, duracao, receita, orcamento, nota_imdb)

imdb_com_colunas <- imdb |> 
  mutate(
    duracao_horas = duracao/60,
    receita_milhoes = receita/10^6,
    orcamento_milhoes = orcamento/10^6,
    lucro_milhoes = receita_milhoes - orcamento_milhoes
  )

# Em Python é meio comum você ver códigos (que não são recomendados por alguns especialistas em Python!)

# imdb['duracao_horas'] = imdb['duracao']/60
# imdb['receita_milhoes'] = imdb['receita']/10**6
# aqui tem bastante repetição ^

# imdb.assign(
#  duracao_horas = duracao/60,
#  receita_milhoes = receita/10^6,
#)
# isso aqui é igualzinho o mutate! mas é menos usado, embora seja um método
# do pandas tão filho de Deus quanto qualquer outro

# o mutate realmente brilha quando você usa funções dentro dele,
# tipo uma função que a gente não viu ainda, que se chama ifelse

imdb_categorizado <- imdb |> 
  mutate(
    tipo_filme = ifelse(ano > 1990, "Filme novo", "Filme velho"), .after = ano
  )

imdb_categorizado

imdb_categorizacao_maior <- imdb_resumida |> 
  mutate(
    tipo_filme = ifelse(ano > 1990, "Filme novo", "Filme velho"),
    nota_categorizada = case_when(
      nota_imdb > 9 ~ "Filmaço",
      8 < nota_imdb & nota_imdb <= 9 ~ "Filme muito bom",
      7 < nota_imdb & nota_imdb <= 8 ~ "Filme legal",
      5 < nota_imdb & nota_imdb <= 7 ~ "Filme médio",
      nota_imdb <= 5 ~ "Filme ruim"
    )
  )

imdb_categorizacao_maior |> 
  count(tipo_filme, nota_categorizada)

# o mutate aceita group_by! -----------------------------------------------

imdb_categorizacao_maior |> 
  count(nota_categorizada) |> 
  mutate(percentual = n/sum(n))

imdb_categorizacao_maior |> 
  count(tipo_filme, nota_categorizada) |> 
  mutate(percentual = n/sum(n))

imdb_categorizacao_maior |> 
  count(tipo_filme, nota_categorizada) |> 
  group_by(tipo_filme) |> 
  mutate(
    total_de_filmes_no_grupo = sum(n),
    percentual = n/total_de_filmes_no_grupo)

# Python:

# contagem = imdb_categ.groupby(["tipo_filme", "nota_categorizada"]).count()
# contagem.groupby(["tipo_filme", "nota_categorizada"]).assign(freq = np.sum(n)) 

imdb |> 
  drop_na(
    orcamento, receita
  ) |> 
  select(titulo, ano, receita, orcamento) |> 
  mutate(
    saldo = receita-orcamento,
    lucrou = ifelse(saldo > 0, "Lucrou", "Não lucrou")
  )
