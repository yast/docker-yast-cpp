FROM opensuse:tumbleweed
RUN zypper ar -f http://download.opensuse.org/repositories/YaST:/Head/openSUSE_Tumbleweed/ yast
RUN zypper --gpg-auto-import-keys --non-interactive in --no-recommends \
  aspell-en \
  fdupes \
  git \
  grep \
  rpm-build \
  update-desktop-files \
  which \
  screen \
  'rubygem(fast_gettext)' \
  'rubygem(gettext)' \
  'rubygem(raspell)' \
  'rubygem(rspec)' \
  'rubygem(rubocop)' \
  'rubygem(simplecov)' \
  'rubygem(yard)' \
  'rubygem(yast-rake)' \
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
# just a smoke test, make sure YaST...
RUN /usr/lib/YaST2/bin/y2base --help
# ...and GCC work
RUN c++ --version
