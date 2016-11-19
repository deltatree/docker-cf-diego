# CloudFoundry + Diego
# version 0.0.1
FROM bosh/bosh-lite:9000.131.0
MAINTAINER Alexander Widak <alexander.widak@deltatree.de>

ENV CF_RELEASE_BRANCH v247

RUN apt update && apt -y install git
RUN mkdir -p /root/workspace && cd /root/workspace
RUN git clone -b ${CF_RELEASE_BRANCH} https://github.com/cloudfoundry/cf-release.git cf-release
RUN cd /root/workspace/cf-release
RUN ./scripts/update
