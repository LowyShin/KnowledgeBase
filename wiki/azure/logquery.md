# Useful Azure Query

- get Resource
```
resources
| where (resourceGroup =~ ('giip-rg'))
```

- dependencies summary by result code, date

```az
dependencies
| summarize Occurance=count() by format_datetime(timestamp,'yyyy-MM-dd'), resultCode
| order by timestamp desc
```

- time/data
```
dependencies 
| summarize Occurance=count() by format_datetime(timestamp,'yyyy-MM-dd'), substring(data, 0, 97), resultCode 
| where resultCode contains "404" 
| order by timestamp desc
```

- Azure Metrics 

```az
AzureMetrics
| project TimeGenerated, Resource, MetricName, Maximum, ResourceProvider
| where ResourceProvider contains "SQLDB"
| where TimeGenerated between(datetime("2022-11-19 04:30:00") .. datetime("2022-11-19 06:00:00")) 
```

- Performance Monitor

```az
Perf
| project TimeGenerated, Computer, ObjectName, CounterName, CounterValue
| where ObjectName contains "Process"
| where TimeGenerated between(datetime("2022-11-19 04:30:00") .. datetime("2022-11-19 06:00:00")) 
```

## Ref

- [Optimize log queries in Azure Monitor](https://learn.microsoft.com/en-us/azure/azure-monitor/logs/query-optimization#use-effective-aggregation-commands-and-dimensions-in-summarize-and-join)

