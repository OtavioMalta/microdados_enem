# Microdados ENEM

## Descrição:
Este repositório contém um projeto de análise de dados fornecidos pelo INEP sobre os resultados do ENEM 2016 para estudantes de escolas privadas. O objetivo principal é investigar as relações entre as características socioeconômicas dos estudantes bolsistas e não bolsitas e seu desempenho nas provas do ENEM 2016.

## Visão Geral:
Neste projeto, foi utilizado a linguagem de programação R e bibliotecas como ggplot2, data.table e dplyr para realizar a análise exploratória dos dados do ENEM 2016, focando em alunos de escolas privadas. O dataset original foi importado, filtrado para incluir apenas estudantes de escolas privadas e analisar a diferença entre bolsistas e não bolsistas.

## Requisitos
Para a execução deste projeto, é necessário o download dos <a href="https://www.gov.br/inep/pt-br/acesso-a-informacao/dados-abertos/microdados/enem" target="_blank">microdados do ENEM</a> 2016 no site oficial do Governo Federal.
É necessário também a instalação do <a href="https://posit.co/download/rstudio-desktop/" target="_blank">R</a> e das bibliotecas ggplot2, data.table e dplyr.

## Parâmetros para filtragem 
'A' - Somente em escola pública. <br>
'B' - Parte em escola pública e parte em escola privada sem bolsa de estudo integral. <br>
'C' - Parte em escola pública e parte em escola privada com bolsa de estudo integral. <br>
'D' - Somente em escola privada sem bolsa de estudo integral. <br>
'E' - Somente em escola privada com bolsa de estudo integral.

## Principais Etapas:
- [x] Limpeza do ambiente e configuração das bibliotecas necessárias para a análise.
- [x] Importação dos dados do ENEM 2016 referentes aos alunos de escolas privadas.
- [x] Seleção e renomeação das colunas para uma melhor compreensão dos dados.
- [x] Criação de categorias mais descritivas para os campos referentes à escolaridade dos pais, ocupação dos pais, renda mensal e remuneração do estudante.
- [x] Cálculo da média das notas de cada prova (Ciências da Natureza, Ciências Humanas, Linguagens e Códigos, Matemática e Redação).
- [x] Cálculo da porcentagem de alunos em cada categoria de escolaridade dos pais, ocupação dos pais, renda mensal e remuneração.
- [x] Criação de gráficos de barras para visualizar a distribuição percentual das categorias mencionadas acima.

