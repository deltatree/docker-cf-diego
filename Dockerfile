# CloudFoundry + Diego
# version 0.0.1
FROM bosh/bosh-lite:9000.131.0
MAINTAINER Alexander Widak <alexander.widak@deltatree.de>

##################
#cf release
##################
ENV CF_RELEASE_BRANCH v247
RUN apt -y update && apt -y install git
RUN mkdir -p /root/workspace && cd /root/workspace && git clone -b ${CF_RELEASE_BRANCH} https://github.com/cloudfoundry/cf-release.git cf-release
RUN cd /root/workspace/cf-release && ./scripts/update
RUN cd /usr/local/src && wget https://cache.ruby-lang.org/pub/ruby/2.3/ruby-2.3.2.tar.gz && tar -xzf ruby-2.3.2.tar.gz && cd ruby-2.3.2 && ./configure && make install
RUN export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/var/vcap/bosh/bin
RUN gem install bundler
RUN cd /root/workspace/cf-release && bundle update && ./scripts/generate-bosh-lite-dev-manifest && ./scripts/deploy-dev-release-to-bosh-lite
RUN wget -O /usr/local/bin/spiff https://github.com/cloudfoundry-incubator/spiff/releases/download/v1.0.7/spiff_linux_amd64 && chmod 755 /usr/local/bin/spiff
