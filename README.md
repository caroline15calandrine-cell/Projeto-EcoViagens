<p align="center">
  <img src="3.%20Relatório/logo.png" width="750"/>
</p>
<h1 align="center"> Projeto EcoViagens: Plataforma de Reservas de Turismo Sustentável</h1>

<h2 align="center"> Contexto do Projeto</h2><p align="center">

A **EcoViagens** é uma empresa de turismo sustentável fictícia sediada no Brasil que é voltada para a oferta de experiências ecológicas em parceria com operadores locais, promovendo práticas que geram impacto positivo ao meio ambiente e às comunidades. Os dados disponíveis abragem dimensões e métricas, incluindo reservas, informações sobre os operadores e atividades e análises relacionadas com a sustentabilidade.

Nesse sentido, esse projeto visa analisar para avaliar o desempenho da **Ecoviagens** no período de junho de 2024 a junho de 2025. Essa análise fornece informações para ajudar a monitorar o desempenho da plataforma e transformar insights em decisões de negócios da **EcoViagens**. A partir disso, os principais indicadores e métricas são:

**Principais Indicadores Chave de Desempenho (KPI):**
- Receita Bruta por Mês: medir o volume de vendas e a adesão dos clientes à plataforma;
- Taxa de Cancelamento: identificar problemas operacionais e insatisfação dos clientes;
- Avaliação média: medir a satisfação e qualidade percebida pelos clientes;
- Média de Práticas Sustentáveis:


<h2 align="center"> Modelagem dos Dados</h2><p align="center">


A modelagem dos dados foi desenvolvida com o objetivo de organizar as informações de forma estruturada com o Diagrama de Entidade e Relacionamento (DER).
O modelo foi construído considerando as todas entidades do negócio, como:
- Ofertas
- Reservas
- Práticas Sustentáveis
- Avaliação

Essa estrutura facilita a análise no SQL e a construção de dashboards no Power BI.
![Diagrama](1.%20Modelagem-dados/diagrama.png)

<h2 align="center"> Análise dos Dados via SQL</h2><p align="center">

Com os dados estruturados no ambiente relacional, foram desenvolvidas consultas SQL analíticas com o objetivo de responder às principais questões de negócio da plataforma EcoViagens.
Entre as análises realizadas, destacam-se:

- Como evolui o volume de reservas ao longo do tempo?  
- Quais períodos apresentam maior concentração de demanda?  
- Como se comporta o desempenho das ofertas e experiências?  
- Existem padrões relevantes no comportamento dos usuários?

As análises foram realizadas utilizando o Google BigQuery por ter alta escalabilidade, e pela velocidade da consulta com grande quantidade de dados.

**Exemplo de análise: Receita por período**<br>
A consulta abaixo foi utilizada para calcular a receita total ao longo do tempo:
```sql
SELECT
  EXTRACT(YEAR FROM data_reserva) AS ano,
  EXTRACT(MONTH FROM data_reserva) AS mes,
  FORMAT_DATE('%b', DATE(data_reserva)) AS mes_abrev,
  COUNT(*) AS qtd_reservas
FROM `ecoviagens-484814.plataforma.reservas`
WHERE UPPER(status) = 'CONCLUÍDA'
GROUP BY 
  ano, mes, mes_abrev
ORDER BY 
  ano ASC, mes ASC;
```

<h2 align="center"> Dashboard de Desempenho da Plataforma</h2><p align="center">

Este projeto conta com um dashboard interativo desenvolvido no Power BI que permite analisar e monitorar o desempenho 

Gráficos:
- Visualização das Receitas e Reservas ao longo tempo
- DIstribuição de Reservas e Tickets Médios por tipo de oferta
- Avaliação do Cliente ao longo do tempo e por tipo de oferta
- Comparação das receitas das Práticas Sustentáveis e a popularidade

Monitoramento:
- Acompanhamento das métricas de desempenho: taxa de fidelização e cancelamento
- Monitoramento das:
  - Reservas concluídas
  - Receita total
  - Ticket médio
  - Avaliação média


