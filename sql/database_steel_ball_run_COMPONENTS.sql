
-- EVENTOS
SET SQL_SAFE_UPDATES = 0;
UPDATE corredores c
SET puntos_totales = (
    SELECT COALESCE(SUM(puntos_obtenidos), 0)
    FROM resultados_etapa r
    WHERE r.id_corredor = c.id_corredor
);
SET SQL_SAFE_UPDATES = 1;

-- TRIGGERS
-- PROCEDURES