# Useful Azure Query

- dependencies summary by result code, date

dependencies
| summarize Occurance=count() by format_datetime(timestamp,'yyyy-MM-dd'), resultCode
| order by timestamp desc
