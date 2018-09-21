## New properties

Set any redis.conf parameters using redis.raw_config.  

Example:
```yaml
properties:
  redis:
    raw_config: |
      maxmemory-policy allkeys-lru
      maxmemory-samples 10
      databases 1
      appendonly yes
      maxmemory 6144mb
```