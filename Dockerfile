FROM opensuse:tumbleweed
RUN zypper ar -f http://download.opensuse.org/repositories/YaST:/Head/openSUSE_Tumbleweed/ yast

# we need to install Ruby first to define the %{rb_default_ruby_abi} RPM macro
# see https://docs.docker.com/engine/userguide/eng-image/dockerfile_best-practices/#run
# https://docs.docker.com/engine/userguide/eng-image/dockerfile_best-practices/#/build-cache
# why we need "zypper clean -a" at the end
RUN zypper --gpg-auto-import-keys --non-interactive in --no-recommends \
  ruby && zypper clean -a

RUN RUBY_VERSION=`rpm --eval '%{rb_default_ruby_abi}'` && \
  zypper --gpg-auto-import-keys --non-interactive in --no-recommends \
  aspell-en \
  fdupes \
  git \
  grep \
  rpm-build \
  update-desktop-files \
  which \
  screen \
  "rubygem($RUBY_VERSION:fast_gettext)" \
  "rubygem($RUBY_VERSION:gettext)" \
  "rubygem($RUBY_VERSION:raspell)" \
  "rubygem($RUBY_VERSION:rspec)" \
  "rubygem($RUBY_VERSION:rubocop)" \
  "rubygem($RUBY_VERSION:simplecov)" \
  "rubygem($RUBY_VERSION:yard)" \
  "rubygem($RUBY_VERSION:yast-rake)" \
  autoconf \
  automake \
  bison \
  boost-devel \
  cmake \
  dejagnu \
  docbook-xsl-stylesheets \
  doxygen \
  flex \
  gcc-c++ \
  libtool \
  libxslt \
  obs-service-source_validator \
  ruby-devel \
  sgml-skel \
  yast2-devtools \
  yast2-core-devel \
  yast2-devtools \
  hwinfo-devel \
  yast2-ycp-ui-bindings-devel \
  && zypper clean -a
COPY yast-travis-cpp /usr/local/bin/
ENV LC_ALL=en_US.UTF-8
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# run some smoke tests to make sure there is no serious issue with the image
RUN /usr/lib/YaST2/bin/y2base --help
RUN c++ --version
RUN rake -r yast/rake -V
