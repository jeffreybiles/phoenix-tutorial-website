# Creating a Material

Of all the things that we can do with the generated routes, creating and editing the data are the most complex.

That's why I've saved them for last.

We'll go over creation in this chapter, which will be fairly long.  In the next chapter we'll go over editing, which should be fairly short since it mostly goes over the same material.  Then, in this section's final chapter, we'll pull together everything we've learned and add a new data field to our `Material`s.
<!-- TODO: check that we're actually going to be able to fit creating a new data field into one chapter  -->

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

Let's take a look at our form:

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

Here's it again in highly simplified form:

```html
<%= form_for @changeset, @action, fn f -> %>
  <!-- error message display -->
  <!-- name field -->
  <!-- amount field -->

  <div><%= submit "Save" %></div>
<% end %>
```

`form_for` is a helper that takes three arguments: `@changeset`, `@action`, and a function with one argument (`f`), which is short for "form".  The `submit` helper, when used withn a `form_for` helper, submits the form using the `@action` defined (in this case, we passed in the action when rendering the `form` partial.)

There are many ways you can choose to display a field, and we'll go over those variations later in this book, but for now let's look at the standard generated way.

```html
<%= label f, :name %>
<%= text_input f, :name %>
<%= error_tag f, :name %>
```

There are three parts to this.

The first is the label.  It's what displays above the input field.  The label helper can take one to four arguments (or, said another way, there are at least four definitions of the `label` helper).  We're using the one with two arguments: the form as defined by `form_for`, `f`, and the field in the `material` Schema that it applies to, `:name`.  It will automatically use that field name to generate the label, but if you want something different you can also customize it via a third argument.

The second is the input field itself.  The user will use this to type in the value for the field. Here it's `text_input`, but there are many input fields that match different data types (such as `number_input`, which is used for `amount`).  This takes two arguments plus an optional options hash.  The first argument is once again the form as defined by `form_for`, `f`, and the second argument is once again the field in the `material` Schema that it applies to, `:name`.

The third is the error tag.  This is what displays errors for this field.  These errors will be calculated on the Changeset when we post to the `create` route, then displayed here.  You already know what the first and second arguments are, because they're the same as before, but now it's even simpler because there are no optional fields.

If you understood the last three paragraphs, then you should be able to grok the three lines used for `:amount`.

```html
<%= label f, :amount %>
<%= number_input f, :amount %>
<%= error_tag f, :amount %>
```

So we'll go ahead and move on to the last part of the form:

```html
<%= if @changeset.action do %>
  <div class="alert alert-danger">
    <p>Oops, something went wrong! Please check the errors below.</p>
  </div>
<% end %>
```

When we submit the form and post to the `create` route, it will either succeed or there will be an error.  If there's an error, we'll end up back here with a new Changeset, and this one will have an `action` on it, and we'll display the error message.  So it'll have this error message on top, plus the specific error messages below individual fields.

So now we've finally finished covering the `new` route... but to actually create a new instance of `Material` and save it to the database, we need to hit the `create` route as well.

## The `create` Controller Function

When rendering the `form` partial, we passed it `Routes.material_path(@conn, :create)` as the action.  That means that when we hit the `submit` button, we'll go to the `create` function on the `MaterialController`.

Let's take a look at it.

```elixir
def create(conn, %{"material" => material_params}) do
  case Trade.create_material(material_params) do
    {:ok, material} ->
      conn
      |> put_flash(:info, "Material created successfully.")
      |> redirect(to: Routes.material_path(conn, :show, material))

    {:error, %Ecto.Changeset{} = changeset} ->
      render(conn, "new.html", changeset: changeset)
  end
end
```

This is the most complex controller function we've seen, but there are no new concepts here yet (there are some in `Trade.create_material`, even though it's just three lines).  Let's break it down.

First, we take two arguments: `conn`, the connection, and then the params, which we're pattern-matching for `"material"` and assigning that to `material_params`.  These params are what we filled out in the field, and will currently hold `:amount` and `:name`.

Then we open up a case statement.  The expression is the results from `Trade.create_material(material_params)`, and it's a tuple.  There are two options for the tuple, as seen below: `{:ok, material}` and `{:error, %Ecto.Changeset{}}`.  That is to say, it can return successfully with a newly created `material`, or it can return unsuccessfully with a new version of the Changeset.

If it returns successfully, we do something very similar to what we did in the `delete` function, with the differences being in the flash message used and the route that we send the user to (`:show` instead of `:index`).

If it returns unsuccessfully, then we re-render the `new` route, but with the new version of the Changeset.  Now it will have the values we tried to apply (so the user doesn't have to fill out the form again) and the errors (so the user knows what needs to be fixed).

Now let's take a look at what's happening in `Trade.create_material` that gives us that tuple.

## Creating the Material

Here's the code for `Trade.create_material`:

```elixir
def create_material(attrs \\ %{}) do
  %Material{}
  |> Material.changeset(attrs)
  |> Repo.insert()
end
```

We start off with a blank Material Schema (`%Material{}`).

Then we pipe that into `Material.changeset`, and have the `attrs` as the second argument.  Recall that this is what we did earlier in `Trade.change_material`, which prepared a Changeset for the `new` function, but now we're feeding it actual attributes passed in from the form, rather than a blank Map (although a blank Map is the default if you don't pass anything in).

Finally, we pipe the Changeset we just created to `Repo.insert`.  This will try to create a new record in the database, and this is where we get the success or failure tuples that we received in the `create` controller function.

## Conclusion

We covered a lot in this chapter.

First, we saw how the `new` route is displayed.  We generate a blank Material Changeset using `Trade.change_material`, then feed it to `lib/star_tracker_web/templates/material/new.html.eex` template.  That template then renders the `form` partial, passing down the Changeset and an action (`Routes.material_path(@conn, :create)`).  Then we used the `form_for` helper to specify how the form is displayed.

Then we saw what happened once the user hits the submit button and sends their form data to the `create` route.  We take the form data and feed it to `Trade.create_material`.  That method creates a Changeset from the data and tries to put it into the database via `Repo.insert`.  If successful it returns `{:ok, material}`, and then we take the newly created material and redirect to its `show` page.  If failed, it returns `{:error, %Changeset{} = changeset}`, and then we use the new Changeset to re-render the `new` page.

In the next chapter we're going to see the `edit` and `update` routes, which are very similar to the `new` and `create` routes, but with some minor changes.  That will be a great review if the concepts of this chapter are still a little shaky.

But first, let's solidify what you've learned with some exercises.

## Exercises

1. Changesets:
  a. Change the Changeset so that the `amount` field isn't required, and will not error even if no amount is given.
  b. Now change it so `amount` isn't allowed in the changeset, and will error if any number is given.
  c. Make it so that there are always 1000 of any material that's created.
  d. Challenge: allow the `amount` field to be filled out, but have 1000 as a default if it's not.
  <!-- TODO: check and make sure that this is possible with what we've told people so far -->
2. Replace the generic error message (the part sectioned off by `if @changeset.action`) with a flash error message in the error case of `create`.  After doing that, think about why Phoenix chose to do it the way they did, rather than use a flash message.
