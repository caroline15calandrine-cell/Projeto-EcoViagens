<h1 align="center"> Projeto EcoViagens</h1>

<h2 align="center"> Contexto do Projeto</h2><p align="center">

A **EcoViagens** é uma empresa de turismo sustentável fictícia sediada no Brasil que é voltada para a oferta de experiências ecológicas em parceria com operadores locais, promovendo práticas que geram impacto positivo ao meio ambiente e às comunidades. Os dados disponíveis abragem dimensões e métricas, incluindo reservas, informações sobre os operadores e atividades e análises relacionadas com a sustentabilidade.
Nesse sentido, esse projeto visa analisar para avaliar o desempenho da **Ecoviagens** no período de junho de 2024 a junho de 2025. Essa análise fornece informações para ajudar a monitorar o desempenho da plataforma e transformar insights em decisões de negócios da **EcoViagens**. A partir disso, os principais indicadores e métricas são:

#### Principais Indicadores Chave de Desempenho (KPI):
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
![Diagrama](1.%20Modelagem-dados/Diagrama.png)

## 🗄️ Análise em SQL

Neste projeto, a análise em SQL foi realizada com o objetivo de extrair informações relevantes linguagem foi usada para explorar e analisar os dados, responder as perguntas de negócios a partir dos dados.
As análises foram realizadas utilizando o Google BigQuery, por meio de consultas SQL para extração e análise dos dados.

### Exemplo de análise: Receita por período
A consulta abaixo foi utilizada para calcular a receita total ao longo do tempo:





