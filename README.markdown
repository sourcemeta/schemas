Welcome to Sourcemeta Schemas
=============================

This repository manages the public deployment of
[https://schemas.sourcemeta.com](https://schemas.sourcemeta.com), a public
instance of the [Sourcemeta Registry](https://github.com/sourcemeta/registry)
service offering a centralized and superior experience when browsing the world
schemas.

[**Visit Sourcemeta Schemas**](https://schemas.sourcemeta.com)

How is this different from SchemaStore?
---------------------------------------

- **We only ingest official schemas from upstream sources**. While SchemaStore
  let's community members contribute their own unofficial schemas, those are
  often not of high quality and tend to deviate over time

- **We cover more than just file formats**. While SchemaStore focuses on
  singular schemas for common file formats, we also cover ontologies and other
  kinds of more advanced schema collections

- **We guarantee high JSON Schema compliance**. Compared to SchemaStore, this
  project is maintained by a member of the JSON Schema Technical Steering
  Committee, and we pay a lot of attention to spec-compliance in terms of the
  schemas we ingest and the API layer we provide around them

- **You can self-host your own schema registry! (coming soon)** You can use the
  same micro-service we use to power this site to create your own internal
  schema registries, with the schemas of your choosing

Adding Schemas
--------------

If you want any GitHub repository of schemas included, please open a [GitHub
Issue](https://github.com/sourcemeta/schemas/issues) and we will get into it.
