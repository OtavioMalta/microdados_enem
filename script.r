# Author: Otávio Malta
# github.com/OtavioMalta

# Limpar ambiente
rm(list=ls()) 
gc()         

library(ggplot2)
if(!require(data.table)){install.packages('data.table')}
if(!require(dplyr)) install.packages("dplyr")
library (data.table)
library(dplyr)
memory.limit(24576)

# Setar diretório
setwd("C:/Users/Otavio/Downloads/microdados_enem_2016/DADOS")
getwd()

# Importar dados
ENEM_2016 <- data.table::fread(input = "C:/Users/Otavio/Downloads/microdados_enem_2016/DADOS/MICRODADOS_ENEM_2016.csv", integer64 = "character"
                               ,skip=0,  
                               nrow=-1, 
                               na.strings = " ", 
                               showProgress = TRUE)

# Filtrar por escola privada
# 'D' para bolsitas e 'E' para não bolsistas
enem_priv_2016 <- ENEM_2016 %>% filter(Q047 == 'E')

# Selecionar colunas
enem_priv_2016 <- select(enem_priv_2016,Q001,Q002,Q003,Q004,Q006,Q026,Q047,NU_NOTA_CN,NU_NOTA_CH,NU_NOTA_LC,NU_NOTA_MT,NU_NOTA_REDACAO)

# Renomear colunas
enem_priv_2016 <- rename(.data = enem_priv_2016,
                     "escolaridadePai"=Q001,
                     "escolaridadeMae"=Q002,
                     "ocupacaoPai"=Q003,
                     "ocupacaoMae"=Q004,
                     "rendaMensal"=Q006,
                     "remuneracao"='Q026',
                     "ensinoMedio"=Q047,
)

