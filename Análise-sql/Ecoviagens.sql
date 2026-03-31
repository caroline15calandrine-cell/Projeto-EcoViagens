/* =====================================================
PROJETO: EcoViagens
Descrição: Análise de dados da plataforma de turismo sustentável
===================================================== */

/* =====================================================
BLOCO 1: RESERVAS
Objetivo: Analisar volume e comportamento das reservas
===================================================== */

-- Qual o volume total de reservas concluídas?
SELECT
  COUNT(id_reserva) AS total_reservas  
FROM `ecoviagens-484814.plataforma.reservas` 
WHERE UPPER(status) = 'CONCLUÍDA';


-- Como as reservas evoluem ao longo do tempo?
SELECT
  EXTRACT(YEAR FROM data_reserva) AS ano,
  EXTRACT(MONTH FROM data_reserva) AS mes,
  COUNT(id_reserva) AS qtd_reservas
FROM `ecoviagens-484814.plataforma.reservas` 
WHERE UPPER(status) = 'CONCLUÍDA'
GROUP BY 
  ano, mes
ORDER BY 
  ano, mes;


/* =====================================================
BLOCO 2: SUSTENTABILIDADE
Objetivo: Avaliar impacto das práticas sustentáveis
===================================================== */

-- Qual o volume de reservas por prática sustentável?
SELECT 
  ps.nome,
  COUNT(DISTINCT r.id_reserva) as qtd_reservas
FROM `ecoviagens-484814.plataforma.praticas_sustentaveis` ps 
LEFT JOIN `ecoviagens-484814.plataforma.oferta_pratica` op 
  ON ps.id_pratica = op.id_pratica
LEFT JOIN `ecoviagens-484814.plataforma.ofertas` o 
  ON o.id_oferta = op.id_oferta
LEFT JOIN `ecoviagens-484814.plataforma.reservas` r 
  ON r.id_oferta = o.id_oferta
WHERE UPPER(r.status) = "CONCLUÍDA"
GROUP BY ps.nome;


-- Qual o impacto das práticas sustentáveis nas reservas?
SELECT 
  CASE 
    WHEN op.id_pratica IS NOT NULL THEN 'Com Prática Sustentável'
    ELSE 'Sem Prática Sustentável'
  END AS tipo_reserva,
  COUNT(DISTINCT r.id_reserva) as qtd_reservas
FROM `ecoviagens-484814.plataforma.reservas` r 
LEFT JOIN `ecoviagens-484814.plataforma.oferta_pratica` op 
  ON op.id_oferta = r.id_oferta
WHERE UPPER(r.status) = "CONCLUÍDA"
GROUP BY tipo_reserva;


/* =====================================================
BLOCO 3: RECEITA
Objetivo: Analisar faturamento da plataforma
===================================================== */

-- Como a receita evolui ao longo do tempo?
SELECT
  EXTRACT(YEAR FROM data_reserva) AS ano,
  EXTRACT(MONTH FROM data_reserva) AS mes,
  ROUND(SUM(qtd_pessoas * preco),2) AS receita
FROM `ecoviagens-484814.plataforma.reservas` r 
JOIN `ecoviagens-484814.plataforma.ofertas` o 
  ON o.id_oferta = r.id_oferta
WHERE UPPER(r.status) = "CONCLUÍDA"
GROUP BY 
  ano, mes
ORDER BY 
  ano, mes;


-- Qual a receita total da plataforma?
SELECT
  ROUND(SUM(qtd_pessoas * preco),2) AS receita_total
FROM `ecoviagens-484814.plataforma.reservas` r 
JOIN `ecoviagens-484814.plataforma.ofertas` o 
  ON o.id_oferta = r.id_oferta
WHERE UPPER(r.status) = "CONCLUÍDA";


/* =====================================================
BLOCO 4: AVALIAÇÕES
Objetivo: Medir satisfação dos clientes
===================================================== */

-- Qual o nível médio de satisfação dos clientes?
SELECT
  ROUND(AVG(nota),2) AS media_avaliacoes
FROM `ecoviagens-484814.plataforma.avaliacoes`;


-- Como as avaliações evoluem ao longo do tempo?
SELECT 
  EXTRACT(YEAR FROM data_avaliacao) as ano,
  EXTRACT(MONTH FROM data_avaliacao) as mes,
  ROUND(AVG(nota),2) AS media_avaliacao
