# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :beer_catalog_api,
  ecto_repos: [BeerCatalogApi.Repo]

# Configures the endpoint
config :beer_catalog_api, BeerCatalogApiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "aQMQrps9eDetshwgrLYrUcr1XRFARKcZE+JUO650SnZUk+COA0nkHL1EfRTG3HoQ",
  render_errors: [view: BeerCatalogApiWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: BeerCatalogApi.PubSub,
  live_view: [signing_salt: "hkZ92/yc"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

# Especificar el archivo de salida, router y endpoint modules que
# genera el archivo de swagger
config :beer_catalog_api, :phoenix_swagger,
  swagger_files: %{
    "priv/static/swagger.json" => [
      router: BeerCatalogApiWeb.Router, # phoenix routes will be converted to swagger paths
      endpoint: BeerCatalogApiWeb.Endpoint # (optional) endpoint config used to set host, port and https schemes.
    ]
  }

# Configuramos Swagger para usar Jason como su librería de JSON
config :phoenix_swagger, json_library: Jason
