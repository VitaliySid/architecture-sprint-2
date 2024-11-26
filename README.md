## Задание 1. Планирование
[Ссылка на схему](/diagram/architecture-sprint-2-task-1.drawio)

<details>
<summary>Шардирование:</summary>

![](/diagram/architecture-sprint-2-task-1-Шардирование%20.svg)

</details>

<details>
<summary>Репликация:</summary>

![](/diagram/architecture-sprint-2-task-1-Репликация%20.svg)

</details>

<details>
<summary>Кэширование:</summary>

![](/diagram/architecture-sprint-2-task-1-Кэширование.svg)

</details>

<details>
<summary>Задание 5. Service Discovery и балансировка с API Gateway:</summary>

![](/diagram/architecture-sprint-2-task-1-Service%20Discovery%20и%20балансировка%20с%20API%20Gateway.svg)

</details>

<details>
<summary>Задание 6. CDN:</summary>

![](/diagram/architecture-sprint-2-task-1-CDN.svg)

</details>

## Задание 2. Шардирование

![](/mongo-sharding/pic/swagger-root.png)

<details>
<summary>Листинг команд:</summary>

``` sh
qwuen@MSI:/mnt/d/projects/architecture-sprint-2/mongo-sharding$ docker-compose -f compose.yaml up -d
[+] Running 9/9
 ⠿ Network mongo-sharding_app-network   Created                                                                    0.0s
 ⠿ Volume "mongo-sharding_shard1-data"  Created                                                                    0.0s
 ⠿ Volume "mongo-sharding_shard2-data"  Created                                                                    0.0s
 ⠿ Volume "mongo-sharding_config-data"  Created                                                                    0.0s
 ⠿ Container shard1                     Started                                                                    1.7s
 ⠿ Container shard2                     Started                                                                    1.5s
 ⠿ Container configSrv                  Started                                                                    1.2s
 ⠿ Container mongos_router              Started                                                                    1.3s
 ⠿ Container pymongo_api                Started

 qwuen@MSI:/mnt/d/projects/architecture-sprint-2/mongo-sharding$ ./scripts/mongo-init.sh
test> ... ... ... ... ... ... ... ... {
  ok: 1,
  '$clusterTime': {
    clusterTime: Timestamp({ t: 1732558253, i: 1 }),
    signature: {
      hash: Binary.createFromBase64('AAAAAAAAAAAAAAAAAAAAAAAAAAA=', 0),
      keyId: Long('0')
    }
  },
  operationTime: Timestamp({ t: 1732558253, i: 1 })
}
config_server [direct: secondary] test> test> ... ... ... ... ... ... ... {
  ok: 1,
  '$clusterTime': {
    clusterTime: Timestamp({ t: 1732558254, i: 1 }),
    signature: {
      hash: Binary.createFromBase64('AAAAAAAAAAAAAAAAAAAAAAAAAAA=', 0),
      keyId: Long('0')
    }
  },
  operationTime: Timestamp({ t: 1732558254, i: 1 })
}
shard1 [direct: secondary] test> test> ... ... ... ... ... ... ... {
  ok: 1,
  '$clusterTime': {
    clusterTime: Timestamp({ t: 1732558255, i: 1 }),
    signature: {
      hash: Binary.createFromBase64('AAAAAAAAAAAAAAAAAAAAAAAAAAA=', 0),
      keyId: Long('0')
    }
  },
  operationTime: Timestamp({ t: 1732558255, i: 1 })
}
shard2 [direct: secondary] test> [direct: mongos] test>
[direct: mongos] test> {
  shardAdded: 'shard1',
  ok: 1,
  '$clusterTime': {
    clusterTime: Timestamp({ t: 1732558256, i: 21 }),
    signature: {
      hash: Binary.createFromBase64('AAAAAAAAAAAAAAAAAAAAAAAAAAA=', 0),
      keyId: Long('0')
    }
  },
  operationTime: Timestamp({ t: 1732558256, i: 21 })
}
[direct: mongos] test> {
  shardAdded: 'shard2',
  ok: 1,
  '$clusterTime': {
    clusterTime: Timestamp({ t: 1732558256, i: 44 }),
    signature: {
      hash: Binary.createFromBase64('AAAAAAAAAAAAAAAAAAAAAAAAAAA=', 0),
      keyId: Long('0')
    }
  },
  operationTime: Timestamp({ t: 1732558256, i: 38 })
}
[direct: mongos] test>
[direct: mongos] test> {
  ok: 1,
  '$clusterTime': {
    clusterTime: Timestamp({ t: 1732558257, i: 4 }),
    signature: {
      hash: Binary.createFromBase64('AAAAAAAAAAAAAAAAAAAAAAAAAAA=', 0),
      keyId: Long('0')
    }
  },
  operationTime: Timestamp({ t: 1732558257, i: 1 })
}
[direct: mongos] test> {
  collectionsharded: 'somedb.helloDoc',
  ok: 1,
  '$clusterTime': {
    clusterTime: Timestamp({ t: 1732558257, i: 53 }),
    signature: {
      hash: Binary.createFromBase64('AAAAAAAAAAAAAAAAAAAAAAAAAAA=', 0),
      keyId: Long('0')
    }
  },
  operationTime: Timestamp({ t: 1732558257, i: 52 })
}
[direct: mongos] test>
[direct: mongos] test> switched to db somedb
[direct: mongos] somedb>
[direct: mongos] somedb> DeprecationWarning: Collection.insert() is deprecated. Use insertOne, insertMany, or bulkWrite.
{
  acknowledged: true,
  insertedIds: { '0': ObjectId('6744bdb8b55596ca91fe6cf8') }
}
[direct: mongos] somedb>
[direct: mongos] somedb> 1000
```

