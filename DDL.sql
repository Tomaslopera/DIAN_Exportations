
-- DIMENSIÓN TIEMPO --

CREATE TABLE dim_time (
    id_tiempo DATE PRIMARY KEY,
    anio INTEGER,
    mes INTEGER,
    dia INTEGER
);

SELECT * FROM dim_time

-- DIMENSIÓN EMPRESA --

CREATE TABLE dim_empresa (
    nit VARCHAR(15) PRIMARY KEY,
    tipo_usuario INTEGER,
    cod_usuario INTEGER,
    clase INTEGER,
    cod_departamento INTEGER,
    razon_social VARCHAR(512),
    direccion VARCHAR(512)
);

SELECT * FROM dim_empresa

-- DIMENSIÓN TRANSPORTE --

CREATE TABLE dim_transporte (
    cod_modo_transporte INTEGER PRIMARY KEY,
    modo_transporte VARCHAR(100)
);

SELECT * FROM dim_transporte

-- DIMENSIÓN ADUANAS --

CREATE TABLE dim_aduanas (
    cod_aduana_despacho INTEGER PRIMARY KEY,
    aduana_despacho VARCHAR(150)
);

SELECT * FROM dim_aduanas

-- DIMENSIÓN DESTINO --

CREATE TABLE dim_destino (
    id_destino VARCHAR(48) PRIMARY KEY,
    cod_pais_destino VARCHAR(10),
    pais_destino_final VARCHAR(255),
    ciudad_destinatario VARCHAR(100),
    latitud FLOAT,
    longitud FLOAT
);

SELECT * FROM dim_destino 

-- DIMENSIÓN MODALIDAD --

CREATE TABLE dim_modalidad (
    cod_modalidad_exportacion INTEGER PRIMARY KEY,
    modalidad_exportacion VARCHAR(512)
);

SELECT * FROM dim_modalidad 

-- TABLA DE HECHOS --

CREATE TABLE fact_exportaciones (
    id_exportacion VARCHAR(50) PRIMARY KEY,
    nit VARCHAR(15),
    cod_aduana_despacho INTEGER,
    cod_modo_transporte INTEGER,
    cod_modalidad_exportacion INTEGER,
    id_destino VARCHAR(48),
    id_tiempo DATE,

    unidad_fisica VARCHAR(50),
    cantidad_unidades_fisicas FLOAT,
    peso_bruto_kgs FLOAT,
    peso_neto_kgs FLOAT,
    valor_fob_usd FLOAT,
    valor_fob_pesos FLOAT,
    vlr_serie_agregado_nal_usd FLOAT,
    valor_serie_fletes_usd FLOAT,
    valor_serie_seguros_usd FLOAT,
    valor_serie_otros_gastos_usd FLOAT,
    moneda_transaccion VARCHAR(10),

    FOREIGN KEY (id_tiempo) REFERENCES dim_time (id_tiempo),
    FOREIGN KEY (nit) REFERENCES dim_empresa (nit),
    FOREIGN KEY (cod_aduana_despacho) REFERENCES dim_aduanas (cod_aduana_despacho),
    FOREIGN KEY (cod_modo_transporte) REFERENCES dim_transporte (cod_modo_transporte),
    FOREIGN KEY (cod_modalidad_exportacion) REFERENCES dim_modalidad (cod_modalidad_exportacion),
    FOREIGN KEY (id_destino) REFERENCES dim_destino (id_destino)
);

SELECT * FROM fact_exportaciones 

