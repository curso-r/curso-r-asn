# Carregar pacotes --------------------------------------------------------

library(tidyverse)

# Ler base IMDB -----------------------------------------------------------

imdb <- read_csv2("imdb2.csv")

imdb <- imdb %>%
  mutate(lucro = receita - orcamento)

# fazendo graficos ggplot2 ------------------------------------------------

# ideia do ggplot2:

# 1. todo gráfico depende de uma ou mais tabelas por trás.
# "por trás de todo grande gráfico existe uma grande tabela"
# consequência: toda vez que você for fazer um gráfico vc deve
# passar uma tabela inteira pra ele, não só uma coluna ou algo assim.

# 2. todo gráfico pode ser construído em camadas. 
# consequência: você vai informar pro R a ordem com que vc quer
# que as coisas do seu gráfico sejam incluídas na tela e 
# tudo que tem na tela vc vai mandar aparecer (implicitamente ou não,
# mas normalmente é explícito)

# tem mais princípios, que vão aparecer depois...

imdb |> 
  ggplot()
# isso aqui faz a primeira camada e diz que a tabela "principal" 
# do gráfico é a tabela "imdb"
# isso aqui se chama internamente "canvas", que em ingles quer dizer
# "tela"

# por padrão a primeira camada do ggplot é um fundo cinza. todo o 
# resto vai entrar em cima

# agora podemos colocar mais camadas:

imdb |>
  # essa é a tabela "mãe" do gráfico, as colunas vão fazer mençõ
  # a ela:
  ggplot() +
  geom_point(aes(x = orcamento, y = receita)) +
  geom_hline(yintercept = 100000000, color = 'red')

imdb |> 
  ggplot() +
  geom_hline(yintercept = 100000000, color = 'red') +
  geom_point(aes(x = orcamento, y = receita)) 
# os pontos estão em cima da linha! a ordem importa muito
# o ggplot desenha na ordem que eu escrevi os comandos

# coisas que podem dar errado!

# 1. você pode trocar o "+" por "|>"

imdb |> 
  ggplot() |> 
  geom_point(aes(x = orcamento, y = receita))

# aqui ele me avisa! correção: trocar os |> depois de "ggplot" por
# +

imdb |> 
  ggplot() +
  geom_point(aes(x = orcamento, y = receita))

# 2. você pode escrever incorretamente o nome de uma coluna:

imdb |> 
  ggplot() + 
  geom_point(aes(x = orçamento, y = receita))
# "objeto orçamento não encontrado" quer dizer que
# o R tentou procurar "orçamento" nas colunas da tabela mãe (imdb)
# não tendo achado, foi procurar no seu environment (suas variáveis)
# e não tendo achado deu erro

# essencialmente tudo que a gente vê na tela é um "geom" ou
# objeto geométrico. Ele se chama assim porque faz menção, na maior
# parte das vezes, às coordenadas cartesianas (X e Y) do seu gráfico.
# toda camada "geom_???" vai seguir um padrão: vai depender
# de x ou de y ainda que os nomes não sejam exatamente esses.

# para por aí? não! os pontinhos tem muitas características parametrizáveis
# cor:

# Carregar pacotes --------------------------------------------------------

library(tidyverse)

# Ler base IMDB -----------------------------------------------------------

imdb <- read_csv2("imdb2.csv")

imdb <- imdb %>%
  mutate(lucro = receita - orcamento)

# fazendo graficos ggplot2 ------------------------------------------------

# ideia do ggplot2:

# 1. todo gráfico depende de uma ou mais tabelas por trás.
# "por trás de todo grande gráfico existe uma grande tabela"
# consequência: toda vez que você for fazer um gráfico vc deve
# passar uma tabela inteira pra ele, não só uma coluna ou algo assim.

# 2. todo gráfico pode ser construído em camadas. 
# consequência: você vai informar pro R a ordem com que vc quer
# que as coisas do seu gráfico sejam incluídas na tela e 
# tudo que tem na tela vc vai mandar aparecer (implicitamente ou não,
# mas normalmente é explícito)

# tem mais princípios, que vão aparecer depois...

imdb |> 
  ggplot()