# Renomear valores
enem_priv_2016 <- mutate(.data = enem_priv_2016,
                   escolaridadePai = case_when(
                     escolaridadePai == 'A' ~ "Nunca estudou",
                     escolaridadePai == 'B' ~ "Não completou a 4º série/S* ano do Ensino Fundamental.",
                     escolaridadePai == 'C' ~ "Completou a 4º série/5* ano, mas não completou a 8º série/9º ano do Ensino Fundamental.",
                     escolaridadePai == 'D' ~ "Completou a 8º série/9º ano do Ensino Fundamental, mas não completou o Ensino Médio.",
                     escolaridadePai == 'E' ~ "Completou o Ensino Médio, mas não completou a Faculdade.",
                     escolaridadePai == 'F' ~ "Completou a Faculdade, mas não completou a Pós-graduação.",
                     escolaridadePai == 'G' ~ "Completou a Pós-graduação.",
                     escolaridadePai == 'H' ~ "Não sei"
                   ),
                   escolaridadeMae = case_when(
                     escolaridadeMae == 'A' ~ "Nunca estudou",
                     escolaridadeMae == 'B' ~ "Não completou a 4º série/S* ano do Ensino Fundamental.",
                     escolaridadeMae == 'C' ~ "Completou a 4º série/5* ano, mas não completou a 8º série/9º ano do Ensino Fundamental.",
                     escolaridadeMae == 'D' ~ "Completou a 8º série/9º ano do Ensino Fundamental, mas não completou o Ensino Médio.",
                     escolaridadeMae == 'E' ~ "Completou o Ensino Médio, mas não completou a Faculdade.",
                     escolaridadeMae == 'F' ~ "Completou a Faculdade, mas não completou a Pós-graduação.",
                     escolaridadeMae == 'G' ~ "Completou a Pós-graduação.",
                     escolaridadeMae == 'H' ~ "Não sei"
                   ),
                   ocupacaoPai = case_when(
                     ocupacaoPai == 'A' ~ "Grupo 1: Lavrador, agricultor sem empregados, bóia fria, criador de animais (gado, porcos, galinhas, ovelhas, cavalos etc.), apicultor, pescador, lenhador, seringueiro, extrativista.",
                     ocupacaoPai == 'B' ~ "Grupo 2: Diarista, empregado doméstico, cuidador de idosos, babá, cozinheiro (em casas particulares), motorista particular, jardineiro, faxineiro de empresas e prédios, vigilante, porteiro, carteiro, office-boy, vendedor, caixa, atendente de loja, auxiliar administrativo, recepcionista, servente de pedreiro, repositor de mercadoria.",
                     ocupacaoPai == 'C' ~ "Grupo 3: Padeiro, cozinheiro industrial ou em restaurantes, sapateiro, costureiro, joalheiro, torneiro mecânico, operador de máquinas, soldador, operário de fábrica, trabalhador da mineração, pedreiro, pintor, eletricista, encanador, motorista, caminhoneiro, taxista.",
                     ocupacaoPai == 'D' ~ "Grupo 4: Professor (de ensino fundamental ou médio, idioma, música, artes etc.), técnico (de enfermagem, contabilidade, eletrônica etc.), policial, militar de baixa patente (soldado, cabo, sargento), corretor de imóveis, supervisor, gerente, mestre de obras, pastor, microempresário (proprietário de empresa com menos de 10 empregados), pequeno comerciante, pequeno proprietário de terras, trabalhador autônomo ou por conta própria.",
                     ocupacaoPai == 'E' ~ "Grupo 5: Médico, engenheiro, dentista, psicólogo, economista, advogado, juiz, promotor, defensor, delegado, tenente, capitão, coronel, professor universitário, diretor em empresas públicas ou privadas, político, proprietário de empresas com mais de 10 empregados.",
                     ocupacaoPai == 'F' ~ "Não sei."
                     ),
                   ocupacaoMae = case_when(
                     ocupacaoMae == 'A' ~ "Grupo 1: Lavrador, agricultor sem empregados, bóia fria, criador de animais (gado, porcos, galinhas, ovelhas, cavalos etc.), apicultor, pescador, lenhador, seringueiro, extrativista.",
                     ocupacaoMae == 'B' ~ "Grupo 2: Diarista, empregado doméstico, cuidador de idosos, babá, cozinheiro (em casas particulares), motorista particular, jardineiro, faxineiro de empresas e prédios, vigilante, porteiro, carteiro, office-boy, vendedor, caixa, atendente de loja, auxiliar administrativo, recepcionista, servente de pedreiro, repositor de mercadoria.",
                     ocupacaoMae == 'C' ~ "Grupo 3: Padeiro, cozinheiro industrial ou em restaurantes, sapateiro, costureiro, joalheiro, torneiro mecânico, operador de máquinas, soldador, operário de fábrica, trabalhador da mineração, pedreiro, pintor, eletricista, encanador, motorista, caminhoneiro, taxista.",
                     ocupacaoMae == 'D' ~ "Grupo 4: Professor (de ensino fundamental ou médio, idioma, música, artes etc.), técnico (de enfermagem, contabilidade, eletrônica etc.), policial, militar de baixa patente (soldado, cabo, sargento), corretor de imóveis, supervisor, gerente, mestre de obras, pastor, microempresário (proprietário de empresa com menos de 10 empregados), pequeno comerciante, pequeno proprietário de terras, trabalhador autônomo ou por conta própria.",
                     ocupacaoMae == 'E' ~ "Grupo 5: Médico, engenheiro, dentista, psicólogo, economista, advogado, juiz, promotor, defensor, delegado, tenente, capitão, coronel, professor universitário, diretor em empresas públicas ou privadas, político, proprietário de empresas com mais de 10 empregados.",
                     ocupacaoMae == 'F' ~ "Não sei."
                   ),
                   rendaMensal = case_when(
                     rendaMensal == 'A' ~ "Nenhuma renda.",
                     rendaMensal == 'B' ~ "Até R$ 880,00.",
                     rendaMensal == 'C' ~ "De R$ 880,01 até R$ 1.320,00.",
                     rendaMensal == 'D' ~ "De R$ 1.320,01 até R$ 1.760,00.",
                     rendaMensal == 'E' ~ "De R$ 1.760,01 até R$ 2.200,00.",
                     rendaMensal == 'F' ~ "De R$ 2.200,01 até R$ 2.640,00.",
                     rendaMensal == 'G' ~ "De R$ 2.640,01 até R$ 3.520,00.",
                     rendaMensal == 'H' ~ "De R$ 3.520,01 até R$ 4.400,00.",
                     rendaMensal == 'I' ~ "De R$ 4.400,01 até R$ 5.280,00.",
                     rendaMensal == 'J' ~ "De R$ 5.280,01 até R$ 6.160,00.",
                     rendaMensal == 'K' ~ "De R$ 6.160,01 até R$ 7.040,00.",
                     rendaMensal == 'L' ~ "De R$ 7.040,01 até R$ 7.920,00.",
                     rendaMensal == 'M' ~ "De R$ 7.920,01 até R$ 8.800,00.",
                     rendaMensal == 'N' ~ "De R$ 8.800,01 até R$ 10.560,00.",
                     rendaMensal == 'O' ~ "De R$ 10.560,01 até R$ 13.200,00.",
                     rendaMensal == 'P' ~ "De R$ 13.200,01 até R$ 17.600,00.",
                     rendaMensal == 'Q' ~ "Mais de R$ 17.600,00."
                   ),
                   
                   remuneracao = case_when(
                     remuneracao == 'A' ~ "Não, nunca trabalhei.",
                     remuneracao == 'B' ~ "Sim, já trabalhei, mas não estou trabalhando.",
                     remuneracao == 'C' ~ "Sim, estou trabalhando."
                   ),
                   ensinoMedio = case_when(
                     ensinoMedio == 'A' ~ "Somente em escola pública.",
                     ensinoMedio == 'B' ~ "Parte em escola pública e parte em escola privada sem bolsa de estudo integral.",
                     ensinoMedio == 'C' ~ "Parte em escola pública e parte em escola privada com bolsa de estudo integral.",
                     ensinoMedio == 'D' ~ "Somente em escola privada sem bolsa de estudo integral.",
                     ensinoMedio == 'E' ~ "Somente em escola privada com bolsa de estudo integral."
                   )
)

