[&lt; EON API Documentation](/doc/api/index.md) 
### merics

Returns metrics about this node in Prometheus format.

**Parameters**

No parameters

**Example request**

     curl -sX POST 'http://127.0.0.1:9085/metrics' -H 'Content-Type: application/json' -H 'accept: application/json' 

**Response**

 The metrics will be exposed one line per metric, in this format:

```
metric_id value
```

Available metrics:

Following  metrics will be available (also listed in the endpoint /metrics/help):

- **block_apply_time**<br>
Time to apply block to node wallet and state (milliseconds)
- **block_apply_time_fromslotstart**<br>
Delta between timestamp when block has been applied successfully on this node and start timestamp of the slot it belongs to (milliseconds)
- **block_applied_ok**<br>
Number of received blocks applied successfully (absolute value since start of the node)
- **block_applied_ko**<br>
Number of received blocks not applied (absolute value since start of the node)
- **mempool_size**<br>
Mempool size (number of transactions in this node mempool)
- **forge_block_count**<br>
Number of forged blocks by this node (absolute value since start of the node)
- **forge_lottery_time**<br>
Time to execute the lottery (milliseconds)
- **forge_blockcreation_time**<br>
Time to create a new forged block (calculated from the start timestamp of the slot it belongs to) (milliseconds)





