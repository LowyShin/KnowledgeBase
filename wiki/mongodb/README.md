## Tuning

* Limitance
  * Sort Operations : 32MB / order
    * https://docs.mongodb.com/manual/reference/limits/#Shard-Key-Size
  * Aggregation pipeline memory : 100MB
    * https://docs.mongodb.com/manual/reference/limits/#Sort-Operations
  * Members of a Replica Set : 50 members
    * https://docs.mongodb.com/manual/reference/limits/#Number-of-Members-of-a-Replica-Set
  * Voting Members of a Replica Set : 7 members
    * https://docs.mongodb.com/manual/reference/limits/#Number-of-Voting-Members-of-a-Replica-Set
  * Auto-Created Oplog : 50GB
    * https://docs.mongodb.com/manual/reference/limits/#Number-of-Voting-Members-of-a-Replica-Set
  * Sharding Existing Collection Data Size : see link table of below
    * https://docs.mongodb.com/manual/reference/limits/#Sharding-Existing-Collection-Data-Size
  * Maximum Number of Documents in a Capped Collection : 2^32 documents
    * https://docs.mongodb.com/manual/reference/limits/#Maximum-Number-of-Documents-in-a-Capped-Collection
  * The maximum BSON document size is 16 megabytes.
    * https://docs.mongodb.com/manual/reference/limits/#BSON-Document-Size
  * No more than 100 levels of nesting for BSON documents.
    * https://docs.mongodb.com/manual/reference/limits/#Nested-Depth-for-BSON-Documents
  * Shard Key Size : 512bytes
    * https://docs.mongodb.com/manual/reference/limits/#Shard-Key-Size
  * Number of Indexed Fields in a Compound Index : 32 fields
    * https://docs.mongodb.com/manual/reference/limits/#Number-of-Indexed-Fields-in-a-Compound-Index
  * Index Key Limit : 1024 bytes
    * https://docs.mongodb.com/manual/reference/limits/#Index-Key-Limit
  * Index per collection : 64 indexes.
    * https://docs.mongodb.com/manual/reference/limits/#Number-of-Indexes-per-Collection
  * Write Command Batch Limit Size = 100,000 writes (V3.6)
    * https://docs.mongodb.com/manual/reference/limits/#Write-Command-Batch-Limit-Size
  * Session idle timeout : 30 Min
    * https://docs.mongodb.com/manual/reference/limits/#Session-Idle-Timeout
  * The maximum length of the collection namespace, which includes the database name, the dot (.) separator, and the collection name (i.e. <database>.<collection>), is 120 bytes.
    * https://docs.mongodb.com/manual/reference/limits/#Namespace-Length
  * 4095 code point each line by Cli
    * https://docs.mongodb.com/manual/reference/limits/#shell


* Recommend Memory
  * 50% of (RAM - 1 GB), or 256 MB.
  * https://docs.mongodb.com/manual/administration/production-notes/#prod-notes-ram

* RAID
  * For optimal performance in terms of the storage layer, use disks backed by RAID-10. RAID-5 and RAID-6 do not typically provide sufficient performance to support a MongoDB deployment.
  * https://docs.mongodb.com/manual/administration/production-notes/#raid

* Using WiredTiger Storage Engine(V3 ~)
  * Reduced lock range (DB Lock -> Row Lock)
  * Can limit cachesizeGB. (MMAP is fully used memory until dead process)
  * Auto defragment physical data(Auto compaction fragment block)
  * Separate index and data store.
  * Ref(ja) - https://qiita.com/oshou/items/03f8dfcedbd63e2a8353

* OS Configuration
  * Set THP(Transparent Huge Page) OFF

* Tips
  * know-how by experience(ja) : https://www.infoq.com/jp/articles/Starting-With-MongoDB/

* performance check
  * https://www.slideshare.net/tetsutarowatanabe/mongodb-70155001

## Sharding(Replica set)

* Official best practice
  * https://www.mongodb.com/blog/post/mongodb-atlas-best-practices-part-3

## Benchmark

* Mongodb insert performance test
  * best performance at 100 / 100 (session / goroutine) on AWS t2.2xlarge
    * https://qiita.com/toast-uz/items/0aad7cb5281b28fd2947

## Links

* Auto generate mongo-QL aggregate editor : https://studio3t.com/
