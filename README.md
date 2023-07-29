# Microdados ENEM

## Descrição:
Este repositório contém um projeto de análise de dados fornecidos pelo INEP sobre os resultados do ENEM 2016 para estudantes de escolas privadas. O objetivo principal é investigar as relações entre as características socioeconômicas dos estudantes e seu desempenho nas provas do ENEM.

## Visão Geral:
Neste projeto, foi utilizado a linguagem de programação R e bibliotecas como ggplot2, data.table e dplyr para realizar a análise exploratória dos dados do ENEM 2016, focando em alunos de escolas privadas. O dataset original foi importado, filtrado para incluir apenas estudantes de escolas privadas e analisar a diferença entre bolsistas e não bolsistas.

## Parâmetros para filtragem 
'A' - Somente em escola pública.
'B' - Parte em escola pública e parte em escola privada sem bolsa de estudo integral.
'C' - Parte em escola pública e parte em escola privada com bolsa de estudo integral.
'D' - Somente em escola privada sem bolsa de estudo integral.
'E' - Somente em escola privada com bolsa de estudo integral.

## Principais Etapas:
- [x] Limpeza do ambiente e configuração das bibliotecas necessárias para a análise.
- [x] Importação dos dados do ENEM 2016 referentes aos alunos de escolas privadas.
- [x] Seleção e renomeação das colunas para uma melhor compreensão dos dados.
- [x] Criação de categorias mais descritivas para os campos referentes à escolaridade dos pais, ocupação dos pais, renda mensal e remuneração do estudante.
- [x] Cálculo da média das notas de cada prova (Ciências da Natureza, Ciências Humanas, Linguagens e Códigos, Matemática e Redação).
- [x] Cálculo da porcentagem de alunos em cada categoria de escolaridade dos pais, ocupação dos pais, renda mensal e remuneração.
- [x] Criação de gráficos de barras para visualizar a distribuição percentual das categorias mencionadas acima.