# isso aqui faz a primeira camada e diz que a tabela "principal" 
# do gráfico é a tabela "imdb"
# isso aqui se chama internamente "canvas", que em ingles quer dizer
# "tela"

# por padrão a primeira camada do ggplot é um fundo cinza. todo o 
# resto vai entrar em cima

# agora podemos colocar mais camadas:

imdb |>
  # essa é a tabela "mãe" do gráfico, as colunas vão fazer mençõ
  # a ela:
  ggplot() +
  geom_point(aes(x = orcamento, y = receita)) +
  geom_hline(yintercept = 100000000, color = 'red')

imdb |> 
  ggplot() +
  geom_hline(yintercept = 100000000, color = 'red') +
  geom_point(aes(x = orcamento, y = receita)) 
# os pontos estão em cima da linha! a ordem importa muito
# o ggplot desenha na ordem que eu escrevi os comandos

# coisas que podem dar errado!

# 1. você pode trocar o "+" por "|>"

imdb |> 
  ggplot() |> 
  geom_point(aes(x = orcamento, y = receita))

# aqui ele me avisa! correção: trocar os |> depois de "ggplot" por
# +

imdb |> 
  ggplot() +
  geom_point(aes(x = orcamento, y = receita))

# 2. você pode escrever incorretamente o nome de uma coluna:

imdb |> 
  ggplot() + 
  geom_point(aes(x = orçamento, y = receita))
# "objeto orçamento não encontrado" quer dizer que
# o R tentou procurar "orçamento" nas colunas da tabela mãe (imdb)
# não tendo achado, foi procurar no seu environment (suas variáveis)
# e não tendo achado deu erro

# essencialmente tudo que a gente vê na tela é um "geom" ou
# objeto geométrico. Ele se chama assim porque faz menção, na maior
# parte das vezes, às coordenadas cartesianas (X e Y) do seu gráfico.
# toda camada "geom_???" vai seguir um padrão: vai depender
# de x ou de y ainda que os nomes não sejam exatamente esses.

# para por aí? não! os pontinhos tem muitas características parametrizáveis
# cor:

grafico <- imdb |> 
  mutate(
    filme_velho = ifelse(ano <= 1990, "Velho", "Novo")
  ) |> 
  ggplot() +
  geom_point(aes(
    x = orcamento,
    y = receita,
    color = filme_velho)) +
  scale_y_continuous(
    breaks = seq(0, 2000*10^6, 500*10^6),
    labels = scales::dollar_format(
      prefix = "USD ",
      suffix = " Millions",
      scale = 10^(-6),
      decimal.mark = ",",
      big.mark = ".")) +
  scale_x_continuous(
    labels = scales::dollar_format(
      prefix = "USD",
      decimal.mark = ",",
      big.mark = ".")
  ) + annotate("point", x = 100000000, y = 2000000000, color = 'red', size = 10)
# a função annotate deixa a gente colocar de maneira direta um elemento geométrico
# sem relação com a tabela mãe

install.packages("plotly")
library(plotly)

ggplotly(grafico)

# aqui tem uma mágica!!! transformar ggplot em plotly

# pergunta do tiago foi a seguinte:
# consigo mudar o padrão de apresentação dos eixos??

# R: SIM, absolutamente tudo que está num gráfico de ggplot
# é passível de alteração. E não só passível, como pertence
# a uma classificação.

#### coisas na tela se dividem entre:

# objeto geométrico (dentro da caixa de X e Y)
# escalas (que marjeiam o gráfico) (legendas no geral!)
# fundo
# margem
# 

# respondendo a pergunta: 
# função que serve pra mexer em escala
# se chama scale_????

grafico_legal <- imdb |> 
  mutate(
    lucrou = ifelse(receita-orcamento > 0, "Lucrou", "Deu prejuízo")
  ) |> 
  drop_na() |> 
  ggplot() +
  geom_point(aes(x = orcamento, y = receita, color = lucrou))

ggsave(filename = "grafico_legal.jpg", plot = grafico_legal)

# Filosofia ---------------------------------------------------------------

# Um gráfico estatístico é uma representação visual dos dados 
# por meio de atributos estéticos (posição, cor, forma, 
# tamanho, ...) de formas geométricas (pontos, linhas,
# barras, ...). Leland Wilkinson, The Grammar of Graphics

