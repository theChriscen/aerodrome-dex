WITH total_trading_volume AS (
    SELECT
        date_trunc('{{timeframe}}', block_time) AS time,
        SUM(amount_usd) AS total_amount
    FROM dex.trades dt
    WHERE blockchain = 'base'
        AND (token_bought_address = 0x940181a94a35a4569e4529a3cdfb74e38fd98631
        OR token_sold_address = 0x940181a94a35a4569e4529a3cdfb74e38fd98631)
    GROUP BY 1
)

    SELECT
        *,
        SUM(total_amount) OVER(ORDER BY time ASC) AS cummulative_volume
    FROM total_trading_volume
    ORDER BY time DESC
