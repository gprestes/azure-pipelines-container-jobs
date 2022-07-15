FROM node:10-alpine

RUN apk add --no-cache --virtual .pipeline-deps readline linux-pam \
  && apk add bash sudo shadow \
  && apk del .pipeline-deps

LABEL "com.azure.dev.pipelines.agent.handler.node.path"="/usr/local/bin/node"

# This label allows the image to be linked back to the repository
LABEL org.opencontainers.image.source https://github.com/flcdrg/azure-pipelines-container-jobs

CMD [ "node" ]