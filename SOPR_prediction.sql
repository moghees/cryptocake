SELECT
  *
FROM
  ML.PREDICT(MODEL `crypto-ml-303521.BTC_SOPR.sopr_volume_model`,
    (
    SELECT
      V.Move,
      V.Close_Price_H_T_1,
      V.High_Price_H_T_1,
      V.Low_Price_H_T_1,
      V.Open_Price_D_T,
      V.Open_Price_H_T_1,
      V.SOPR_D_T_1,
      V.Volume_D_T_1
    FROM
      `crypto-ml-303521.BTC_SOPR.input_view` V ))
