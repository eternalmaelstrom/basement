# Basement

![Terraform](https://github.com/eternalmaelstrom/basement/workflows/Apply%20Infrastructure/badge.svg)


## CI/CD

Continuous integration / Continuous deployment is provided by github actions. There are two main pipelines, one for pull requests and one for merges.

> Make sure to always run ``terraform fmt -recursive`` before submitting a PR. The PR pipeline checks for formatting.

## Deploying the basement to a new AWS account for the first time
* Create a state bucket by modifying and running ``terraform apply`` in the ``tfbase`` folder.
* Update the ``terraform.tfvars`` in the ``core`` folder under the appropriate namespaces.

# Utilities

A set of utility scripts
