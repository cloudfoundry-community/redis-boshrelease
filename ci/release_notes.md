When redis.maxclients is not set in the manifest, we set the fdlimit to 12500 (25% buffer on top of the default 10k maxclients).
If redis.maxclients is set, the fdlimit will be automatically set to 25% higher.

BPM hook for pre_start.sh script addresses startup warnings and applies best practices from https://redis.io/topics/admin. 
These changes are as follows:
* Disabled transparent_hugepage
* Set backlogged sockets to 65535 instead of 128
* Set memory overcommit handling mode to 1

Package Changes:

* Bumped bpm to v0.12.3
