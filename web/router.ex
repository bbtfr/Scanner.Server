defmodule Scanner.Router do
  use Scanner.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Scanner do
    pipe_through :browser
  end

  scope "/api", Scanner.API do
    pipe_through :api

    get "/identity/abilities", IdentityController, :abilities
    post "/identity/identify", IdentityController, :identify

    get "/news", NewsController, :index
  end
end
