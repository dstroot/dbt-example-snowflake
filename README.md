# Welcome to your new dbt project!

## Using the starter project

Try running the following commands:

- dbt run
- dbt test

### Resources

- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [dbt community](http://community.getbdt.com/) to learn from other analytics engineers
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices

- [Structuring your project](https://docs.getdbt.com/guides/best-practices/how-we-structure/2-staging)
- [How to Structure Your DBT Project](https://medium.com/geekculture/how-to-structure-your-dbt-project-c62103deceb4)

## Staging data

Subdirectories should be based on the source system. Our internal transactional database is one system, the data we get from Stripe's API is another, and lastly the events from our Snowplow instrumentation. We've found this to be the best grouping for most companies, as source systems tend to share similar loading methods and properties between tables, and this allows us to operate on those similar sets easily.

## File Naming

File names. Creating a consistent pattern of file naming is crucial in dbt. File names must be unique and correspond to the name of the model when selected and created in the warehouse. We recommend putting as much clear information into the file name as possible, including a prefix for the layer the model exists in, important grouping information, and specific information about the entity or transformation in the model.

✅ stg\_[source]**[entity]s.sql - the double underscore between source system and entity helps visually distinguish the separate parts in the case of a source name having multiple words. For instance, google_analytics**campaigns is always understandable, whereas to somebody unfamiliar google_analytics_campaigns could be analytics_campaigns from the google source system as easily as campaigns from the google_analytics source system. Think of it like an oxford comma, the extra clarity is very much worth the extra punctuation.

✅ Plural. SQL, and particularly SQL in dbt, should read as much like prose as we can achieve. We want to lean into the broad clarity and declarative nature of SQL when possible. As such, unless there’s a single order in your orders table, plural is the correct way to describe what is in a table with multiple rows.
