# Objective is to Automate logs parsing and provide hints / solution


Example run:

Here is my sample log file "log.txt"

```
bash-5.1$ cat log.txt
W0131 03:50:06.928565 10875 docdb_compaction_filter_intents.cc:121] T b8158efe5ad643d89312d741106efa46: Number of aborted transactions not cleaned up on account of reaching size limits:43710
W0131 03:52:09.206904 10875 docdb_compaction_filter_intents.cc:121] T 9d91ac13298240f596a68a6a48ce4ff5: Number of aborted transactions not cleaned up on account of reaching size limits:43339
bash-5.1$
```

Below script parse the log.txt, found a message and print a hint  
```
bash-5.1$ ./logs_analyzer.sh log.txt

============================================================================
We found following message in the logs
Number of aborted transactions not cleaned up on account of reaching size limits

This typically means that we need to run compaction on offending tablets

Check this case for more details
https://yugabyte.zendesk.com/agent/tickets/5416
============================================================================

bash-5.1$
```
