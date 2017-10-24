## Redis inside containers

The `redis` job template is now run inside `bpm` garden containers. This has massively
simplified the `redis` job template (5 years old pid scripts are gone).

Watch https://www.youtube.com/watch?v=N4fZ4a-9Mqs&list=PLhuMOCWn4P9hsn9q-GRTa77gxavTOnHaa&index=73
to learn more about `bpm` from CF Summit EU 2017. Join the `#bpm` channel in slack
to talk to the team working on it.

CI pipeline will also automatically try to update to any new versions of `bpm` https://ci.starkandwayne.com/teams/main/pipelines/redis-boshrelease?groups=bpm

This will be a bumpy road until bpm 1.0.0. I'll try to fix any breakages asap.

See the `#redis-boshrelease` slack channel for discussions.

## Improvements

- refactor `redis_save_intervals` var as a block parameter.
- reformat template code for save intervals generation to improve its readability.