# Layered grammar of graphics: cada elemento do 
# gráfico pode ser representado por uma camada e 
# um gráfico seria a sobreposição dessas camadas.
# Hadley Wickham, A layered grammar of graphics 

# antes de falar de atributo estético vamos voltar na ideia
# de que é possível construir graficos a partir de tabelas
# feitas "ao vivo", explicitamente pro gráfico

# nota média dos filmes ao longo do ano

imdb |> 
  group_by(ano) |> 
  summarise(
    nota_media = mean(nota_imdb)
  ) |> 
  ggplot() +
    geom_point(aes(x = ano, y = nota_media))

imdb |> 
  group_by(ano) |> 
  summarise(
    nota_media = mean(nota_imdb)
  ) |> 
  ggplot() +
  geom_line(aes(x = ano, y = nota_media))

imdb |> 
  group_by(ano) |> 
  summarise(
    nota_media = round(mean(nota_imdb), 1)
  ) |> 
  ggplot() +
  geom_line(aes(x = ano, y = nota_media))+
  geom_point(aes(x = ano, y = nota_media)) +
  geom_label(aes(x = ano, y = nota_media, label = nota_media)) +
  ggtitle("Nota ao longo dos anos", subtitle = "Dados coletados e sumarizados usando dplyr.") +
  labs(x = "Ano", y = "Nota média dos filmes", caption = "Fonte: IMDB")
# label = "rótulo de dados" do Excel

# alternativamente: 
imdb |> 
  group_by(ano) |> 
  summarise(
    nota_media = round(mean(nota_imdb), 1)
  ) |> 
  ggplot(aes(x = ano, y = nota_media, label = nota_media)) +
  # evita que eu precise repetir os "aes(...)"
  geom_line() +
  geom_point() +
  geom_label() +
  ggtitle("Nota ao longo dos anos", subtitle = "Dados coletados e sumarizados usando dplyr.") +
  labs(x = "Ano", y = "Nota média dos filmes", caption = "Fonte: IMDB")

# essa sintaxe tem a ver com o fato de que o leland pensou que
# todo gráfico precisa de um mapeamento de colunas em atributos estéticos

# mas nada mais é do que a ideia de que fazer um gráfico segue a seguinte receita:

# 1. pegue uma tabela
# 2. considere que x = coluna1_da_tabela
# 3. considere que y = coluna2_da_tabela
# 4. inclua pontos.

# alternativamente: 
imdb |> 
  group_by(ano) |> 
  summarise(
    nota_media = round(mean(nota_imdb), 1),
    nota_maxima = max(nota_imdb)
  ) |> 
  ggplot(aes(x = ano, y = nota_media, label = nota_media)) +
  # evita que eu precise repetir os "aes(...)"
  geom_line() +
  # está usando o x e y padrão definido no mapeamento
  # AESTHETIC do ggplot
  geom_line(aes(x = ano, y = nota_maxima), color = 'red') + 
  # aqui não!!!!! aqui nós explicitamente definimos um novo
  # AESTHETIC
  geom_point() +
  # está usando o x e y padrão definido no mapeamento
  # AESTHETIC do ggplot
  ggtitle("Nota ao longo dos anos", subtitle = "Dados coletados e sumarizados usando dplyr. A linha vermelha representa as notas máximas de cada ano.") +
  labs(x = "Ano", y = "Nota média/máxima dos filmes", caption = "Fonte: IMDB")

# Gráfico de barras -------------------------------------------------------


imdb |> 
  group_by(ano) |> 
  summarise(
    nota_media = round(mean(nota_imdb), 1),
    nota_maxima = max(nota_imdb)
  ) |> 
  ggplot(aes(x = ano, y = nota_media, label = nota_media)) +
  # por padrão toda vez que precisar de um AESTHETIC (característica dos elementos geométricos)
  # use x sendo ano, y nota_media, label sendo nota_media tb (label é o texto que vai ser
  # exibido quando precisar)
  geom_col()

# pra colunas o ggplot2 adota uma convenção conveniente
# que é colocar o começo dos gráficos de colunas sempre no 0

