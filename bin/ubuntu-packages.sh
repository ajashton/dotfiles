distrib_supported=(raring)

apt_sources=(
    # these should be source lines as understood by `apt-add-repository`
    ppa:snwh/moka-icon-theme-daily
    ppa:mapnik/nightly-trunk
    ppa:mizuno-as/silversearcher-ag
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
    xclip

    ## Basic dev
    vim
    exuberant-ctags
    meld

    ## Desktop
    font-roboto

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
    libjemalloc1
    libmapnik
    libmapnik-dev
    libprotobuf-dev
    postgresql
    postgresql-contrib
    postgis
    protobuf-compiler
    python-unidecode
    ruby-rdiscount  # alternative Markdown parser for jekyll
    s3cmd

    ## Desktop GIS
    libreoffice-base  # enables DBF support in Calc
    qgis

    ## Misc
    moka-icon-theme-dark

)
