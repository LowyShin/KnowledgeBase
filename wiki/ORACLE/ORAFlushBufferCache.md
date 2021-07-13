on Linux

* memory cache clear
  * https://www.shift-the-oracle.com/linux/utility/flush-buffer-cache.html
```sh
echo 1 > /proc/sys/vm/drop_caches
echo 2 > /proc/sys/vm/drop_caches
echo 3 > /proc/sys/vm/drop_caches
```
This command is may harm to your process on running. Be careful to use. 