# CUIDADO!!!

imdb |> 
  filter(ano >= 1900) |> 
  mutate(
    decada = floor(ano/10)*10,
    filme_velho = ifelse(decada >= 1970, "Novo", "Velho")
  ) |> 
  group_by(decada, filme_velho) |> 
  summarise(
    nota_media = round(mean(nota_imdb, na.rm = TRUE), 1),
    nota_maxima = max(nota_imdb)
  ) |> 
  ggplot(aes(x = decada, y = nota_media, label = nota_media, fill = filme_velho)) +
  # por padrão toda vez que precisar de um AESTHETIC (característica dos elementos geométricos)
  # use x sendo ano, y nota_media, label sendo nota_media tb (label é o texto que vai ser
  # exibido quando precisar)
  geom_col() +
  scale_y_continuous(limits = c(0, 10))
# aqui, color não é o atributo estético que a gente quer mexer normalmente, queremos mexer no 
# fill para colunas

# que o ggplot2 é muito conveniente para criar legendas! se você passou 
# certos atributo AESTHETIC que não x, y, label ou afiliados (alguns geom xmin, xmax, ymin etc)
# o ggplot2 coloca na legenda porque a premissa é que a pessoa que lê o gráfico
# precisa ser capaz de entender mais ou menos como era a tabela por trás

imdb |> 
  filter(ano >= 1900) |> 
  mutate(
    decada = floor(ano/10)*10,
    filme_velho = ifelse(decada >= 1970, "Novo", "Velho")
  ) |> 
  group_by(decada, filme_velho) |> 
  summarise(
    nota_media = round(mean(nota_imdb, na.rm = TRUE), 1),
    nota_maxima = max(nota_imdb)
  ) |> 
  ggplot(aes(x = decada, y = nota_media, label = nota_media, fill = filme_velho)) +
  # por padrão toda vez que precisar de um AESTHETIC (característica dos elementos geométricos)
  # use x sendo ano, y nota_media, label sendo nota_media tb (label é o texto que vai ser
  # exibido quando precisar)
  geom_col() +
  geom_point() +
  scale_y_continuous(limits = c(0, 10))
# sem passar "color" não tem ponto colorido!!!

g1 <- imdb |> 
  filter(ano >= 1900) |> 
  mutate(
    decada = floor(ano/10)*10,
    filme_velho = ifelse(decada >= 1970, "Novo", "Velho")
  ) |> 
  group_by(decada, filme_velho) |> 
  summarise(
    nota_media = round(mean(nota_imdb, na.rm = TRUE), 1),
    nota_maxima = max(nota_imdb)
  ) |> 
  ggplot(aes(x = decada, y = nota_media, label = nota_media,
             fill = filme_velho,
             shape = filme_velho)) +
  # por padrão toda vez que precisar de um AESTHETIC (característica dos elementos geométricos)
  # use x sendo ano, y nota_media, label sendo nota_media tb (label é o texto que vai ser
  # exibido quando precisar)
  geom_col() +
  geom_point() +
  scale_y_continuous(limits = c(0, 10))
# o ggplot é inteligente. ele pega os aes que eu fiz e vai empilhando do jeito que der
# na legenda

g2 <- imdb |> 
  filter(ano >= 1900) |> 
  mutate(
    decada = floor(ano/10)*10,
    filme_velho = ifelse(decada >= 1970, "Novo", "Velho")
  ) |> 
  group_by(decada, filme_velho) |> 
  summarise(
    nota_media = round(mean(nota_imdb, na.rm = TRUE), 1),
    nota_maxima = max(nota_imdb)
  ) |> 
  ggplot(aes(x = decada, y = nota_maxima, label = nota_media,
             fill = filme_velho,
             shape = filme_velho)) +
  # por padrão toda vez que precisar de um AESTHETIC (característica dos elementos geométricos)
  # use x sendo ano, y nota_media, label sendo nota_media tb (label é o texto que vai ser
  # exibido quando precisar)
  geom_col() +
  geom_point() +
  scale_y_continuous(limits = c(0, 10))

library(patchwork)

g1/g2

(g1+g1)/g2

# notação algebrica ^


