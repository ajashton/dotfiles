distrib_supported=(raring)

apt_sources=(
    # these should be source lines as understood by `apt-add-repository`
    ppa:mapnik/nightly-trunk
    "deb http://qgis.org/debian $DISTRIB_CODENAME main"
)

apt_packages=(

    ## basic utils
    curl
    htop
    most
    xclip

    ## development
    vim
    exuberant-ctags
    meld

    ## web / chat
    irssi

    ## graphics
    gcolor2
    gimp
    inkscape
    optipng
    pngquant

    ## MapBox dev
    libjemalloc1
    libmapnik
    libmapnik-dev
    postgresql
    postgresql-contrib
    postgis
    protobuf-compiler
    python-unidecode
    s3cmd

    ## desktop GIS
    libreoffice-base  # enables DBF support in Calc
    qgis

)