FROM `ecoviagens-484814.plataforma.avaliacoes`
GROUP BY 
  ano, mes
ORDER BY
  ano, mes;


-- Qual a avaliação média por tipo de oferta?
SELECT 
  o.tipo_oferta,
  ROUND(AVG(a.nota),2) as media_avaliacao
FROM `ecoviagens-484814.plataforma.avaliacoes` a 
JOIN `ecoviagens-484814.plataforma.ofertas` o 
  ON o.id_oferta = a.id_oferta
GROUP BY o.tipo_oferta;


/* =====================================================
BLOCO 5: OFERTAS
Objetivo: Analisar demanda por tipo de oferta
===================================================== */

-- Quais tipos de oferta possuem maior demanda?
SELECT
  o.tipo_oferta,
  COUNT(r.id_reserva) AS qtd_reservas
FROM `ecoviagens-484814.plataforma.reservas` r 
LEFT JOIN `ecoviagens-484814.plataforma.ofertas` o 
  ON o.id_oferta = r.id_oferta
WHERE UPPER(r.status) = "CONCLUÍDA"
GROUP BY o.tipo_oferta;


/* =====================================================
BLOCO 6: PRÁTICAS SUSTENTÁVEIS
Objetivo: Identificar práticas mais relevantes
===================================================== */

-- Quais são as práticas sustentáveis mais utilizadas?
SELECT 
  ps.nome,
  COUNT(ps.id_pratica) AS qtd_praticas
FROM `ecoviagens-484814.plataforma.praticas_sustentaveis` ps 
JOIN `ecoviagens-484814.plataforma.oferta_pratica` op 
  ON ps.id_pratica = op.id_pratica
JOIN `ecoviagens-484814.plataforma.ofertas` o 
  ON o.id_oferta = op.id_oferta
JOIN `ecoviagens-484814.plataforma.reservas` r 
  ON r.id_oferta = o.id_oferta
WHERE UPPER(r.status) = "CONCLUÍDA"
GROUP BY ps.nome
ORDER BY qtd_praticas DESC
LIMIT 5;


-- Quais práticas sustentáveis possuem melhor avaliação?
SELECT
  ps.nome,
  ROUND(AVG(a.nota),2) AS avaliacao_pratica
FROM `ecoviagens-484814.plataforma.avaliacoes` a 
JOIN `ecoviagens-484814.plataforma.ofertas` o 
  ON o.id_oferta = a.id_oferta
JOIN `ecoviagens-484814.plataforma.oferta_pratica` op 
  ON op.id_oferta = o.id_oferta 
JOIN `ecoviagens-484814.plataforma.praticas_sustentaveis` ps 
  ON ps.id_pratica = op.id_pratica
GROUP BY ps.nome
ORDER BY avaliacao_pratica DESC
LIMIT 5;


/* =====================================================
BLOCO 7: INDICADORES
Objetivo: Métricas estratégicas do negócio
===================================================== */

-- Qual a taxa de fidelização dos clientes?
WITH total_clientes AS (
  SELECT 
    COUNT(DISTINCT id_cliente) AS total
  FROM `ecoviagens-484814.plataforma.reservas`
  WHERE UPPER(status) = "CONCLUÍDA"
),

clientes_fieis AS (
  SELECT
    id_cliente
  FROM `ecoviagens-484814.plataforma.reservas`
  WHERE UPPER(status) = "CONCLUÍDA"
  GROUP BY id_cliente
  HAVING COUNT(id_reserva) > 1
)

SELECT 
  ROUND(COUNT(*) / CAST(MAX(total) AS FLOAT64) * 100, 2) AS taxa_fidelizacao
FROM clientes_fieis
CROSS JOIN total_clientes;

-- Qual a taxa de cancelamento?
WITH canceladas AS (
  SELECT 
    COUNT(*) AS reservas_canceladas
  FROM `ecoviagens-484814.plataforma.reservas`
  WHERE UPPER(status) = "CANCELADA"
),
totais AS (
  SELECT
    COUNT(*) AS reservas_totais
  FROM `ecoviagens-484814.plataforma.reservas`
)

SELECT 
  ROUND(reservas_canceladas / reservas_totais * 100,2) AS taxa_cancelamento
FROM canceladas
CROSS JOIN totais;