# graficos de contagens ---------------------------------------------------


# Número de filmes das pessoas que dirigiram filmes na base
imdb |> 
  count(direcao)  |> 
  arrange(desc(n)) |> 
  head(10) |> 
  ggplot() +
  geom_col(aes(x = direcao, y = n))

imdb |> 
  count(direcao)  |> 
  arrange(desc(n)) |> 
  head(10) |> 
  ggplot() +
  geom_col(aes(y = direcao, x = n))

tabela_apoio <- imdb |> 
  count(direcao)  |> 
  arrange(desc(n)) |> 
  head(10) |> 
  mutate(
    direcao = fct_reorder(direcao, n)
  )

imdb |> 
  filter(
    direcao %in% c("Michael Curtiz", "Lesley Selander")
  ) |> 
  mutate(
    decada = floor(ano/10)*10,
  ) |> 
  count(direcao, decada) |> 
  ggplot(aes(y = direcao, x = n, fill = decada)) + 
  geom_col()

imdb |> 
  count(direcao)  |> 
  arrange(desc(n)) |> 
  head(10) |> 
  mutate(
    direcao = fct_reorder(direcao, n)
  ) |> 
  ggplot() +
  geom_col(
    aes(y = direcao, x = n, fill = direcao),
    show.legend = FALSE) +
  theme_bw()
# aqui o ggplot brilha particularmente! 
# manipulações "elegantes" que fazem gráficos
# do jeito que a gente quer

tabela_apoio|> 
  ggplot() +
  geom_col(
    aes(y = direcao, x = n, fill = direcao),
    show.legend = FALSE) +
  theme_minimal()


tabela_apoio|>
  mutate(
    decada = floor(ano/10)*10+1900
  ) |> 
  ggplot() +
  geom_col(
    aes(y = direcao, x = n, fill = direcao),
    show.legend = FALSE) 
# esse aqui é pra quando a gente quer só o posicionamento
# relativo dos geoms e vamos colocando os detalhes
# por cima manualmente. não se preocupe porque esse é um caso
# avançado mesmo...


# revisao dos geoms -------------------------------------------------------

# geom_point
# geom_col
# geom_line

imdb |> 
  mutate(
    lucrou = ifelse(receita-orcamento > 0, "Lucrou", "Deu prejuízo")
  ) |> 
  drop_na() |> 
  ggplot() +
  geom_point(aes(x = orcamento, y = receita, color = lucrou, size = lucro))


imdb |> 
  drop_na(ano) |> 
  group_by(
    decada = floor(ano/10)*10
  ) |> 
  summarise(
    orcamento_medio = mean(orcamento, na.rm = TRUE),
    receita_media = mean(receita, na.rm = TRUE),
    lucrou = receita_media > orcamento_medio
  ) |> 
  mutate(decada = as.character(decada)) |> 
  ggplot(aes(x = orcamento_medio, y = receita_media,
             color = decada, shape = lucrou)) + 
  geom_point(size = 5)



imdb |> 
  drop_na(ano) |> 
  group_by(
    decada = floor(ano/10)*10
  ) |> 
  summarise(
    percentual_que_lucrou = mean(receita > orcamento, na.rm = TRUE)
  ) |> 
  mutate(
    indicador_pandemia = ifelse(decada == "2020", "Pandemia", "Pré-pandemia")
  ) |> 
  ggplot(aes(x = decada, y = percentual_que_lucrou, linetype = indicador_pandemia)) +
  geom_col() + 
  geom_line() +
  geom_point(size = 4) 

# Outros geoms...

imdb |> 
  filter(direcao == "Steven Spielberg") |> 
  ggplot(aes(x = orcamento)) + 
  geom_histogram(
    binwidth = 100*10^6
  )

# deu certo, mas tá feio. outro gráfico:

imdb |> 
  ggplot(aes(x = nota_imdb)) + 
  geom_histogram()

# também tá feio:

imdb |> 
  ggplot(aes(x = nota_imdb)) + 
  geom_histogram(color = 'white', fill = 'royalblue') +
  theme_bw()

imdb |> 
  ggplot(aes(x = nota_imdb)) + 
  #geom_histogram(color = 'white', fill = 'royalblue') +
  geom_density()+
  theme_bw()

