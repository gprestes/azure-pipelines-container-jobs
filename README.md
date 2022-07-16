# Azure Pipelines Container Jobs

Demonstration of using Azure Pipelines Container Jobs

The first job (which runs inside a `ubuntu:22.04` container) is used to build a custom Docker image.

To improve performance, the `docker build` step makes use of the `--cache-from` argument.

The second job runs inside a container using the custom image created by the first job.
