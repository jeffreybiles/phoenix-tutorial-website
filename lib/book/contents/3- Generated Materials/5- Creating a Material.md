# Creating a Material

Of all the things that we can do with the generated routes, creating and editing the data are the most complex.

That's why I've saved them for last.

We'll go over creation in this chapter, which will be fairly long.  In the next chapter we'll go over editing, which should be fairly short since it mostly goes over the same material.  Then, in this section's final chapter, we'll pull together everything we've learned and add a new data field to our `Material`s.
<!-- TODO: check two things: that this chapter is long and that we're actually going to be able to fit creating a new data field into one chapter  -->

## The Two-Step Process

When creating a resource, we'll be going through two stages: first, we'll be visiting the `new` page, and then, after filling out the information, we'll be hitting the `create` function in order to add the new `Material` to the database.

Both of these are separate routes, which are defined by the `resources "/materials", MaterialController` we put in our routes file.
If defined separately, they would look like this:

```elixir
  get "/materials/new", MaterialController, :new
  post "/materials", MaterialController, :create
```

`new` is a `get`, so we'll be getting some data (in this case, an empty `%Material` object) then displaying a page.  In that way, it'll work kind of like `show` and `index`.

`create` is a `post`, and it will change the database (adding an item), add a flash message, and then redirect.  In that way, it'll work kind of like `delete`.

## The `new` Controller Function

Let's take a look at the `new` function in `MaterialController`.

```elixir
def new(conn, _params) do
  changeset = Trade.change_material(%Material{})
  render(conn, "new.html", changeset: changeset)
end
```

We're once again calling a function on the `Trade` context, but now instead of getting a `Material` we're getting a changeset.  Let's investigate where that changeset comes from.

In the call `Trade.change_material(%Material{})`, we're feeding the `change_material` function the Schema `%Material{}`.  We'll explain what exactly that is soon.

```elixir
def change_material(%Material{} = material) do
  Material.changeset(material, %{})
end
```

The `%Material` Schema we fed to `change_material` pattern matches with what the function is expecting, so it's assigned to `material`... and fed into `Material.changeset`.  The second argument is a blank Map.

Okay, so we're ultimately getting the changeset from `Material.changeset(%Material, %{})`.  Keep that in mind, but for a second we're going to explore the `new` page's html and see what we're going to do with that changeset.

## The `new` Template

`render(conn, "new.html", changeset: changeset)` feeds the changeset down to the `lib/star_tracker_web/templates/material/new.html.eex` file, so let's take a look at that.

```html
<h1>New Material</h1>

<%= render "form.html", Map.put(assigns, :action, Routes.material_path(@conn, :create)) %>

<span><%= link "Back", to: Routes.material_path(@conn, :index) %></span>
```

The `h1` and `link` should both be familiar to you, but seeing `render` in this context may be new.  It works exactly like `render` does in the controller, but it does so as a sub-section of the page.  The first argument tells us that the html we'll be rendering will be found at `lib/star_tracker_web/templates/material/info.html.eex`, while the second argument is a Map that contains variables, or assignments.

The assignments Map was `%{changeset: changeset}` when being passed into `new.html.eex`, but with the `Map.put` it's now `%{changeset: changeset, action: Routes.material_path(@conn, :create)}` when being passed into the form.

Let's take a look at that form now:

```html
<%= form_for @changeset, @action, fn f -> %>
  <%= if @changeset.action do %>
    <div class="alert alert-danger">
      <p>Oops, something went wrong! Please check the errors below.</p>
    </div>
  <% end %>

  <%= label f, :name %>
  <%= text_input f, :name %>
  <%= error_tag f, :name %>

  <%= label f, :amount %>
  <%= number_input f, :amount %>
  <%= error_tag f, :amount %>

  <div>
    <%= submit "Save" %>
  </div>
<% end %>
```

There's a helper, `form_for`, which takes both `@changeset` and `@action` as the first two arguments.

Now that we've tracked down both where we're using the changeset and where we're getting it from, let's explore what it actually _is_.

## Ecto, Schemas, and Changesets

Changesets are one of the four main parts of Ecto.

Ecto is, according to the github repo, "a toolkit for data mapping and language integrated query".  In simpler (but slightly less accurate) terms, it's a library for handling data and talking to the database.

The four main parts are:

* Ecto.Repo
* Ecto.Schema
* Ecto.Changeset
* Ecto.Query

We've already seen `Ecto.Repo` used before: `Repo.all` and `Repo.get!` are two of the methods we've used to get data from the database.

To understand the form, we'll also need to learn about `Ecto.Schema` and `Ecto.Changeset`.

To see how we're using them, let's take a look at our `Material` file.  We'll find it in `lib/star_tracker/trade/material.ex`.

```elixir
defmodule StarTracker.Trade.Material do
  use Ecto.Schema
  import Ecto.Changeset

  schema "materials" do
    field :amount, :integer
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(material, attrs) do
    material
    |> cast(attrs, [:name, :amount])
    |> validate_required([:name, :amount])
  end
end
```

Right off the bat, we've got `use Ecto.Schema` and `import Ecto.Changeset`.

Then we define our Schema:

```elixir
schema "materials" do
  field :amount, :integer
  field :name, :string

  timestamps()
end
```

This uses a DSL (Domain Specific Language) to easily tell us what the data on the `%Material{}` Schema will look like.  With the `name` and `amount` fields defined as above, we could create one like this: `%Material{name: 'Neon', amount: 200}`.

A Schema like `%Material{}` looks a lot like a Map, and that's because it _is_ a type of Map, but with some extra features.  What's the difference between them?  A plain Map will take any key-value combo, while a Schema will _only_ take the keys defined in the `schema` DSL.

So at the simplest level, a Schema is like a structured Map.  Having the Map be structured can help keep all parts of your app on the same page, preventing many common errors... including the following typo-related example:

<!-- TODO: double-check that this is the correct output -->
```
iex()> map = %{amount: 3}
%{amount: 3}
iex()> map = Map.put(map, :nme, "Sure hope this saves right")
%{amount: 3, nme: "Sure hope this saves right"
iex()> map.name
nil
```

So that's our Schema.

A Changeset is a tool for tracking changes to the data in Schemas like `%Material{}` before committing them to the database.  Our first clue into how this works is where we define the `changeset` function, which will return a Changeset:

```elixir
def changeset(material, attrs) do
  material
  |> cast(attrs, [:name, :amount])
  |> validate_required([:name, :amount])
end
```

In this code, when being called for the purposes of `new`, the `material` variable is equal to `%Material{}`, and the `attrs` variable is equal to `%{}`.

`material` is the current version of the Schema, and the Map in `attrs` contains new values that will be added to the Schema, replacing old values if there's a conflict.

In `cast`, we define the values that are _allowed_ to change.

In `validate_required`, we define the values that _must_ be present for the Changeset to be valid.  You'll note that we do not yet have either of the required values present, so our Changeset is not currently valid.

Both of the above functions can take either a Schema or a Changeset (or a `{data, types}` tuple, but we won't go into that), and they both output a Changeset.

It's that Changeset that gets passed to the `changeset` variable, then put on the `assigns` Map (to be accessed as `@changeset`), and then used in our form.

## Forms
