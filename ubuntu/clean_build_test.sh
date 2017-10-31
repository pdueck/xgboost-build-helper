set -e
rm -rf xgboost
#Repo
if [ "$1" != "" ]; then
        git clone $1 --recursive
else
        git clone https://github.com/RAMitchell/xgboost.git --recursive
fi
cd xgboost
#Branch
if [ "$2" != "" ]; then
        git checkout $2
fi
#cmake
mkdir build && cd build
cmake .. -DPLUGIN_UPDATER_GPU=ON -DJVM_BINDINGS:BOOL=ON
make -j4
cd ..
cd python-package/
python setup.py install
cd ..
python -m nose tests/python-gpu