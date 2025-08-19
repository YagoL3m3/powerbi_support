-- public.v_bi_disp_prod fonte

CREATE OR REPLACE VIEW public.v_bi_disp_prod
AS SELECT x.cd_prod,
    x.nom_prod,
    x.data_adm,
    x.data_dem,
    data_series.data,
    x.jornada_semana,
    x.jornada_sabado,
    COALESCE(((pnt.opnt_jornfin_1 - pnt.opnt_jornini_1 - (pnt.opnt_almofin_1 - pnt.opnt_almoini_1)) / 100)::numeric - pnt.opnt_hortrei_1 - pnt.opnt_feriass_1 - pnt.opnt_auserem_1 - pnt.opnt_ausnrem_1, 0::numeric) AS jornada_excessao,
        CASE
            WHEN (((pnt.opnt_jornfin_1 - pnt.opnt_jornini_1 - (pnt.opnt_almofin_1 - pnt.opnt_almoini_1)) / 100)::numeric - pnt.opnt_hortrei_1 - pnt.opnt_feriass_1 - pnt.opnt_auserem_1 - pnt.opnt_ausnrem_1) IS NULL THEN
            CASE
                WHEN to_char(data_series.data, 'd'::text) = '7'::text THEN x.jornada_sabado
                ELSE x.jornada_semana
            END::numeric
            ELSE ((pnt.opnt_jornfin_1 - pnt.opnt_jornini_1 - (pnt.opnt_almofin_1 - pnt.opnt_almoini_1)) / 100)::numeric - pnt.opnt_hortrei_1 - pnt.opnt_feriass_1 - pnt.opnt_auserem_1 - pnt.opnt_ausnrem_1
        END AS disp
   FROM ( SELECT a.opro_produti_1 AS cd_prod,
            a.opro_nomepro_1 AS nom_prod,
            a.opro_datadmi_1 AS data_adm,
                CASE
                    WHEN a.opro_datafas_1 = '1899-12-30'::date THEN (date_trunc('month'::text, CURRENT_DATE::timestamp with time zone) + '1 mon -1 days'::interval)::date
                    ELSE a.opro_datafas_1
                END AS data_dem,
            (a.opro_jornsmf_1 - a.opro_jornsmi_1 - (a.opro_almosmf_1 - a.opro_almosmi_1)) / 100 AS jornada_semana,
            (a.opro_jornsbf_1 - a.opro_jornsbi_1 - (a.opro_almosbf_1 - a.opro_almosbi_1)) / 100 AS jornada_sabado
           FROM apopro a) x
     JOIN LATERAL generate_series(x.data_adm::timestamp with time zone, x.data_dem::timestamp with time zone, '1 day'::interval) data_series(data) ON true
     LEFT JOIN apopnt pnt ON pnt.opnt_produti_1 = x.cd_prod::numeric AND pnt.opnt_datinve_1 = data_series.data::date
  WHERE to_char(data_series.data, 'd'::text) <> '1'::text;