# Calcular a média das notas
medias <- enem_priv_2016 %>%
  summarise(
    CN = mean(NU_NOTA_CN, na.rm = TRUE),
    CH = mean(NU_NOTA_CH, na.rm = TRUE),
    LC = mean(NU_NOTA_LC, na.rm = TRUE),
    MT = mean(NU_NOTA_MT, na.rm = TRUE),
    RD = mean(NU_NOTA_REDACAO, na.rm = TRUE)
  )

#View(medias)
#View(enem_priv_2016)

# Formatar porcentagem
format_porcentagem <- function(percentage) {
  paste0(format(percentage, digits = 2, nsmall = 2), "%")
}

# Calcular a porcentagem de cada categoria
percentage_escolaridadePai <- enem_priv_2016 %>%
  count(escolaridadePai) %>%
  mutate(percentage = n / sum(n) * 100) %>%
  arrange(desc(percentage))

percentage_escolaridadeMae <- enem_priv_2016 %>%
  count(escolaridadeMae) %>%
  mutate(percentage = n / sum(n) * 100) %>%
  arrange(desc(percentage))

percentage_ocupacaoPai <- enem_priv_2016 %>%
  count(ocupacaoPai) %>%
  mutate(percentage = n / sum(n) * 100) %>%
  arrange(desc(percentage))

percentage_ocupacaoMae <- enem_priv_2016 %>%
  count(ocupacaoMae) %>%
  mutate(percentage = n / sum(n) * 100) %>%
  arrange(desc(percentage))

percentage_rendaMensal <- enem_priv_2016 %>%
  count(rendaMensal) %>%
  mutate(percentage = n / sum(n) * 100) %>%
  arrange(desc(percentage))

percentage_ensinoMedio <- enem_priv_2016 %>%
  count(ensinoMedio) %>%
  mutate(percentage = n / sum(n) * 100) %>%
  arrange(desc(percentage))

percentage_remuneracao <- enem_priv_2016 %>%
  count(remuneracao) %>%
  mutate(percentage = n / sum(n) * 100) %>%
  arrange(desc(percentage))

# Formatar porcentagem
enem_priv_2016$percentage <- format_porcentagem(enem_priv_2016$percentage)
percentage_escolaridadePai$percentage <- format_porcentagem(percentage_escolaridadePai$percentage)
percentage_escolaridadeMae$percentage <- format_porcentagem(percentage_escolaridadeMae$percentage)
percentage_ocupacaoPai$percentage <- format_porcentagem(percentage_ocupacaoPai$percentage)
percentage_ocupacaoMae$percentage <- format_porcentagem(percentage_ocupacaoMae$percentage)
percentage_rendaMensal$percentage <- format_porcentagem(percentage_rendaMensal$percentage)
percentage_ensinoMedio$percentage <- format_porcentagem(percentage_ensinoMedio$percentage)
percentage_remuneracao$percentage <- format_porcentagem(percentage_remuneracao$percentage)

