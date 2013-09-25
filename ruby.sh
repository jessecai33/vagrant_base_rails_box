# rbenv
git clone https://github.com/sstephenson/rbenv.git /home/vagrant/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> /home/vagrant/.profile
export PATH="/home/vagrant/.rbenv/bin:$PATH"
echo 'eval "$(rbenv init -)"' >> /home/vagrant/.profile
eval "$(rbenv init -)"
# exec $SHELL -l

# ruby-build
git clone https://github.com/sstephenson/ruby-build.git /home/vagrant/.rbenv/plugins/ruby-build

# ruby
rbenv install 2.0.0-p247
rbenv global 2.0.0-p247
rbenv rehash

# sqlite3 for rails environment
sudo apt-get -y install sqlite3 libsqlite3-dev

# rails
# gem install rails
rbenv rehash