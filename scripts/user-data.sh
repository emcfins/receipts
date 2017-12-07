#!/bin/bash
apt-get -y update && apt-get install -y python-setuptools python-dev build-essential
easy_install pip
pip install --upgrade pip
pip install tesseract pytesseract Pillow awscli
apt-get remove -y tesseract-ocr* libleptonica-dev
apt-get -y autoclean
apt-get -y autoremove --purge
apt-get install -y autoconf automake libtool autoconf-archive pkg-config libpng12-dev libjpeg8-dev libtiff5-dev zlib1g-dev libicu-dev libpango1.0-dev libcairo2-dev
wget -O /tmp/leptonica-1.74.4.tar.gz http://www.leptonica.com/source/leptonica-1.74.4.tar.gz
wget -O /tmp/3.05.00.tar.gz https://github.com/tesseract-ocr/tesseract/archive/3.05.00.tar.gz
cd /tmp
tar xfvz leptonica-1.74.4.tar.gz
cd leptonica-1.74.4/
./configure
make
make install
cd /tmp
tar xfvz 3.05.00.tar.gz
cd tesseract-3.05.00/
./autogen.sh
./configure --enable-debug
LDFLAGS="-L/usr/local/lib" CFLAGS="-I/usr/local/include" make
make install
make install-data
ldconfig
wget -O /usr/local/share/tessdata/eng.traineddata https://github.com/tesseract-ocr/tessdata/raw/3.04.00/eng.traineddata
wget -O /usr/local/share/tessdata/osd.traineddata https://github.com/tesseract-ocr/tessdata/raw/3.04.00/osd.traineddata
wget -O /usr/local/share/tessdata/eng.cube.bigram https://github.com/tesseract-ocr/tessdata/raw/3.04.00/eng.cube.bigram
wget -O /usr/local/share/tessdata/eng.cube.fold https://github.com/tesseract-ocr/tessdata/raw/3.04.00/eng.cube.fold
wget -O /usr/local/share/tessdata/eng.cube.lm https://github.com/tesseract-ocr/tessdata/raw/3.04.00/eng.cube.lm
wget -O /usr/local/share/tessdata/eng.cube.nn https://github.com/tesseract-ocr/tessdata/raw/3.04.00/eng.cube.nn
wget -O /usr/local/share/tessdata/eng.cube.params https://github.com/tesseract-ocr/tessdata/raw/3.04.00/eng.cube.params
wget -O /usr/local/share/tessdata/eng.cube.size https://github.com/tesseract-ocr/tessdata/raw/3.04.00/eng.cube.size
wget -O /usr/local/share/tessdata/eng.cube.word-freq https://github.com/tesseract-ocr/tessdata/raw/3.04.00/eng.cube.word-freq
wget -O /usr/local/share/tessdata/eng.tesseract_cube.nn https://github.com/tesseract-ocr/tessdata/raw/3.04.00/eng.tesseract_cube.nn