# Exportar arquivos
write.table(percentage_escolaridadePai, file = "percentage_escolaridadePai.csv", sep = ",")
write.table(percentage_escolaridadeMae, file = "percentage_escolaridadeMae.csv", sep = ",")
write.table(percentage_ocupacaoPai, file = "percentage_ocupacaoPai.csv", sep = ",")
write.table(percentage_ocupacaoMae, file = "percentage_ocupacaoMae.csv", sep = ",")
write.table(percentage_rendaMensal, file = "percentage_rendaMensal.csv", sep = ",")
write.table(percentage_ensinoMedio, file = "percentage_ensinoMedio.csv", sep = ",")
write.table(percentage_remuneracao, file = "percentage_remuneracao.csv", sep = ",")
write.table(medias, file = "medias.csv", sep = ",")
# write.table(enem_priv_2016, file ="enem_priv_2016.csv", sep = ",")

# Alterar labels
custom_labels_escolaridadePai <- c(
  "Nunca estudou" = "Nunca estudou",
  "Não completou a 4º série/S* ano do Ensino Fundamental." = "Sem 4a",
  "Completou a 4º série/5* ano, mas não completou a 8º série/9º ano do Ensino Fundamental." = "Sem 8a",
  "Completou a 8º série/9º ano do Ensino Fundamental, mas não completou o Ensino Médio." = "Sem EM",
  "Completou o Ensino Médio, mas não completou a Faculdade." = "Sem Faculdade",
  "Completou a Faculdade, mas não completou a Pós-graduação." = "Sem Pós-Graduação",
  "Completou a Pós-graduação." = "Com Pós-graduação.",
  "Não sei" = "Não sei"
)

custom_labels_ocupacaoPai <- c(
  "Grupo 1: Lavrador, agricultor sem empregados, bóia fria, criador de animais (gado, porcos, galinhas, ovelhas, cavalos etc.), apicultor, pescador, lenhador, seringueiro, extrativista." = "Grupo 1",
  "Grupo 2: Diarista, empregado doméstico, cuidador de idosos, babá, cozinheiro (em casas particulares), motorista particular, jardineiro, faxineiro de empresas e prédios, vigilante, porteiro, carteiro, office-boy, vendedor, caixa, atendente de loja, auxiliar administrativo, recepcionista, servente de pedreiro, repositor de mercadoria." = "Grupo 2",
  "Grupo 3: Padeiro, cozinheiro industrial ou em restaurantes, sapateiro, costureiro, joalheiro, torneiro mecânico, operador de máquinas, soldador, operário de fábrica, trabalhador da mineração, pedreiro, pintor, eletricista, encanador, motorista, caminhoneiro, taxista." = "Grupo 3",
  "Grupo 4: Professor (de ensino fundamental ou médio, idioma, música, artes etc.), técnico (de enfermagem, contabilidade, eletrônica etc.), policial, militar de baixa patente (soldado, cabo, sargento), corretor de imóveis, supervisor, gerente, mestre de obras, pastor, microempresário (proprietário de empresa com menos de 10 empregados), pequeno comerciante, pequeno proprietário de terras, trabalhador autônomo ou por conta própria." = "Grupo 4",
  "Grupo 5: Médico, engenheiro, dentista, psicólogo, economista, advogado, juiz, promotor, defensor, delegado, tenente, capitão, coronel, professor universitário, diretor em empresas públicas ou privadas, político, proprietário de empresas com mais de 10 empregados." = "Grupo 5",
  "Não sei." = "Não sei"
)

