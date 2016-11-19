# CloudFoundry + Diego
# version 0.0.1
FROM bosh/bosh-lite:9000.131.0
MAINTAINER Alexander Widak <alexander.widak@deltatree.de>

ENV CF_RELEASE_BRANCH v247

RUN apt -y update && apt -y upgrade && apt -y install git
RUN mkdir -p /root/workspace && cd /root/workspace && git clone -b ${CF_RELEASE_BRANCH} https://github.com/cloudfoundry/cf-release.git cf-release
RUN cd /root/workspace/cf-release && ./scripts/update
RUN apt -y install git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev
RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
RUN cd /root/workspace/cf-release && curl -sSL https://get.rvm.io | bash -s stable && source /usr/local/rvm/scripts/rvm && rvm install ruby-2.3.1 && rvm use 2.3.1 --default && gem install bundler && rbenv rehash
RUN cd /root/workspace/cf-release && ./scripts/generate-bosh-lite-dev-manifest && ./scripts/deploy-dev-release-to-bosh-lite
