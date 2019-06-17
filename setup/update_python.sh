# update python on raspberry pi

PY_VERSION="3.7.3"
PY_URL="https://www.python.org/ftp/python/${PY_VERSION}/Python-${PY_VERSION}.tgz"

TEMP_DIR="$(mktemp -d)"
CUR_DIR="$(pwd)"

if [[ ! "$TEMP_DIR" || ! -d "$TEMP_DIR" ]]; then
    echo "Could not create temp dir"
    exit 1
fi

function cleanup {
    rm -rf "$TEMP_DIR"
    echo "Deleted temp working directory $TEMP_DIR"
}

trap cleanup EXIT

echo "Going to install Python ${PY_VERSION}"
read -p "Press Enter to continue"

# install dependencies to build
sudo apt-get install build-essential tk-dev libncurses5-dev libncursesw5-dev libreadline6-dev libdb5.3-dev libgdbm-dev libsqlite3-dev libssl-dev libbz2-dev libexpat1-dev liblzma-dev zlib1g-dev checkinstall

# download python
echo "Now downloading Python $PY_VERSION"
echo "${PY_URL}"
read -p "Press Enter to continue"

cd $TEMP_DIR
wget ${PY_URL} -O ${TEMP_DIR}/python.tgz

# extract
tar -xzvf python.tgz

cd "Python-$PY_VERSION"
# configure and make
echo "Now will make and install"
read -p "Press enter to continue"

# install
./configure
make
sudo make install

cd $CUR_DIR
