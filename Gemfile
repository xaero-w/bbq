source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.7.1"

gem "bootsnap", ">= 1.4.2", require: false
gem "carrierwave"
gem "devise"
gem "devise-i18n"
gem "fog-aws"
gem "listen", "~> 3.2"
gem "jquery-rails"
gem "rails-i18n"
gem "rails", "~> 6.0.3", ">= 6.0.3.2"
gem "rmagick"
gem "twitter-bootstrap-rails"
gem "uglifier"
gem "webpacker", "~> 4.0"

group :production do
  gem "pg"
end

group :development, :test do
  gem "sqlite3", "~> 1.4"
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
end
