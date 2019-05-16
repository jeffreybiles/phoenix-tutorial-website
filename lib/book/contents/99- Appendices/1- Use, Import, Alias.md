# Appendix: Use, Import, Alias

One of the most important tasks in any programming environment is bringing in code from elsewhere; it lets you reuse functionality and keep everything clean.  Elixir and Phoenix have a series of elegant tools available to do that.

In this appendix we're going to focus on the `use`, `import`, and `alias` keywords and what they specifically bring to our Router and Controller files.  There are, of course, functions beyond this (config files, mix, etc.).

## use StarTrackerWeb, :router

In the tutorial we had the following Router file:

```elixir
defmodule StarTrackerWeb.Router do
  use StarTrackerWeb, :router

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

  scope "/", StarTrackerWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/info", PageController, :info
  end

  # Other scopes may use custom stacks.
  # scope "/api", StarTrackerWeb do
  #   pipe_through :api
  # end
end
```

We explained briefly what each of the macros (`pipeline`, `plug`, `scope`, `pipe_through`, `get`) did, but not where they came from.  They're not defined in the core Elixir libraries... instead, they're all made available by the line `use StarTrackerWeb, :router`.

The first link of the chain can be found in `lib/star_tracker_web.ex`.

```Elixir
defmodule StarTrackerWeb do
  # ...

  def router do
    quote do
      use Phoenix.Router
      import Plug.Conn
      import Phoenix.Controller
    end
  end

  # ...

  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
```

The comments with `...` are simply code blocks that I've left out in order to make the explanation more concise.

The path through this code starts with `defmacro __using__`.  That is what is called first by Elixir when someone calls `use ThisModuleName`.  So it takes one argument, which in this case is `:router`.  The only line in `defmacro __using__` then uses that argument to call a function within the module with the name of that argument- in this case, the `router` function.  A convoluted way of doing things, but having this complication once means that every Phoenix app gets to enjoy a nicer syntax every time they use the `use MyAppWeb` interface.

## quote

There are lots of cool complicated things you can do with `quote`, but in this file it sticks to doing one relatively simple thing- taking what's within the `quote do ... end` block and dumping it into the file that called the macro where `quote` is used.

So, in this case, the effect of putting `use StarTrackerWeb, :router` in your file is the same as putting in `use Phoenix.Router`, as well as `import Plug.Conn` and `import Phoenix.Controller`.

Why the added layer of indirection?  Having this indirection allows us to put in "standard" things that will show up in every instance where the macro is used.  It's much easier to type in `use StarTrackerWeb, :router` than all three lines, and if you want to change those lines it's better to have them in one centralized place.  This is more useful for Controllers and Views, since there's generally one Router per Phoenix app, but many Controllers and Views.

---

> **Previously On: Indirection**

> "Indirection" can mean various things in a programming context, but when it's used as in "layer of indirection" people generally mean that there are several function calls that don't seem strictly necessary but are there for organizational purposes.

> There are cases where these organizational purposes are valid and worth the cost of adding a layer of indirection (Phoenix usually makes good choices in this regard), but there are also cases where it's meaningless complication that just makes your program harder to understand.

> One of the marks of an experienced developer is that they understand the pros and cons of adding specific layers of indirection.  For now, just go with Phoenix's defaults unless you have a very compelling reason not to.

---

So now that we see that this use of `use StarTrackerWeb, :router` gives us the same effect as `use Phoenix.Router`, `import Plug.Conn`, and `import Phoenix.Controller`. Let's see what that first command brings us.

## use Phoenix.Router

So far we've gotten all our modules from `StarTracker`- our own web app.  Now we're getting a module from `Phoenix`, so we'll have to dig into where the framework code is stored.

## deps

The path for that is in the `deps` folder.  Your text editor may have that folder greyed out, but it should still be available for browsing.  If your text editor has it completely hidden, you can use the command line (`ls` and `cd` commands) or your OS's file browser to explore.

Within the `deps` are all your app's dependencies, brought in from across the web.  Currently we're only interested in the `phoenix` folder.  Specifically, the file we're looking for has a path of `deps/phoenix/lib/phoenix/router.ex`.

## Phoenix.Router

Here's a simplified version of that file:

```elixir
defmodule Phoenix.Router do
  @http_methods [:get, :post, :put, :patch, :delete, :options, :connect, :trace, :head]

  def __using__(_) do
    defmacro __before_compile__(env) do #
    defmacro match(verb, path, plug, plug_opts, options \\ []) do #

    for verb <- @http_methods do
      defmacro unquote(verb)(path, plug, plug_opts, options \\ []) do #
        add_route(:match, unquote(verb), path, plug, plug_opts, options)
      end
    end

    defmacro pipeline(plug, do: block) do #
    defmacro plug(plug, opts \\ []) do #
    defmacro pipe_through(pipes) do #
    defmacro resources(path, controller, opts, do: nested_context) do #
    defmacro resources(path, controller, do: nested_context) do #
    defmacro resources(path, controller, opts) do #
    defmacro resources(path, controller) do #
    defmacro scope(options, do: context) do #
    defmacro scope(path, options, do: context) do#
    defmacro scope(path, alias, options, do: context) do #

    defmacro forward(path, plug, plug_opts \\ [], router_opts \\ []) do #
  end
end
```

You can see that we're defining all of the macros which we used earlier, including several versions of `scope` (remember: pattern matching based on number of arguments), as well as a couple more we haven't seen yet.

That's enough of a dive into the source code- we won't go into detail on how each of them is defined... although you're welcome to explore as much as you like on your own.

## import

When we used `use StarTrackerWeb, :router`, it also automatically gave us two import statements: `import Plug.Conn`, and `import Phoenix.Controller`.

Like `use`, `import` drops function definitions directly into the current module's namespace.

What sets them apart: `use` calls the `__using__` callback in order to inject code into the current module, and `import` doesn't.  `import` can also have the `only` option, which takes a list of function names (and their arities) and then only puts those specific functions into the current module's namespace.

We'll be using `import` often in our own code, and we'll recap it the first time that happens.

## use StarTracker.Web, :controller

In our controller we call `use StarTrackerWeb, :controller`.  Like in the Router, this takes us to our `star_tracker_web.ex` file.

```elixir
defmodule StarTrackerWeb do
  # ...
  def controller do
    quote do
      use Phoenix.Controller, namespace: StarTrackerWeb

      import Plug.Conn
      import StarTrackerWeb.Gettext
      alias StarTrackerWeb.Router.Helpers, as: Routes
    end
  end
  # ...
  def router do
    quote do
      use Phoenix.Router
      import Plug.Conn
      import Phoenix.Controller
    end
  end
  # ...

  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
```

We're `use`-ing and `import`-ing some different files, and we're also using `alias`.  Let's tackle the now-familiar `use` first.

## use Phoenix.Controller

Here's a highly-compacted version of `Phoenix.Controller`, with 90% of the function names and 100% of the actual code redacted for simplicity's sake (the actual file is 1475 lines long, as of this writing).

```elixir
defmodule Phoenix.Controller do
  #...
  def html(conn, data) do #...
  def redirect(conn, opts) when is_list(opts) do #...

  # ...

  def render(conn, template_or_assigns \\ [])
  def render(conn, template) when is_binary(template) or is_atom(template) do # ...
  def render(conn, assigns) do #...

  def render(conn, template, assigns) when is_atom(template) and (is_map(assigns) or is_list(assigns)) do #...
  def render(conn, template, assigns) when is_binary(template) and (is_map(assigns) or is_list(assigns)) do #...
  def render(conn, view, template) when is_atom(view) and (is_binary(template) or is_atom(template)) do # ...

  def render(conn, view, template, assigns) when is_atom(view) and (is_binary(template) or is_atom(template)) do #...

  #...
end
```

Here we see 7 different definitions of `render` (the one Controller function we've used so far), each differentiated by the number of arguments (arity) as well as some `when` clauses (a particular definition of `render` will only be used if its `when` clause is true).

There are lots more definitions in this file, including `html` and `redirect`, but for now there's nothing else for us to learn here.  Time to look at the other things brought in by `use StarTracker.Web, :controller`.

## alias

The final line for `controller` is `alias StarTrackerWeb.Router.Helpers, as: Routes`.  We haven't used this yet, but the explanation is easy *if you don't worry about what `StarTrackerWeb.Router.Helpers` actually does*.

Let's start with a slightly simpler case.  If we had `alias StarTrackerWeb.Router.Helpers`, then whenever we want to access any function in that module, we could leave off the `StarTrackerWeb.Router` part, and just reference `Helpers.function_name`.  This makes things more convenient.

Then we add the `as` option to the alias.  `alias StarTrackerWeb.Router.Helpers, as: Routes` allows us to call `Routes.function_name`.  The default usage is equivalent to putting the last part of the aliased module in the `as` option (`alias StarTrackerWeb.Router.Helpers, as: Helpers`).

We'll be using `alias` often in our own code, and we'll recap it the first time that happens.

## Conclusion

So that's how we get all the macros like `render`, `get`, and `scope`.

I hope this demystified some of the Elixir Magic for you.  If not, then don't worry too much about it; although an understanding of the concepts in this appendix is helpful, it's by no means required, and you can make a great app while still thinking of `use` as just a mysterious line that makes your Router and Controller work.