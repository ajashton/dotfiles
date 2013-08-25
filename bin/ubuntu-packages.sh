distrib_supported=(raring)

apt_sources=(
    # these should be source lines as understood by `apt-add-repository`
    ppa:mapnik/nightly-trunk
    "'deb http://qgis.org/debian $DISTRIB_CODENAME main'"
)

apt_packages=(

    ## Basic utils
    curl
    htop
    most
    tmux
    ubuntuone-control-panel-qt
    xclip

    ## Basic dev
    vim
    exuberant-ctags
    meld

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
    libjemalloc1
    libmapnik
    libmapnik-dev
    postgresql
    postgresql-contrib
    postgis
    protobuf-compiler
    python-unidecode
    s3cmd

    ## Desktop GIS
    libreoffice-base  # enables DBF support in Calc
    qgis

)
