# 机器
|name|cpu|gpu|mem|连接方式|带宽|
|---|---|---|---|---|---|
|32E|Intel(R) Xeon(R) Gold 6230R CPU @ 2.10GHz * 52|A100-PCIE-40G|360G|RoCE|100G|
|NVL|Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz * 64|A100-SXM4-40G|1024G|IB|200G*4|

# 结果
|NAME|stage|zero stage|lora|lora rank|lora target|total flos|runtime|simple/s|steps/s|
|---|---|---|---|---|---|---|---|---|---|
|32E|PT|ds_zero3|ON|8|all|4716GF|00:08:55|0.084|0.006|
|NVL|PT|ds_zero3|ON|8|all|4716GF|03:08:22|0.004|0.0|
