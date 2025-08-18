# Dataset & Model
## dataset:  
identity,alpaca_en_demo  
## Model:  
Qwen2.5-32B-Instruct
## Args
|method|stage|finetuning type|zero stage|cutoff_len|learning rate|epochs|
|---|---|---|---|---|---|---|
|full sft|sft|full|ds_zero3|1024|1e-4|3|
|pt lora|pt|lora|ds_zero3|1024|1e-4|3|

# Clustre Node device
|name|cpu|gpu|mem|Interconnect topology|Inter-node bandwidth|storge|Scheduling|
|---|---|---|---|---|---|---|---|
|32E|Intel(R) Xeon(R) Gold 6230R CPU @ 2.10GHz * 52|A100-PCIE-40G|360G|RoCE|100G|Huawei OceanStor|Slurm|
|NVL|Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz * 64|A100-SXM4-40G|1024G|IB|200G*4|2*3.5T-NVMe-SSD RAID0 in RAID0|Docker on BareMetal|

# Result
|NAME|stage|zero stage|lora|lora rank|lora target|total flos|runtime|simple/s|steps/s|
|---|---|---|---|---|---|---|---|---|---|
|NVL|sft|ds_zero3|OFF|N/A|N/A|3873GF|09:30:58|0.095|0.001|
|NVL|PT|ds_zero3|ON|8|all|4716GF|00:08:55|0.084|0.006|
|32E|PT|ds_zero3|ON|8|all|4716GF|03:08:22|0.004|0.0|
|NVL|sft|ds_zero3|ON|8|all|88716GF|01:25:46|0.635|0.01|
|32E|sft|ds_zero3|ON|8|all|88716GF|00:16:42|3.263|0.054|