# tem como o histograma ficar "parecido" com a densidade!

imdb |> 
  ggplot(aes(x = nota_imdb)) + 
  geom_freqpoly()

# mas tem uma diferença importante: o freqpoly não é normalizado
# o y é contagem e não frequência relativa

?geom_freqpoly

imdb |> 
  mutate(decada = as.character(floor(ano/10)*10)) |> 
  ggplot(aes(x = decada, y = nota_imdb, fill = decada)) + 
  geom_boxplot()

imdb |> 
  mutate(decada = as.character(floor(ano/10)*10)) |> 
  ggplot(aes(x = nota_imdb, fill = decada)) + 
  geom_histogram(color = 'white')

# como a gente poderia deixar esse gráfico melhor?

# facet! fazendo vários gráficos de uma vez. vamos para um outro exemplo primeiro

imdb |> 
  filter(floor(ano/10)*10 == 1930) |> 
  mutate(lucro = receita-orcamento,
         lucrou = ifelse(lucro > 0, "Lucrou", "Deu prejuízo")) |> 
  ggplot(aes(x = orcamento, y = receita, color = lucrou)) + 
  geom_point()

# uma opção é usar o facet:

imdb |> 
  mutate(decada = floor(ano/10)*10) |> 
  mutate(lucro = receita-orcamento,
         lucrou = ifelse(lucro > 0, "Lucrou", "Deu prejuízo")) |> 
  ggplot(aes(x = orcamento, y = receita, color = lucrou)) + 
  geom_point() +
  facet_wrap(~decada)

# por padrão as escalas de todos os gráficos, pra facilitar a comparação,
# são as mesmas. se eu quiser que elas fiquem diferentes eu coloco
# um parâmetro:


imdb |> 
  mutate(decada = floor(ano/10)*10) |> 
  mutate(lucro = receita-orcamento,
         lucrou = ifelse(lucro > 0, "Lucrou", "Deu prejuízo")) |> 
  ggplot(aes(x = nota_imdb)) + 
  geom_histogram() +
  facet_wrap(~decada, scales = 'free_y')

imdb |> 
  mutate(decada = floor(ano/10)*10) |> 
  mutate(lucro = receita-orcamento,
         lucrou = ifelse(lucro > 0, "Lucrou", "Deu prejuízo")) |> 
  ggplot(aes(x = nota_imdb)) + 
  geom_density() +
  facet_wrap(~decada, scales = 'free_y')

imdb |> 
  mutate(decada = floor(ano/10)*10) |> 
  mutate(lucro = receita-orcamento,
         lucrou = ifelse(lucro > 0, "Lucrou", "Deu prejuízo")) |> 
  ggplot(aes(x = nota_imdb)) + 
  geom_density() +
  facet_wrap(~decada, scales = 'free_y', nrow = 8)

# é um jeito mais automático de fazer a mesma coisa que
# aparece no patchwork que vimos na ultima aula

library(patchwork)

grafico1 <- imdb |> 
  mutate(decada = floor(ano/10)*10) |> 
  filter(decada == 2000) |> 
  mutate(lucro = receita-orcamento,
         lucrou = ifelse(lucro > 0, "Lucrou", "Deu prejuízo")) |> 
  ggplot(aes(x = nota_imdb)) + 
  geom_density() 

grafico2 <- imdb |> 
  mutate(decada = floor(ano/10)*10) |> 
  filter(decada == 2010) |> 
  mutate(lucro = receita-orcamento,
         lucrou = ifelse(lucro > 0, "Lucrou", "Deu prejuízo")) |> 
  ggplot(aes(x = nota_imdb)) + 
  geom_density()

grafico1 + grafico2

# o facet garante que as escalas conversam legal!

dados_do_grafico <- imdb |> 
  mutate(decada = as.character(floor(ano/10)*10)) |> 
  filter(decada %in% c(2000, 2010)) 

amostra_2010 <- dados_do_grafico |> 
  filter(decada == 2010)

amostra_2000 <- dados_do_grafico |> 
  filter(decada == 2000)

teste <- ks.test(x = amostra_2000$nota_imdb, y = amostra_2010$nota_imdb)

