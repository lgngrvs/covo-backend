brew services stop mysql
brew uninstall mysql
rm -rf /opt/homebrew/var/mysql/
brew install mysql
brew services start mysql