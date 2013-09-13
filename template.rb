# ======================================================================
#
# Rails Template
#
# © 2013, Akiva Levy <akiva@sixthirteen.co>
# https://github.com/akiva/rails-template
# http://sixthirteen.co
#
# The purpose of this template is to automate the creation of new Rails
# projects according to my preferences.
#
# ======================================================================

# ----------------------------------------------------------------------
# Gemfile
# ----------------------------------------------------------------------

# Include the jQuery UI library
gem 'jquery-ui-rails'

# Use the excellent simple-navigation gem for easier app navigation
gem 'simple-navigation' if yes?('Use simple-navigation?')

# Use the New Relic analytics solution
gem 'newrelic_rpm' if yes?('Do you want to use New Relic?')

# Segment.io as an analytics solution
# https://github.com/segmentio/analytics-ruby
gem 'analytics-ruby'

# For encrypted password
gem 'bcrypt-ruby'

# Useful Sass mixins (http://bourbon.io/)
gem 'bourbon'

# Neat library for Bourbon
gem 'neat'

# Mongoid MongoDB driver
gem 'mongoid', github: 'mongoid/mongoid' if yes?('Will you be using Mongoid?')

# Slim templating language (http://slim-lang.com)
gem 'slim-rails'

gem_group :development do
  gem 'thin'
  gem 'pry-rails'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'meta_request'
  gem 'bullet'
  gem 'capistrano'
end

gem_group :development, :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
end

gem_group :test do
  gem 'mongoid-rspec' if yes?('Will you be using Mongoid with RSpec?')
  gem 'database_cleaner'
  gem 'email_spec'
  gem 'timecop'
  gem 'faker'
  gem 'capybara'
  #gem 'capybara-webkit'
  gem 'simplecov', require: false
end

gem_group :production do
  gem 'puma'
end

# Remove first :doc group
run "sed -i '/^group :doc/,/end/d' Gemfile"

# Re-insert :doc group to keep Gemfile pretty
gem_group :doc do
  gem 'sdoc', require: false
end

# Remove CoffeeScript Gem
run "sed -i '/coffee-rails/d' Gemfile"

# Remove all comments
run "sed -i '/^#/d' Gemfile"

# Change all quotes
gsub_file 'Gemfile', '"', "'"

# remove empty lines
run "sed -i '/^$/d' Gemfile"

# Insert empty lines before any group declarations
gsub_file('Gemfile', /^(group.*)$/, "\n\\1")


# ----------------------------------------------------------------------
# Misc
# ----------------------------------------------------------------------

# ----------------------------------------------------------------------
# Assets
# ----------------------------------------------------------------------

# Use Sass for application.css
run 'mv app/assets/stylesheets/application.css app/assets/stylesheets/application.css.sass'

# Remove the require_tree directives from the SASS and JavaScript files.
# It's better design to import or require things manually.
run "sed -i '/require_tree/d' app/assets/javascripts/application.js"
run "sed -i '/require_tree/d' app/assets/stylesheets/application.css.sass"

# Empty out the application.css.sass file
# Add Bourbon and Neat to stylesheet file
#@import font-awesome
#@import fontawesome-icon
run "echo '@import bourbon' >  app/assets/stylesheets/application.css.sass"
run "echo '@import neat' >>  app/assets/stylesheets/application.css.sass"

# ----------------------------------------------------------------------
# Git
# ----------------------------------------------------------------------

# Ignore rails doc files, Vim/Emacs swap files, .DS_Store, and more
run "cat << EOF > .gitignore
/.bundle
/db/*.sqlite3*
/log/*.log
/tmp
config/*.yml
*.swp
*~
.project
.idea
.DS_Store
coverage
EOF"

# Initialize repository
git :init
git add: "."
git commit: %Q{ -m 'Initial commit' }

#if yes?("Initialize GitHub repository?")
#  git_uri = `git config remote.origin.url`.strip
#  unless git_uri.size == 0
#    say "Repository already exists:"
#    say "#{git_uri}"
#  else
#    username = ask "What is your GitHub username?"
#    run "curl -u #{username} -d '{\"name\":\"#{app_name}\"}' https://api.github.com/user/repos"
#    git remote: %Q{ add origin git@github.com:#{username}/#{app_name}.git }
#    git push: %Q{ origin master }
#  end
#end
