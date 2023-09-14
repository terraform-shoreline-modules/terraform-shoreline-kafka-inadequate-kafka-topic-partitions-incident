
### About Shoreline
The Shoreline platform provides real-time monitoring, alerting, and incident automation for cloud operations. Use Shoreline to detect, debug, and automate repairs across your entire fleet in seconds with just a few lines of code.

Shoreline Agents are efficient and non-intrusive processes running in the background of all your monitored hosts. Agents act as the secure link between Shoreline and your environment's Resources, providing real-time monitoring and metric collection across your fleet. Agents can execute actions on your behalf -- everything from simple Linux commands to full remediation playbooks -- running simultaneously across all the targeted Resources.

Since Agents are distributed throughout your fleet and monitor your Resources in real time, when an issue occurs Shoreline automatically alerts your team before your operators notice something is wrong. Plus, when you're ready for it, Shoreline can automatically resolve these issues using Alarms, Actions, Bots, and other Shoreline tools that you configure. These objects work in tandem to monitor your fleet and dispatch the appropriate response if something goes wrong -- you can even receive notifications via the fully-customizable Slack integration.

Shoreline Notebooks let you convert your static runbooks into interactive, annotated, sharable web-based documents. Through a combination of Markdown-based notes and Shoreline's expressive Op language, you have one-click access to real-time, per-second debug data and powerful, fleetwide repair commands.

### What are Shoreline Op Packs?
Shoreline Op Packs are open-source collections of Terraform configurations and supporting scripts that use the Shoreline Terraform Provider and the Shoreline Platform to create turnkey incident automations for common operational issues. Each Op Pack comes with smart defaults and works out of the box with minimal setup, while also providing you and your team with the flexibility to customize, automate, codify, and commit your own Op Pack configurations.

# Inadequate Kafka Topic Partitions Incident
---

This incident type refers to a situation where the number of partitions for a Kafka topic is insufficient to handle the incoming data stream. This can lead to low throughput and/or increased write latency. In order to resolve this issue, it may be necessary to increase the number of Kafka topic partitions. Failure to address this issue can lead to degraded performance and potential data loss.

### Parameters
```shell
export BROKER_HOSTNAME="PLACEHOLDER"

export PORT="PLACEHOLDER"

export TOPIC_NAME="PLACEHOLDER"

export NUM_PARTITIONS="PLACEHOLDER"
```

## Debug

### Check the number of partitions for the Kafka topic
```shell
kafka-topics.sh --bootstrap-server ${BROKER_HOSTNAME}:${PORT} --describe --topic ${TOPIC_NAME}
```

### Check the current throughput of the Kafka topic
```shell
kafka-run-class.sh kafka.tools.GetOffsetShell --broker-list ${BROKER_HOSTNAME}:${PORT} --topic ${TOPIC_NAME} --time -1 | awk -F ":" '{sum += $3} END {print sum}'
```

### Check the current write latency of the Kafka topic
```shell
kafka-console-producer.sh --broker-list ${BROKER_HOSTNAME}:${PORT} --topic ${TOPIC_NAME} | kafka-console-consumer.sh --bootstrap-server ${BROKER_HOSTNAME}:${PORT} --topic ${TOPIC_NAME} --consumer-property group.id=test-consumer-group --from-beginning --max-messages 1
```

## Repair

### Increase the number of partitions for the Kafka topic
```shell
kafka-topics.sh --bootstrap-server ${BROKER_HOSTNAME}:${PORT} --alter --topic ${TOPIC_NAME} --partitions ${NUM_PARTITIONS}
```