</details>

## Задание 3. Репликация 

![](/mongo-sharding-repl/pic/swagger-root.png)

<details>
<summary>Листинг команд:</summary>

``` sh
qwuen@MSI:/mnt/d/projects/architecture-sprint-2/mongo-sharding-repl$ docker-compose -f compose.yaml up -d
[+] Running 17/17
 ⠿ Network mongo-sharding-repl_app-network     Created                                                             0.1s
 ⠿ Volume "mongo-sharding-repl_shard2-3-data"  Created                                                             0.0s
 ⠿ Volume "mongo-sharding-repl_config-data"    Created                                                             0.0s
 ⠿ Volume "mongo-sharding-repl_shard2-1-data"  Created                                                             0.0s
 ⠿ Volume "mongo-sharding-repl_shard1-1-data"  Created                                                             0.0s
 ⠿ Volume "mongo-sharding-repl_shard1-3-data"  Created                                                             0.0s
 ⠿ Volume "mongo-sharding-repl_shard2-2-data"  Created                                                             0.0s
 ⠿ Volume "mongo-sharding-repl_shard1-2-data"  Created                                                             0.0s
 ⠿ Container shard2_3                          Started                                                             1.8s
 ⠿ Container shard2_2                          Started                                                             2.1s
 ⠿ Container shard2_1                          Started                                                             2.7s
 ⠿ Container shard1_1                          Started                                                             2.6s
 ⠿ Container shard1_3                          Started                                                             2.6s
 ⠿ Container mongos_router                     Started                                                             2.6s
 ⠿ Container shard1_2                          Started                                                             1.6s
 ⠿ Container configSrv                         Started                                                             1.6s
 ⠿ Container pymongo_api                       Started                                                             3.2s
qwuen@MSI:/mnt/d/projects/architecture-sprint-2/mongo-sharding-repl$ ./scripts/mongo-init.sh
test> ... ... ... ... ... ... ... ... {
  ok: 1,
  '$clusterTime': {
    clusterTime: Timestamp({ t: 1732561117, i: 1 }),
    signature: {
      hash: Binary.createFromBase64('AAAAAAAAAAAAAAAAAAAAAAAAAAA=', 0),
      keyId: Long('0')
    }
  },
  operationTime: Timestamp({ t: 1732561117, i: 1 })
}
config_server [direct: secondary] test> test> ... ... ... ... ... ... ... ... ... {
  ok: 1,
  '$clusterTime': {
    clusterTime: Timestamp({ t: 1732561118, i: 1 }),
    signature: {
      hash: Binary.createFromBase64('AAAAAAAAAAAAAAAAAAAAAAAAAAA=', 0),
      keyId: Long('0')
    }
  },
  operationTime: Timestamp({ t: 1732561118, i: 1 })
}
shard1 [direct: secondary] test> test> ... ... ... ... ... ... ... ... ... {
  ok: 1,
  '$clusterTime': {
    clusterTime: Timestamp({ t: 1732561121, i: 1 }),
    signature: {
      hash: Binary.createFromBase64('AAAAAAAAAAAAAAAAAAAAAAAAAAA=', 0),
      keyId: Long('0')
    }
  },
  operationTime: Timestamp({ t: 1732561121, i: 1 })
}
shard2 [direct: secondary] test> [direct: mongos] test>
[direct: mongos] test> {
  shardAdded: 'shard1',
  ok: 1,
  '$clusterTime': {
    clusterTime: Timestamp({ t: 1732561131, i: 7 }),
    signature: {
      hash: Binary.createFromBase64('AAAAAAAAAAAAAAAAAAAAAAAAAAA=', 0),
      keyId: Long('0')
    }
  },
  operationTime: Timestamp({ t: 1732561131, i: 7 })
}
[direct: mongos] test> {
  shardAdded: 'shard2',
  ok: 1,
  '$clusterTime': {
    clusterTime: Timestamp({ t: 1732561133, i: 24 }),
    signature: {
      hash: Binary.createFromBase64('AAAAAAAAAAAAAAAAAAAAAAAAAAA=', 0),
      keyId: Long('0')
    }
  },
  operationTime: Timestamp({ t: 1732561133, i: 18 })
}
[direct: mongos] test>
[direct: mongos] test> {
  ok: 1,
  '$clusterTime': {
    clusterTime: Timestamp({ t: 1732561133, i: 32 }),
    signature: {
      hash: Binary.createFromBase64('AAAAAAAAAAAAAAAAAAAAAAAAAAA=', 0),
      keyId: Long('0')
    }
  },
  operationTime: Timestamp({ t: 1732561133, i: 29 })
}
[direct: mongos] test> {
  collectionsharded: 'somedb.helloDoc',
  ok: 1,
  '$clusterTime': {
    clusterTime: Timestamp({ t: 1732561135, i: 12 }),
    signature: {
      hash: Binary.createFromBase64('AAAAAAAAAAAAAAAAAAAAAAAAAAA=', 0),
      keyId: Long('0')
    }
  },
  operationTime: Timestamp({ t: 1732561135, i: 12 })
}
[direct: mongos] test>
[direct: mongos] test> switched to db somedb
[direct: mongos] somedb>
[direct: mongos] somedb> DeprecationWarning: Collection.insert() is deprecated. Use insertOne, insertMany, or bulkWrite.
{
  acknowledged: true,
  insertedIds: { '0': ObjectId('6744c8fedc444e8ccbfe6cf8') }
}
[direct: mongos] somedb>
[direct: mongos] somedb> 1000
```

