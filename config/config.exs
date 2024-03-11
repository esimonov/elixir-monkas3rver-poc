import Config

config :poc_service, http_server_port: 8081
config :poc_service, storage_impl: POCService.Storage.MongoDB
