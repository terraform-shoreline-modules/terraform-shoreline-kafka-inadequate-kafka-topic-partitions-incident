resource "shoreline_notebook" "inadequate_kafka_topic_partitions_incident" {
  name       = "inadequate_kafka_topic_partitions_incident"
  data       = file("${path.module}/data/inadequate_kafka_topic_partitions_incident.json")
  depends_on = []
}

