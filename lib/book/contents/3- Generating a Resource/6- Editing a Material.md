# Editing a Material

We covered a lot in the previous chapter, but the knowledge gained isn't super flexible because we had to cover so much.  In this chapter and the next we'll review these concepts and look at different options and how we can use them in new ways.

The first variation, covered in this chapter, is editing an existing Material instead of creating a new one.

## The `edit` Controller function

Let's look at `new` and `edit` side by side.

```elixir
def new(conn, _params) do
  changeset = Trade.change_material(%Material{})
  render(conn, "new.html", changeset: changeset)
end

def edit(conn, %{"id" => id}) do
  material = Trade.get_material!(id)
  changeset = Trade.change_material(material)
  render(conn, "edit.html", material: material, changeset: changeset)
end
```

They're similar in structure, although `edit` is a bit more complex.  

First, instead of starting with a blank Schema (`%Material{}`), we're getting a previously-created material from the database.  We're then feeding that into `Trade.change_material`, so our Changeset will contain the previously assigned values.

Second, when rendering, we render the `edit` template instead of the `new` template.

Finally, we send the `material` down alongside the `changeset`.

## The `edit` Template

This is what gets rendered:

```html
<h1>Edit Material</h1>

<%= render "form.html", Map.put(assigns, :action, Routes.material_path(@conn, :update, @material)) %>

<span><%= link "Back", to: Routes.material_path(@conn, :index) %></span>
```

This is _very_ similar to the `new` template.  The only differences are that instead of saying "Create Material" we say "Edit Material", and the action is `update` instead of `create`.  The `update` action is the only place we use the `@material` we assigned.

The `form` that we render is the exact same as the one we rendered in `new`.  This reuse is the reason we put it in a separate template file.  The only difference is that the Changeset we give it already has values for the fields, so they'll already be filled out.

Then, when the user hits the submit button, it will go to the `update` function in the `MaterialController`.

## The `update` Controller function

Once again, we'll compare what we did last chapter with the new function.

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

def update(conn, %{"id" => id, "material" => material_params}) do
  material = Trade.get_material!(id)

  case Trade.update_material(material, material_params) do
    {:ok, material} ->
      conn
      |> put_flash(:info, "Material updated successfully.")
      |> redirect(to: Routes.material_path(conn, :show, material))

    {:error, %Ecto.Changeset{} = changeset} ->
      render(conn, "edit.html", material: material, changeset: changeset)
  end
end
```

As you can see, `create` and `update` are structured very similarly.  They both destructure params, then they have a case statement where the expression is a call to the `Trade` context, and then they have success and failure conditions which match based on the same tuples.  The `success` condition is, in fact, the almost the exact same, except the message says "updated" instead of "created".  The `error` condition is similar, except it renders `edit` instead of `new`, and passes down a `material` in addition to a `changeset`.

However, despite the significant similarities, there are some important differences.

First, in `update`, we're working with a pre-existing material, so we match the `"id"` parameter, then use that to get the material (`Trade.get_material!(id)`), and feed that material into `Trade.update_material(material, material_params)`.

The other major difference is hidden in `Trade.update_material`, so let's look at that.

```elixir
def create_material(attrs \\ %{}) do
  %Material{}
  |> Material.changeset(attrs)
  |> Repo.insert()
end

def update_material(%Material{} = material, attrs) do
  material
  |> Material.changeset(attrs)
  |> Repo.update()
end
```

As you can see, we're working with the pre-existing material, instead of a blank `%Material{}` Schema.  Then we pass it into the changeset with the new attributes, as before.  Then, instead of inserting a new database record, we update the existing database record.

## Conclusion

As promised, this was much shorter than the previous chapter.  Instead of learning all new concepts, we only had to repurpose what we'd already learned.

The biggest difference is that we were working with an already-existing material, so from the start our Changeset had valid data.

## Exercises

Let's test some edge cases.

1. In `update`, feed `Trade.update_material` an empty `%Material{}` instead of the material from the database for the first argument.  What errors occur?  Why?
2. In `update`, feed `Trade.update_material` an empty `%{}` instead of the material_params from the POST call for the second argument.  What errors occur?  Why?
3. In `edit`, feed `Trade.change_material` an empty `%Material{}` instead of the material from the database.  Leave everything else the same.  What errors occur?  Why? 

<!--
1: 

Ecto.NoPrimaryKeyValueError at PUT /materials/4
struct `%StarTracker.Trade.Material{__meta__: #Ecto.Schema.Metadata<:built, "materials">, amount: nil, id: nil, inserted_at: nil, name: nil, price: nil, updated_at: nil}` is missing primary key value

2: It won't give you an error... it just doesn't update

3: It will show a blank fieldset, then when submitted it will give "no route found for POST /materials/4"
-->