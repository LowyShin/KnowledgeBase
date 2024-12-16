## Bash Shell

Delete file over 30days
```bash
find /path/to/directory -type f -mtime +30 -not -exec bash -c '[ "$(date -r "$1" +%u)" -eq 7 ]' _ {} \; -exec echo "Would delete: {}" +
```

## Bash for CentOS

https://github.com/LowyShin/KnowledgeBase/blob/master/dic/c/CentOS/README.md
