# 机器
|name|cpu|gpu|mem|ib|
|---|---|---|---|---|
|32E|Intel(R) Xeon(R) Gold 6230R CPU @ 2.10GHz * 52|A100-PCIE-40G|360G||
|NVL|Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz * 64|A100-SXM4-540G|1024G||

# 结果
|NAME|stage|zero stage|lora|lora rank|lora target|total flos|runtime|simple/s|steps/s|
|---|---|---|---|---|---|---|---|---|---|
|32E|PT|ds_zero3|ON|8|all|4716GF|00:08:55|0.084|0.006|
|NVL|PT|ds_zero3|ON|8|all|4716GF|03:08:22|0.004|0.0|
