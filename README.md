# Azure Pipelines Container Jobs

Demonstration of building and using Azure Pipelines Container Jobs

The pipeline consists of two jobs: the first builds a custom Docker image, and the second uses that image to build a .NET application.

## 'Build Image' job

Builds the image that is used by the second job.

Features the following performance optimisations:

- The `docker build` step makes use of the `--cache-from` argument.
- A PowerShell script (based on [https://gist.github.com/Myrddraal/f5a84cf3242e3b3804fa727005ed2786](https://gist.github.com/Myrddraal/f5a84cf3242e3b3804fa727005ed2786)) to skip subsequent steps if there are no changes since the last build.

## 'Use Image' job

The second job runs inside a container using the custom image created by the first job.
