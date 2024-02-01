
# código pré-pronto -------------------------------------------------------



escala_padrao_x <- scale_x_continuous(
  breaks = seq(0, 300*10^6, 50*10^6),
  labels = funcao_pre_pronta
)

escala_padrao_y <- scale_y_continuous(
  breaks = seq(0, 3*10^9, 0.5*10^9),
  labels = scales::dollar_format(scale = 10^(-9), 
                                 prefix = "$", big.mark = ".",
                                 decimal.mark = ",",
                                 suffix = "Bi")
)

aplica_escalas <- function(grafico_pronto){
  grafico_pronto + 
    escala_padrao_x +
    escala_padrao_y +
    theme_bw()
}


# aplicação ---------------------------------------------------------------

grafico <- imdb |> 
  drop_na() |> 
  mutate(lucro = ifelse(orcamento > receita, "Prejuízo", "Lucro")) |> 
  ggplot(aes(x = orcamento, y = receita, color = lucro)) +
  geom_point()

grafico_no_padrao <- aplica_escalas(grafico)