custom_labels_escolaridadeMae <- c(
  "Nunca estudou" = "Nunca estudou",
  "Não completou a 4º série/S* ano do Ensino Fundamental." = "Sem 4a",
  "Completou a 4º série/5* ano, mas não completou a 8º série/9º ano do Ensino Fundamental." = "Sem 8a",
  "Completou a 8º série/9º ano do Ensino Fundamental, mas não completou o Ensino Médio." = "Sem EM",
  "Completou o Ensino Médio, mas não completou a Faculdade." = "Sem Faculdade",
  "Completou a Faculdade, mas não completou a Pós-graduação." = "Sem Pós-Graduação",
  "Completou a Pós-graduação." = "Com Pós-graduação.",
  "Não sei" = "Não sei"
)
custom_labels_ocupacaoMae <- c(
  "Grupo 1: Lavrador, agricultor sem empregados, bóia fria, criador de animais (gado, porcos, galinhas, ovelhas, cavalos etc.), apicultor, pescador, lenhador, seringueiro, extrativista." = "Grupo 1",
  "Grupo 2: Diarista, empregado doméstico, cuidador de idosos, babá, cozinheiro (em casas particulares), motorista particular, jardineiro, faxineiro de empresas e prédios, vigilante, porteiro, carteiro, office-boy, vendedor, caixa, atendente de loja, auxiliar administrativo, recepcionista, servente de pedreiro, repositor de mercadoria." = "Grupo 2",
  "Grupo 3: Padeiro, cozinheiro industrial ou em restaurantes, sapateiro, costureiro, joalheiro, torneiro mecânico, operador de máquinas, soldador, operário de fábrica, trabalhador da mineração, pedreiro, pintor, eletricista, encanador, motorista, caminhoneiro, taxista." = "Grupo 3",
  "Grupo 4: Professor (de ensino fundamental ou médio, idioma, música, artes etc.), técnico (de enfermagem, contabilidade, eletrônica etc.), policial, militar de baixa patente (soldado, cabo, sargento), corretor de imóveis, supervisor, gerente, mestre de obras, pastor, microempresário (proprietário de empresa com menos de 10 empregados), pequeno comerciante, pequeno proprietário de terras, trabalhador autônomo ou por conta própria." = "Grupo 4",
  "Grupo 5: Médico, engenheiro, dentista, psicólogo, economista, advogado, juiz, promotor, defensor, delegado, tenente, capitão, coronel, professor universitário, diretor em empresas públicas ou privadas, político, proprietário de empresas com mais de 10 empregados." = "Grupo 5",
  "Não sei." = "Não sei"
)

custom_labels_rendaMensal <- c(
  "Nenhuma renda" = "Nenhuma renda",
  "Até R$ 880,00" = "Até R$ 880",
  "De R$ 880,01 até R$ 1.320,00" = "De R$ 880 a R$ 1.3k",
  "De R$ 1.320,01 até R$ 1.760,00" = "De R$ 1.3k a R$ 1.8k",
  "De R$ 1.760,01 até R$ 2.200,00" = "De R$ 1.8k a R$ 2.2k",
  "De R$ 2.200,01 até R$ 2.640,00" = "De R$ 2.2k a R$ 2.6k",
  "De R$ 2.640,01 até R$ 3.520,00" = "De R$ 2.6k a R$ 3.5k",
  "De R$ 3.520,01 até R$ 4.400,00" = "De R$ 3.5k a R$ 4.4k",
  "De R$ 4.400,01 até R$ 5.280,00" = "De R$ 4.4k a R$ 5.3k",
  "De R$ 5.280,01 até R$ 6.160,00" = "De R$ 5.3k a R$ 6.2k",
  "De R$ 6.160,01 até R$ 7.040,00" = "De R$ 6.2k a R$ 7k",
  "De R$ 7.040,01 até R$ 7.920,00" = "De R$ 7k a R$ 7.9k",
  "De R$ 7.920,01 até R$ 8.800,00" = "De R$ 7.9k a R$ 8.8k",
  "De R$ 8.800,01 até R$ 10.560,00" = "De R$ 8.8k a R$ 10.6k",
  "De R$ 10.560,01 até R$ 13.200,00" = "De R$ 10.6k a R$ 13.2k",
  "De R$ 13.200,01 até R$ 17.600,00" = "De R$ 13.2k a R$ 17.6k",
  "Mais de R$ 17.600,00" = "Mais de R$ 17.6k"
)

