# rbenv
git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.profile
# export PATH="$HOME/.rbenv/bin:$PATH"
echo 'eval "$(rbenv init -)"' >> ~/.profile
# eval "$(rbenv init -)"
source ~/.profile
# exec $SHELL -l

# ruby-build
git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build

# ruby
rbenv install 2.0.0-p247
rbenv global 2.0.0-p247
rbenv rehash

# disable gem docs installation
touch ~/.gemrc
echo 'install: --no-rdoc --no-ri' >> ~/.gemrc
echo 'update: --no-rdoc --no-ri' >> ~/.gemrc

# rails
gem install rails
rbenv rehash
