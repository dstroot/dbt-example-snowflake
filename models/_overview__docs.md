{% docs __overview__ %}

# Welcome!

Welcome to the auto-generated documentation for your dbt project!

# Navigation

You can use the Project and Database navigation tabs on the left side of the window to explore the models in your project.

## Project Tab

The Project tab mirrors the directory structure of your dbt project. In this tab, you can see all of the models defined in your dbt project, as well as models imported from dbt packages.

## Database Tab

The Database tab also exposes your models, but in a format that looks more like a database explorer. This view shows relations (tables and views) grouped into database schemas. Note that ephemeral models are not shown in this interface, as they do not exist in the database.

# Graph Exploration

You can click the blue icon on the bottom-right corner of the page to view the lineage graph of your models.

On model pages, you'll see the immediate parents and children of the model you're exploring. By clicking the Expand button at the top-right of this lineage pane, you'll be able to see all of the models that are used to build, or are built from, the model you're exploring.

Once expanded, you'll be able to use the --select and --exclude model selection syntax to filter the models in the graph. For more information on model selection, check out the dbt docs.

Note that you can also right-click on models to interactively filter and explore the graph.

---

# More information

[What is dbt?](https://docs.getdbt.com/docs/introduction)
Read the [dbt viewpoint](https://docs.getdbt.com/docs/viewpoint)
[Installation](https://docs.getdbt.com/docs/installation)
[Join the dbt Community](https://www.getdbt.com/community/) for questions and discussion

---

### Models

#### Naming Conventions

- **`stg_[source]__[entity]s.sql`** - the double underscore between source system and entity helps visually distinguish the separate parts in the case of a source name having multiple words. For instance, google_analytics__campaigns is always understandable, whereas to somebody unfamiliar google_analytics_campaigns could be analytics_campaigns from the google source system as easily as campaigns from the google_analytics source system. Think of it like an oxford comma, the extra clarity is very much worth the extra punctuation.

- **Plural**. SQL, and particularly SQL in dbt, should read as much like prose as we can achieve. We want to lean into the broad clarity and declarative nature of SQL when possible. As such, unless there’s a single order in your orders table, plural is the correct way to describe what is in a table with multiple rows.

#### Staging

- Data flows from "raw" tables into the staging area. Subdirectories should be based on the **source** system. Our internal jaffle shop transactional database is one system, the data we get from Stripe's API is another. We've found this to be the best grouping for most companies, as source systems tend to share similar loading methods and properties between tables, and this allows us to operate on those similar sets easily.

- Staging models are a key place we'll use the source macro, and our staging models should have a 1-to-1 relationship to our source tables. That means for each source system table we’ll have a single staging model referencing it, acting as its entry point — staging it — for use downstream. Staging models help us keep our code DRY. For instance, if we know we always want our monetary values as floats in dollars, but the source system is integers and cents, we want to do the division and type casting as early as possible so that we can reference it rather than redo it repeatedly downstream. Once a source has been defined, it can be referenced from a model using the "source" function. Pro tip: We can also use "sources" to apply data quality rules to tables already in our data warehouse.

- The most standard types of staging model transformations are:

  - ✅ Renaming
  - ✅ Type casting
  - ✅ Basic computations (e.g. cents to dollars)
  - ✅ Categorizing (using conditional logic to group values into buckets or booleans, such as in the case when statements above)

#### Tables vs. Views

Raw data has to flow into a table. Staging tables are materialized as views. Looking at a partial view of our dbt_project.yml below, we can see that we’ve configured the entire staging directory to be materialized as views. As they’re not intended to be final artifacts themselves, but rather building blocks for later models, staging models should typically be materialized as views for two key reasons:

1. Any downstream model (discussed more in marts) referencing our staging models will always get the freshest data possible from all of the component views it’s pulling together and materializing

2. It avoids wasting space in the warehouse on models that are not intended to be queried by data consumers, and thus do not need to perform as quickly or efficiently

{% enddocs %}