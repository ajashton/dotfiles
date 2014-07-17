distrib_supported=(raring)

apt_sources=(
    # these should be source lines as understood by `apt-add-repository`
    ppa:developmentseed/mapbox-streets
    ppa:mapnik/nightly-trunk
    ppa:mizuno-as/silversearcher-ag
    ppa:snwh/moka-icon-theme-daily
    ppa:yorba/ppa
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
    ubuntuone-control-panel-qt
    ubuntuone-client-gnome  # file manager integration, etc
    unrar
    xclip

    ## Basic dev
    autoconf
    clang
    vim-gnome  # gnome version provides clipboard support, even in terminal
    exuberant-ctags
    meld

    ## Desktop
    font-roboto
    geary

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
    #postgresql-9.1-postgis
    postgresql-contrib
    postgresql-plpython
    postgresql-server-dev-9.1
    protobuf-compiler
    python-magic  # for s3cmd filetype detection
    python-mapnik
    python-psycopg2
    python-unidecode
    ruby-rdiscount  # alternative Markdown parser for jekyll
    s3cmd

    ## Desktop GIS
    libreoffice-base  # enables DBF support in Calc
    qgis

    ## Misc
    moka-icon-theme-dark

)
