# Azure Static Web Apps

### Configure CORS for Azure Static Web Apps

- [Configure Azure Static Web Apps | Global Headers | Microsoft Learn](https://learn.microsoft.com/en-gb/azure/static-web-apps/configuration#global-headers)

Creating staticwebapp.config.json in the root of the repo and adding the following config worked:

```json
{
  "globalHeaders": {
    "Access-Control-Allow-Origin": "*",
    "Access-Control-Allow-Methods": "GET, OPTIONS"
  }
}
```
