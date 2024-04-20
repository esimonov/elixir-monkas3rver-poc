import Config

config :kaffe,
  consumer: [
    endpoints: [localhost: 9096],
    topics: ["dev.activity-records"],
    consumer_group: "dev-consumer-group",
    message_handler: POCService.ActivityRecordsConsumer,
    sasl: %{
      mechanism: :plain,
      login: "kafkauser",
      password: "kafkapassword"
    }
  ]

config :kaffe,
  producer: [
    endpoints: [localhost: 9096],
    topics: ["dev.activity-records"],
    message_handler: POCService.Producer.Kafka,
    sasl: %{
      mechanism: :plain,
      login: "kafkauser",
      password: "kafkapassword"
    }
  ]

config :logger, backends: [LoggerJSON]

config :logger_json, :backend,
  metadata: :all,
  json_encoder: Jason,
  formatter: LoggerJSON.Formatters.BasicLogger

config :poc_service, :mongo,
  name: :mongo,
  database: "monkas3rver",
  pool_size: 3,
  url: "mongodb://localhost:27017",
  username: "admin",
  password: "password",
  auth_source: "admin"

config :poc_service, http_server_port: 8081
config :poc_service, activity_records_producer_impl: POCService.Producer.Kafka
config :poc_service, bookmarks_storage_impl: POCService.Storage.MongoDB
config :poc_service, activity_records_storage_impl: POCService.Storage.S3
