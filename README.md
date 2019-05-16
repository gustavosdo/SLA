# Objetivo:
O objetivo deste desafio é permitir uma melhor avaliação das suas habilidades como candidato a vaga de Data Scientist. Este desafio deve ser feito individualmente.

# Instruções:
Primeiro, faça um fork deste projeto para sua conta no Github (crie uma se você não possuir). Em seguida, implemente o projeto tal qual descrito abaixo, em seu próprio fork. Por fim, faça Push de todas as suas alterações para o seu fork no Github e envie um pull request para este repositório original.

# Enunciado do Teste

SLA (Service Level Agreement) é uma métrica que indica se um chamado fechado foi atendido dentro do tempo contratado ou não.

A base de dados fornecida representa um conjunto de chamados unitários, abertos e fechados para 10 clientes diferentes (coluna customerCode).

O SLA no instante t é calculado pelo numero de chamados fechados dentro do mês até o instante t (coluna “onTimeSolution=S”) dividido pelo total de chamados do mês até o instante t.

O desafio proposto é gerar um modelo preditivo que possa informar a percentagem de SLA no mês para cada cliente.  
Os dados fornecidos são de 01 de Janeiro de 2019 até 26 de Fevereiro de 2019. O modelo deve então prever qual será o SLA do dia 28 de Fevereiro (final do mês).

  ## Considerações:
  * Para identificar qual  ticket ja foi fechado , usa-se a coluna “callStatus”, onde os status fechados são: N0, N4 e CV.
  * Para identificar quais tickets foram fechados dentro ou fora do SLA , usa-se a coluna “onTimeSolution”(S = foi fechado dentro e N = não foi fechado dentro)

  ## Serão avaliados:
  * Algoritmo utilizado
  * Acuracidade do modelo: métricas utilizadas
  * Organização do código( será avaliado no GIT)
  * Visualizações geradas

  ## Extras (não obrigatório):
  * Outros insights baseados nos dados fornecidos.
  * Exposição do modelo através de API (kubernetes ou IBM Cloud)