# Gráficos
plot_escolaridadePai <- ggplot(percentage_escolaridadePai, aes(x = escolaridadePai, y = percentage)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  labs(title = "Escolaridade Pai",
       x = "Escolaridade Pai",
       y = "Percentage") +
  theme_minimal() +
  scale_x_discrete(labels = custom_labels_escolaridadePai)   +
  theme(
    panel.background = element_rect(fill = "white", color = NA),
    plot.background = element_rect(fill = "white", color = NA),
    axis.text.x = element_text(angle = 45, hjust = 1)
  )

plot_ocupacaoPai <- ggplot(percentage_ocupacaoPai, aes(x = ocupacaoPai, y = percentage)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  labs(title = "Ocupacao Pai",
       x = "Ocupacao Pai",
       y = "Percentage") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  scale_x_discrete(labels = custom_labels_ocupacaoPai)  +
  theme(
    panel.background = element_rect(fill = "white", color = NA),
    plot.background = element_rect(fill = "white", color = NA),
    axis.text.x = element_text(angle = 45, hjust = 1)
  )

plot_escolaridadeMae <- ggplot(percentage_escolaridadeMae, aes(x = escolaridadeMae, y = percentage)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  labs(title = "Escolaridade Mae",
       x = "Escolaridade Mae",
       y = "Percentage") +
  theme_minimal() +
  scale_x_discrete(labels = custom_labels_escolaridadeMae)   +
  theme(
    panel.background = element_rect(fill = "white", color = NA),
    plot.background = element_rect(fill = "white", color = NA),
    axis.text.x = element_text(angle = 45, hjust = 1)
  )

plot_ocupacaoMae <- ggplot(percentage_ocupacaoMae, aes(x = ocupacaoMae, y = percentage)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  labs(title = "Ocupacao Mae",
       x = "Ocupacao Mae",
       y = "Percentage") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  scale_x_discrete(labels = custom_labels_ocupacaoMae) +
  theme(
    panel.background = element_rect(fill = "white", color = NA),
    plot.background = element_rect(fill = "white", color = NA),
    axis.text.x = element_text(angle = 45, hjust = 1)
  )

percentage_rendaMensal <- percentage_rendaMensal[order(-as.numeric(gsub("%", "", percentage_rendaMensal$percentage))), ]
plot_rendaMensal <- ggplot(percentage_rendaMensal, aes(x = reorder(rendaMensal, -as.numeric(gsub("%", "", percentage))), y = percentage)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  labs(title = "Renda Mensal",
       x = "Renda Mensal",
       y = "Percentage") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  scale_x_discrete(labels = custom_labels_rendaMensal) +
  theme(
    panel.background = element_rect(fill = "white", color = NA),
    plot.background = element_rect(fill = "white", color = NA),
    axis.text.x = element_text(angle = 45, hjust = 1)
  )

plot_ensinoMedio <- ggplot(percentage_ensinoMedio, aes(x = ensinoMedio, y = percentage)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  labs(title = "Percentage of Ensino Medio",
       x = "Ensino Medio",
       y = "Percentage") +
  theme_minimal()  +
  theme(
    panel.background = element_rect(fill = "white", color = NA),
    plot.background = element_rect(fill = "white", color = NA),
    axis.text.x = element_text(angle = 45, hjust = 1)
  )
plot_ensinoMedio

plot_remuneracao <- ggplot(percentage_remuneracao, aes(x = remuneracao, y = percentage)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  labs(title = "Remuneracao",
       x = "Remuneracao",
       y = "Percentage") +
  theme_minimal()  +
  theme(
    panel.background = element_rect(fill = "white", color = NA),
    plot.background = element_rect(fill = "white", color = NA),
    axis.text.x = element_text(angle = 45, hjust = 1)
  )
plot_remuneracao

# Salvar gráficos
ggsave("plot_escolaridadePai.png", plot = plot_escolaridadePai, width = 20, height = 6, units = "in")
ggsave("plot_ocupacaoPai.png", plot = plot_ocupacaoPai, width = 10, height = 6, units = "in")
ggsave("plot_escolaridadeMae.png", plot = plot_escolaridadeMae, width = 20, height = 6, units = "in")
ggsave("plot_ocupacaoMae.png", plot = plot_ocupacaoMae, width = 10, height = 6, units = "in")
ggsave("plot_rendaMensal.png", plot = plot_rendaMensal, width = 10, height = 6, units = "in")
ggsave("plot_ensinoMedio.png", plot = plot_ensinoMedio, width = 10, height = 6, units = "in")
ggsave("plot_remuneracao.png", plot = plot_remuneracao, width = 10, height = 6, units = "in")
