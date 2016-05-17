defmodule Agendabot.Router do
  use Agendabot.Web, :router

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

  pipeline :slackhooks do
    plug :accepts, ["application/x-www-form-urlencoded", "json"]
  end

  scope "/", Agendabot do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end


  post "/slack/slashcmd", Agendabot.SlashcmdController, :slashcmd
  # Other scopes may use custom stacks.
  # scope "/api", Agendabot do
  #   pipe_through :api
  # end
end