</details>

## Задание 4. Кэширование

![](/sharding-repl-cache/pic/swagger-root.png)

<details>
<summary>Листинг команд:</summary>

``` sh
qwuen@MSI:/mnt/d/projects/architecture-sprint-2/sharding-repl-cache$ docker-compose -f compose.yaml up -d
[+] Running 19/19
 ⠿ Network mongo-sharding-repl_app-network     Created                                                             0.0s
 ⠿ Volume "mongo-sharding-repl_shard2-1-data"  Created                                                             0.0s
 ⠿ Volume "mongo-sharding-repl_shard1-2-data"  Created                                                             0.0s
 ⠿ Volume "mongo-sharding-repl_shard1-1-data"  Created                                                             0.0s
 ⠿ Volume "mongo-sharding-repl_shard2-2-data"  Created                                                             0.0s
 ⠿ Volume "mongo-sharding-repl_shard1-3-data"  Created                                                             0.0s
 ⠿ Volume "mongo-sharding-repl_shard2-3-data"  Created                                                             0.0s
 ⠿ Volume "mongo-sharding-repl_redis_data"     Created                                                             0.0s
 ⠿ Volume "mongo-sharding-repl_config-data"    Created                                                             0.0s
 ⠿ Container configSrv                         Started                                                             1.8s
 ⠿ Container mongos_router                     Started                                                             1.2s
 ⠿ Container shard2_3                          Started                                                             1.8s
 ⠿ Container shard2_2                          Started                                                             2.2s
 ⠿ Container shard1_1                          Started                                                             2.2s
 ⠿ Container shard1_2                          Started                                                             1.2s
 ⠿ Container shard1_3                          Started                                                             1.7s
 ⠿ Container redis_1                           Started                                                             0.9s
 ⠿ Container shard2_1                          Started                                                             2.4s
 ⠿ Container pymongo_api                       Started

 qwuen@MSI:/mnt/d/projects/architecture-sprint-2/sharding-repl-cache$ ./scripts/mongo-init.sh
test> ... ... ... ... ... ... ... ... {
  ok: 1,
  '$clusterTime': {
    clusterTime: Timestamp({ t: 1732602723, i: 1 }),
    signature: {
      hash: Binary.createFromBase64('AAAAAAAAAAAAAAAAAAAAAAAAAAA=', 0),
      keyId: Long('0')
    }
  },
  operationTime: Timestamp({ t: 1732602723, i: 1 })
}
test> test> ... ... ... ... ... ... ... ... ... {
  ok: 1,
  '$clusterTime': {
    clusterTime: Timestamp({ t: 1732602724, i: 1 }),
    signature: {
      hash: Binary.createFromBase64('AAAAAAAAAAAAAAAAAAAAAAAAAAA=', 0),
      keyId: Long('0')
    }
  },
  operationTime: Timestamp({ t: 1732602724, i: 1 })
}
shard1 [direct: secondary] test> test> ... ... ... ... ... ... ... ... ... {
  ok: 1,
  '$clusterTime': {
    clusterTime: Timestamp({ t: 1732602725, i: 1 }),
    signature: {
      hash: Binary.createFromBase64('AAAAAAAAAAAAAAAAAAAAAAAAAAA=', 0),
      keyId: Long('0')
    }
  },
  operationTime: Timestamp({ t: 1732602725, i: 1 })
}
test> [direct: mongos] test>
[direct: mongos] test> {
  shardAdded: 'shard1',
  ok: 1,
  '$clusterTime': {
    clusterTime: Timestamp({ t: 1732602736, i: 19 }),
    signature: {
      hash: Binary.createFromBase64('AAAAAAAAAAAAAAAAAAAAAAAAAAA=', 0),
      keyId: Long('0')
    }
  },
  operationTime: Timestamp({ t: 1732602736, i: 19 })
}
[direct: mongos] test> {
  shardAdded: 'shard2',
  ok: 1,
  '$clusterTime': {
    clusterTime: Timestamp({ t: 1732602736, i: 46 }),
    signature: {
      hash: Binary.createFromBase64('AAAAAAAAAAAAAAAAAAAAAAAAAAA=', 0),
      keyId: Long('0')
    }
  },
  operationTime: Timestamp({ t: 1732602736, i: 40 })
}
[direct: mongos] test>
[direct: mongos] test> {
  ok: 1,
  '$clusterTime': {
    clusterTime: Timestamp({ t: 1732602737, i: 8 }),
    signature: {
      hash: Binary.createFromBase64('AAAAAAAAAAAAAAAAAAAAAAAAAAA=', 0),
      keyId: Long('0')
    }
  },
  operationTime: Timestamp({ t: 1732602737, i: 5 })
}
[direct: mongos] test> {
  collectionsharded: 'somedb.helloDoc',
  ok: 1,
  '$clusterTime': {
    clusterTime: Timestamp({ t: 1732602737, i: 58 }),
    signature: {
      hash: Binary.createFromBase64('AAAAAAAAAAAAAAAAAAAAAAAAAAA=', 0),
      keyId: Long('0')
    }
  },
  operationTime: Timestamp({ t: 1732602737, i: 57 })
}
[direct: mongos] test>
[direct: mongos] test> switched to db somedb
[direct: mongos] somedb>
[direct: mongos] somedb> DeprecationWarning: Collection.insert() is deprecated. Use insertOne, insertMany, or bulkWrite.
{
  acknowledged: true,
  insertedIds: { '0': ObjectId('67456b7a68e943a783fe6cf8') }
}
[direct: mongos] somedb>
[direct: mongos] somedb> 1000

```
</details>

Результат:   
``` sh
qwuen@MSI:/mnt/d/projects/architecture-sprint-2/sharding-repl-cache$ ./scripts/mongo-test.sh
shard1 [direct: secondary] test> switched to db somedb
shard1 [direct: secondary] somedb> 492
shard1 [direct: secondary] somedb> shard2 [direct: primary] test> switched to db somedb
shard2 [direct: primary] somedb> 508
shard2 [direct: primary] somedb>
```

