distrib_supported=(raring)

apt_sources=(
    # these should be source lines as understood by `apt-add-repository`
    ppa:mapnik/nightly-trunk
    "'deb http://qgis.org/debian $DISTRIB_CODENAME main'"
)

apt_packages=(

    ## Basic utils
    cpufrequtils
    curl
    htop
    most  # like more / less
    ranger  # command-line file manager
    silversearcher-ag  # like ack / grep
    tmux
    trash-cli
    unrar
    xclip

    ## Basic dev
    autoconf
    clang
    vim-gtk  # gui version provides clipboard support, even in terminal
    exuberant-ctags
    meld
    shellcheck

    ## Desktop
    fonts-roboto

    ## Web / chat
    chromium-browser
    irssi

    ## Graphics
    gcolor2
    gimp
    inkscape
    optipng
    pngquant

    ## MapBox / OSM dev
    jekyll
    libbz2-dev  # for building osm2pgsql
    libgeos++-dev  # for building osm2pgsql
    libjemalloc1
    libmapnik
    libmapnik-dev
    libprotobuf-dev
    postgresql
    postgresql-contrib
    postgresql-plpython
    postgresql-server-dev-9.3
    postgis
    protobuf-compiler
    python-mapnik
    python-psycopg2
    python-unidecode
    ruby-rdiscount  # alternative Markdown parser for jekyll

    ## Desktop GIS
    libreoffice-base  # enables DBF support in Calc
    qgis

)
