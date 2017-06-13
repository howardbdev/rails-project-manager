# Specifications for the Rails Assessment

Specs:
- [x] Using Ruby on Rails for the project

  -self explanatory

- [x] Include at least one has_many relationship (x has_many y e.g. User has_many Recipes)

    -user has many pet_projects

- [x] Include at least one belongs_to relationship (x belongs_to y e.g. Post belongs_to User)

    -note belongs to author

- [x] Include at least one has_many through relationship (x has_many y through z e.g. Recipe has_many Items through Ingredients)

    -Projects have many tools through ProjectTools

- [x] The "through" part of the has_many through includes at least one user submittable attribute (attribute_name e.g. ingredients.quantity)

    -not sure if this requirement is actually met.. "through" parts include ProjectTools and Assignments, neither of which have submittable attributes, but it didn't seem to fit the app..

- [x] Include reasonable validations for simple model objects (list of model objects with validations e.g. User, Recipe, Ingredient, Item)

    -Every model comes with appropriate validations

- [x] Include a class level ActiveRecord scope method (model object & class method name and URL to see the working feature e.g. User.most_recipes URL: /users/most_recipes)

    -busiest worker page shows busiest worker (most project assignments) and busiest project owner (owns the most projects)

- [x] Include a nested form writing to an associated model using a custom attribute writer (form URL, model name e.g. /recipe/new, Item)

    -Tools attributes is a custom builder in the Project class

- [x] Include signup (how e.g. Devise)
- [x] Include login (how e.g. Devise)
- [x] Include logout (how e.g. Devise)

    -login/logout paths, all custom authentication and authorization

- [x] Include third party signup/login (how e.g. Devise/OmniAuth)

    -OmniAuth via Facebook

- [x] Include nested resource show or index (URL e.g. users/2/recipes)

    -users/:id/projects, for example

- [x] Include nested resource "new" form (URL e.g. recipes/1/ingredients)

    -users/:id/projects/new, for example

- [x] Include form display of validation errors (form URL e.g. /recipes/new)

    -flash is utilized to display alerts, errors, and notices any time a change is made or an error occurs

Confirm:
- [x] The application is pretty DRY

    -used partials where possible, cleaned up coce and routes
- [x] Limited logic in controllers

    -logic in controllers is limited to checking for successful operations and redirecting/supplying messages as appropriate
- [x] Views use helper methods if appropriate

    -? did not build any view helpers ... all methods went into models or application controller
- [x] Views use partials if appropriate

    -used a bunch of partials
