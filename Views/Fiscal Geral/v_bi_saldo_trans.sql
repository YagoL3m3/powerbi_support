-- public.v_bi_saldo_trans fonte

CREATE OR REPLACE VIEW public.v_bi_saldo_trans
AS SELECT 1 AS empresa,
    escsc001.cscr_tiporeg_1,
    escsc001.cscr_anorefe_1,
    escsc001.cscr_mesrefe_1,
    escsc001.cscr_saldcr1_1,
    escsc001.cscr_saldcr2_1,
    escsc001.cscr_saldcr3_1
   FROM escsc001
UNION ALL
 SELECT 2 AS empresa,
    escsc002.cscr_tiporeg_1,
    escsc002.cscr_anorefe_1,
    escsc002.cscr_mesrefe_1,
    escsc002.cscr_saldcr1_1,
    escsc002.cscr_saldcr2_1,
    escsc002.cscr_saldcr3_1
   FROM escsc002
UNION ALL
 SELECT 3 AS empresa,
    escsc003.cscr_tiporeg_1,
    escsc003.cscr_anorefe_1,
    escsc003.cscr_mesrefe_1,
    escsc003.cscr_saldcr1_1,
    escsc003.cscr_saldcr2_1,
    escsc003.cscr_saldcr3_1
   FROM escsc003
UNION ALL
 SELECT 4 AS empresa,
    escsc004.cscr_tiporeg_1,
    escsc004.cscr_anorefe_1,
    escsc004.cscr_mesrefe_1,
    escsc004.cscr_saldcr1_1,
    escsc004.cscr_saldcr2_1,
    escsc004.cscr_saldcr3_1
   FROM escsc004
UNION ALL
 SELECT 51 AS empresa,
    escsc051.cscr_tiporeg_1,
    escsc051.cscr_anorefe_1,
    escsc051.cscr_mesrefe_1,
    escsc051.cscr_saldcr1_1,
    escsc051.cscr_saldcr2_1,
    escsc051.cscr_saldcr3_1
   FROM escsc051
UNION ALL
 SELECT 100 AS empresa,
    escsc100.cscr_tiporeg_1,
    escsc100.cscr_anorefe_1,
    escsc100.cscr_mesrefe_1,
    escsc100.cscr_saldcr1_1,
    escsc100.cscr_saldcr2_1,
    escsc100.cscr_saldcr3_1
   FROM escsc100;