{% docs __overview__ %}

## Data Documentation for Jaffle Shop

### Models

#### Naming Conventions

<!-- prettier-ignore -->
- stg_[source]__[entity]s.sql - the double underscore between source system and entity helps visually distinguish the separate parts in the case of a source name having multiple words. For instance, google_analytics__campaigns is always understandable, whereas to somebody unfamiliar google_analytics_campaigns could be analytics_campaigns from the google source system as easily as campaigns from the google_analytics source system. Think of it like an oxford comma, the extra clarity is very much worth the extra punctuation.

- **Plural**. SQL, and particularly SQL in dbt, should read as much like prose as we can achieve. We want to lean into the broad clarity and declarative nature of SQL when possible. As such, unless there’s a single order in your orders table, plural is the correct way to describe what is in a table with multiple rows.

#### Staging

- Data flows from "raw" tables into the staging area. Subdirectories should be based on the **source** system. Our internal jaffle shop transactional database is one system, the data we get from Stripe's API is another. We've found this to be the best grouping for most companies, as source systems tend to share similar loading methods and properties between tables, and this allows us to operate on those similar sets easily.

- Staging models are the only place we'll use the source macro, and our staging models should have a 1-to-1 relationship to our source tables. That means for each source system table we’ll have a single staging model referencing it, acting as its entry point — staging it — for use downstream. Staging models help us keep our code DRY. For instance, if we know we always want our monetary values as floats in dollars, but the source system is integers and cents, we want to do the division and type casting as early as possible so that we can reference it rather than redo it repeatedly downstream. Once a source has been defined, it can be referenced from a model using the {{ source()}} function.

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
