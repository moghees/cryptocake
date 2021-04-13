WITH DECISION AS (select S._t_ AS TT, S.v as SOPR, V._t_ AS VolumeDate, V.v as Volume, P.t as PriceTime, P.o_c as close, P.o_o as open, P.o_h as high, P.o_l as low,
if (p.o_c - p.o_o > 0, 'BUY', 'SELL') as MOVE
FROM `crypto-ml-303521.BTC_SOPR.SOPR` S
RIGHT OUTER JOIN `crypto-ml-303521.bitcoinprice.bitcoinprice_hourly` P ON EXTRACT (DATE FROM P.t) = extract (date from S._t_)
RIGHT OUTER JOIN `crypto-ml-303521.bitcoinprice.bitcoinvolumedaily` V ON EXTRACT (DATE FROM V._t_) = extract (date from S._t_)
--RIGHT OUTER JOIN `crypto-ml-303521.bitcoinprice.bitcoinprice_hourly` P ON S._t_ = p.t
WHERE S.v IS NOT NULL
AND P.t IS NOT NULL
AND P.o_o IS NOT NULL
AND P.o_c IS NOT NULL
AND P.o_h  IS NOT NULL
AND P.o_l IS NOT NULL
) SELECT
--P2.t,
P2.o_o as Open_Price_D_T,
DECISION.sopr as SOPR_D_T_1,
--DECISION.VolumeDate,
DECISION.Volume as Volume_D_T_1,
--DECISION.PriceTime,
DECISION.open AS Open_Price_H_T_1,
DECISION.close AS Close_Price_H_T_1,
DECISION.high AS High_Price_H_T_1,
DECISION.low AS Low_Price_H_T_1,
DECISION.MOVE AS Move
FROM DECISION
RIGHT OUTER JOIN `crypto-ml-303521.bitcoinprice.bitcoinprice_hourly` P2 ON
                    EXTRACT (DATEtime FROM P2.t) = DATETIME_add (extract (datetime from DECISION.TT), INTERVAL 24 HOUR)
RIGHT OUTER JOIN `crypto-ml-303521.bitcoinprice.bitcoinvolumedaily` V2 on
                    EXTRACT (DATE FROM V2._t_) = DATE_add (extract (date from DECISION.TT), INTERVAL 1 DAY)
WHERE
P2.t IS NOT NULL and
P2.o_o IS NOT NULL and
DECISION.sopr IS NOT NULL and
DECISION.VolumeDate IS NOT NULL and
DECISION.Volume IS NOT NULL and
DECISION.PriceTime IS NOT NULL and
DECISION.open IS NOT NULL and
DECISION.close IS NOT NULL and
DECISION.high IS NOT NULL and
DECISION.low IS NOT NULL and
DECISION.MOVE IS NOT NULL