teste <- t.test(x = amostra_2000$nota_imdb, y = amostra_2010$nota_imdb)

dados_do_grafico |> 
  mutate(lucro = receita-orcamento,
         lucrou = ifelse(lucro > 0, "Lucrou", "Deu prejuízo")) |> 
  ggplot(aes(x = nota_imdb, color = decada)) + 
  geom_density() +
  annotate("text", x = 5, y = 0.3,
           label = paste0("Valor-p do teste de KS para igualdade:\n", teste$p.value))


dados_do_grafico |> 
  mutate(lucro = receita-orcamento,
         lucrou = ifelse(lucro > 0, "Lucrou", "Deu prejuízo")) |> 
  ggplot(aes(x = nota_imdb, color = decada)) + 
  geom_density() +
  ggtitle("Densidade das notas do imdb nas décadas de 2000 e 2010", 
          subtitle = paste0("Valor-p do teste de KS para igualdade das dists:\n", teste$p.value)) +
  theme_bw()

imdb |> 
  mutate(decada = as.character(floor(ano/10)*10)) |> 
  mutate(lucro = receita-orcamento,
         lucrou = ifelse(lucro > 0, "Lucrou", "Deu prejuízo")) |> 
  ggplot(aes(x = nota_imdb, color = decada)) + 
  geom_density() +
  facet_wrap(~decada)

# Títulos e labels

imdb |> 
  drop_na() |> 
  mutate(lucro = ifelse(orcamento > receita, "Prejuízo", "Lucro")) |> 
  ggplot(aes(x = orcamento, y = receita, color = lucro)) +
  geom_point() +
  labs(
    x = "Orçamento ($ USD)",
    y = "Receita ($ USD)",
    title = "Gráfico de dispersão",
    subtitle = "Receita vs. Orçamento, ambos em dólares",
    color = "",
    caption = "Fonte: IMDB"
  )

# a função labs te dá controle sobre o título de tudo que é "escala" ou "legenda"

# labs é tipo uma "super" ggtitle


# exemplo clássico de escala x/y zoada. quando é dinheiro, e é dinheiro grande:
imdb |> 
  drop_na() |> 
  mutate(lucro = ifelse(orcamento > receita, "Prejuízo", "Lucro")) |> 
  ggplot(aes(x = orcamento, y = receita, color = lucro)) +
  geom_point() +
  labs(
    x = "Orçamento ($ USD)",
    y = "Receita ($ USD)",
    title = "Gráfico de dispersão",
    subtitle = "Receita vs. Orçamento, ambos em dólares",
    color = "",
    caption = "Fonte: IMDB"
  ) +
  scale_x_continuous(
    #breaks = c(0, 50*10^6, 100*10^6, 300*10^6, 400*10^6) na mão
    breaks = seq(0, 300*10^6, 50*10^6),
    # onde que o x vai quebrar
    labels = function(x){x/10^6}
    # define o que vai aparecer como RÓTULO pra cada x.
    # uma função que divide por 10^6 por exemplo é uma boa
  )

# CUIDADO! o eixo não sabe que vc dividiu por 10^6

imdb |> 
  drop_na() |> 
  mutate(lucro = ifelse(orcamento > receita, "Prejuízo", "Lucro")) |> 
  ggplot(aes(x = orcamento, y = receita, color = lucro)) +
  geom_point() +
  labs(
    x = "Orçamento (MM $ USD)",
    y = "Receita (MM $ USD)",
    title = "Gráfico de dispersão",
    subtitle = "Receita vs. Orçamento, ambos em dólares",
    color = "",
    caption = "Fonte: IMDB"
  ) +
  scale_x_continuous(
    #breaks = c(0, 50*10^6, 100*10^6, 300*10^6, 400*10^6) na mão
    breaks = seq(0, 300*10^6, 50*10^6),
    # onde que o x vai quebrar
    labels = function(x){
      ifelse(x/10^6 > 200, paste0("GDE: ", x/10^6), x/10^6)}
    # define o que vai aparecer como RÓTULO pra cada x.
    # uma função que divide por 10^6 por exemplo é uma boa
  ) +
  scale_y_continuous(
    #breaks = c(0, 50*10^6, 100*10^6, 300*10^6, 400*10^6) na mão
    #breaks = seq(0, *10^6, 100*10^6),
    # onde que o x vai quebrar
    labels = function(x){x/10^6}
    # define o que vai aparecer como RÓTULO pra cada x.
    # uma função que divide por 10^6 por exemplo é uma boa
  )

