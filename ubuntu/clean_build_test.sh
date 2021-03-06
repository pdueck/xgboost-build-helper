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
cmake .. -DUSE_CUDA=ON -DUSE_NCCL=ON -DGOOGLE_TEST=ON -DUSE_AVX=ON 
make -j4
cd ..
cd python-package/
python setup.py install
cd ..
python -m nose tests/python-gpu
testxgboost
