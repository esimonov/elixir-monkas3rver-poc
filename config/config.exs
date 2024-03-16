import Config

config :logger, backends: [LoggerJSON]

config :logger_json, :backend,
  metadata: :all,
  json_encoder: Jason,
  formatter: LoggerJSON.Formatters.BasicLogger

config :poc_service, http_server_port: 8081
config :poc_service, producer_impl: POCService.Producer.Kafka
config :poc_service, storage_impl: POCService.Storage.MongoDB
