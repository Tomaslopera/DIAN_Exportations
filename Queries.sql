-- 10 EMPRESAS CON MAYOR NÚMERO DE EXPORTACIÓN Y SUS TOTAL EN USD --
SELECT 
    e.razon_social AS empresa,
    COUNT(f.id_exportacion) AS num_exportaciones,
    SUM(f.valor_fob_usd) AS total_exportado_usd
FROM fact_exportaciones f
JOIN dim_empresa e ON f.nit = e.nit
JOIN dim_time t ON f.id_tiempo = t.id_tiempo
WHERE t.mes = EXTRACT(MONTH FROM CURRENT_DATE) - 2
GROUP BY e.razon_social
ORDER BY num_exportaciones DESC
LIMIT 10;


-- VALOR FOB TOTAL DE LAS MERCANCÍAS EXPORTADAS MES A MES --
SELECT 
    t.anio,
    t.mes,
    SUM(f.valor_fob_usd) AS total_valor_fob_usd
FROM fact_exportaciones f
JOIN dim_time t ON f.id_tiempo = t.id_tiempo
GROUP BY t.anio, t.mes
ORDER BY t.anio, t.mes;


-- DESTINOS DONDE MÁS SE EXPORTÓ EN LOS ÚLTIMOS 6 MESES --
SELECT 
    d.pais_destino_final,
    SUM(f.valor_fob_usd) AS total_exportado_usd
FROM fact_exportaciones f
JOIN dim_destino d ON f.id_destino = d.id_destino
JOIN dim_time t ON f.id_tiempo = t.id_tiempo
WHERE t.id_tiempo >= (CURRENT_DATE - INTERVAL '6 months')
GROUP BY d.pais_destino_final
ORDER BY total_exportado_usd DESC
LIMIT 10;


-- TOP 10 VALOR TOTAL DE EXPORTACIÓN POR ADUANAS EN EL ÚLTIMO MES --
SELECT 
    a.aduana_despacho,
    SUM(f.valor_fob_usd) AS total_valor_usd
FROM fact_exportaciones f
JOIN dim_aduanas a ON f.cod_aduana_despacho = a.cod_aduana_despacho
JOIN dim_time tm ON f.id_tiempo = tm.id_tiempo
WHERE tm.mes = EXTRACT(MONTH FROM CURRENT_DATE) - 2
GROUP BY a.aduana_despacho
ORDER BY total_valor_usd DESC
LIMIT 10;


-- EMPRESAS CON EL MAYOR NÚMERO DE EXPORTACIONES --
SELECT 
    e.razon_social,
    COUNT(f.id_exportacion) AS num_exportaciones,
    SUM(f.valor_fob_usd) AS total_valor_usd
FROM fact_exportaciones f
JOIN dim_empresa e ON f.nit = e.nit
GROUP BY e.razon_social
ORDER BY num_exportaciones DESC
LIMIT 10;

-- DISTRIBUCIÓN DE EXPORTACIONES POR MODO DE TRANSPORTE EN EL ÚLTIMO MES --
SELECT 
    t.modo_transporte,
    COUNT(f.id_exportacion) AS num_envios,
    SUM(f.valor_fob_usd) AS total_valor_usd
FROM fact_exportaciones f
JOIN dim_transporte t ON f.cod_modo_transporte = t.cod_modo_transporte
JOIN dim_time tm ON f.id_tiempo = tm.id_tiempo
WHERE tm.mes = EXTRACT(MONTH FROM CURRENT_DATE) - 2
GROUP BY t.modo_transporte
ORDER BY total_valor_usd DESC;