# fazer a função que transforma o x às vezes não é muito prático

# por isso no pacote scales tem um moooonte de funções prontas pra isso:

funcao_pre_pronta <- scales::dollar_format(scale = 10^(-6), 
                                           prefix = "$", big.mark = ".",
                                           decimal.mark = ",",
                                          suffix = "MM")

rotulos <-   labs(
  x = "Orçamento ($ USD)",
  y = "Receita ($ USD)",
  title = "Gráfico de dispersão",
  subtitle = "Receita vs. Orçamento, ambos em dólares",
  color = "",
  caption = "Fonte: IMDB"
)

imdb |> 
  drop_na() |> 
  mutate(lucro = ifelse(orcamento > receita, "Prejuízo", "Lucro")) |> 
  ggplot(aes(x = orcamento, y = receita, color = lucro)) +
  geom_point() +
  rotulos + 
  scale_x_continuous(
    #breaks = c(0, 50*10^6, 100*10^6, 300*10^6, 400*10^6) na mão
    breaks = seq(0, 300*10^6, 50*10^6),
    # onde que o x vai quebrar
    labels = funcao_pre_pronta
    # define o que vai aparecer como RÓTULO pra cada x.
    # uma função que divide por 10^6 por exemplo é uma boa
  ) +
  scale_y_continuous(
    breaks = seq(0, 3*10^9, 0.5*10^9),
    #breaks = seq(0, *10^6, 100*10^6),
    # onde que o x vai quebrar
    labels = scales::dollar_format(scale = 10^(-9), 
                                   prefix = "$", big.mark = ".",
                                   decimal.mark = ",",
                                   suffix = "Bi")
    # define o que vai aparecer como RÓTULO pra cada x.
    # uma função que divide por 10^6 por exemplo é uma boa
  ) +
  theme_bw()

# toda função pra mexer em escala/legenda vai se chamar scale_(atributo)_(continuous/discrete/...)

# vamos focar primeiro, porque o resto é só caso particular, no contínuou (numérico/inteiro)
# vs discreto

# scale_x_
# scale_fill_??
# scale_color_??

# tem um parâmetro de (quase) todos os scales que eu não falei nas continuas,
# mas nas discretas é importante:
  
# values

  imdb |> 
  drop_na() |> 
  mutate(lucro = ifelse(orcamento > receita, '0', '1')) |> 
  ggplot(aes(x = orcamento, y = receita, color = lucro)) +
  geom_point() +
  rotulos + 
  scale_x_continuous(
    #breaks = c(0, 50*10^6, 100*10^6, 300*10^6, 400*10^6) na mão
    breaks = seq(0, 300*10^6, 50*10^6),
    # onde que o x vai quebrar
    labels = funcao_pre_pronta
    # define o que vai aparecer como RÓTULO pra cada x.
    # uma função que divide por 10^6 por exemplo é uma boa
  ) +
  scale_y_continuous(
    breaks = seq(0, 3*10^9, 0.5*10^9),
    #breaks = seq(0, *10^6, 100*10^6),
    # onde que o x vai quebrar
    labels = scales::dollar_format(scale = 10^(-9), 
                                   prefix = "$", big.mark = ".",
                                   decimal.mark = ",",
                                   suffix = "Bi")
    # define o que vai aparecer como RÓTULO pra cada x.
    # uma função que divide por 10^6 por exemplo é uma boa
  ) +
  scale_color_manual(values = c("0" = "darkred", "1" = "darkgreen"),
                     labels = c("0" = "Prejuízo", "1" = "Lucro")) + 
  theme_bw() +
  theme(legend.position = 'bottom',
        axis.text = element_text(face = "bold"))
  # tudo que nós não vimos como mexer aqui nessa aula, praticamente,
  # você altera pela função "theme"

  
