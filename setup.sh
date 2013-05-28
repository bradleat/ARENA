#Use at your own RISK!!!
#Here is some simple setup for Ubuntu 12.04
#We just grab the Node v0.10.8 and install it
#Then we grab Couchbase v2.0.1 and install it
#It may take a bit
echo "Starting..."
mkdir setup
cd setup
wget http://nodejs.org/dist/v0.10.8/node-v0.10.8.tar.gz

tar -zxf node-v0.10.8.tar.gz
cd node-v0.10.8
./configure && make && sudo make install

echo "Done, Cleaning Up"
cd ..
sudo rm -rf setup
echo "All Clean!"
sudo wget -O/etc/apt/sources.list.d/couchbase.list http://packages.couchbase.com/ubuntu/couchbase-ubuntu1204.list
sudo apt-get update
sudo apt-get install libcouchbase2 libcouchbase-dev

sudo npm install --unsafe-perm
