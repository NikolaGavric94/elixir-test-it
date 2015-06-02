defmodule Infinityloop.Router do
  use Infinityloop.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Infinityloop do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    post "/info", PageController, :info
    get "/analyze", PageController, :analyze
    resources "/items", ItemController
  end

  # Other scopes may use custom stacks.
  # scope "/api", Infinityloop do
  #   pipe_through :api
  # end
end
