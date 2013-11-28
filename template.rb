# ======================================================================
#
# Rails Chik Chak, a Ruby on Rails application template
#
# © 2013, Akiva Levy <akiva@sixthirteen.co>
# https://github.com/akiva/rails-template
# http://sixthirteen.co
#
# The purpose of this template is to automate the creation of new
# Rails 4.0.x projects according to my tastes and preferences.
#
# ======================================================================

# Configuration files
if yes?('Are you running this template with a local copy of the files?')
  @path = "#{File.expand_path(File.dirname(__FILE__))}/resources/"
else
  @path = 'https://raw.github.com/akiva/rails-chik-chak/master/files/'
end

# Options hash to keep track of desired preferences
options = {
  simple_navigation: false,
  mongoid: false,
  new_relic: false,
  github: false
}

if yes?('Would you like to use Simple Navigation? (yes/no)')
  options[:simple_navigation] = true
end

if yes?('Would you like to Mongoid? (yes/no)')
  options[:mongoid] = true
end

if yes?('Would you like to use New Relic for monitoring? (yes/no)')
  options[:new_relic] = true
end

if yes?('Would you like to initialize a GitHub repository? (yes/no)')
  options[:github] = true
end

# ----------------------------------------------------------------------
# Gemfile
# ----------------------------------------------------------------------

# Include the jQuery UI library
gem 'jquery-ui-rails'

# Use the excellent simple-navigation gem for easier app navigation
gem 'simple-navigation' if options[:simple_navigation]

# Use the New Relic analytics solution
gem 'newrelic_rpm' if options[:new_relic]

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
gem 'mongoid', github: 'mongoid/mongoid' if options[:mongoid]

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
  gem 'mongoid-rspec' if options[:mongoid]
  gem 'database_cleaner'
  gem 'capybara-email'
  gem 'email_spec'
  gem 'timecop'
  gem 'faker'
  gem 'capybara'
  gem 'poltergeist'
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

# Remove all comments and empty lines
run "sed -i '/^\\\( *#.*\\\)*\\\( *\\\)$/d' Gemfile"

# Change all quotes
gsub_file 'Gemfile', '"', "'"

# Insert empty lines before any group declarations
gsub_file('Gemfile', /^(group.*)$/, "\n\\1")

# Insert Ruby 2.0.0 dependency into Gemfile
inject_into_file 'Gemfile',
  before: "gem 'rails', '4.0.0'" do <<-RUBY
ruby '2.0.0'

RUBY
end

# Run Bundler to install Gems (allowing us to use generators, etc)
run 'bundle install'

# ----------------------------------------------------------------------
# Generators
# ----------------------------------------------------------------------

generate('rspec:install')
generate('mongoid:config') if options[:mongoid]

if options[:simple_navigation]
  # Create our slimmed down default navigation.rb file. We are doing
  # this manually, as opposed to generating the config file here,
  # because the generator produces a file with uninitialized variables
  # (for the sake of example).
  get @path + 'config/navigation.rb', 'config/navigation.rb'
end

# ----------------------------------------------------------------------
# Initializers
# ----------------------------------------------------------------------

# Add :password_confirmation to be removed from logs
gsub_file 'config/initializers/filter_parameter_logging.rb',
  /:password/,
  ':password, :password_confirmation'

# Create our action_mailer initializer
create_file 'config/initializers/action_mailer.rb' do <<-'CONFIG'
unless Rails.env == 'test'
  config_file = "#{Rails.root}/config/smtp.yml"
  # ActionMailer::Base.delivery_method = :smtp
  if File.exists? config_file
    ActionMailer::Base.smtp_settings = YAML.load_file(config_file)[Rails.env].symbolize_keys!
  end
end
CONFIG
end

# Set up a custom attribute for 'role' for Slim view templates
create_file 'config/initializers/slim.rb' do <<-CONFIG
Slim::Engine.set_default_options shortcut: { '@' => { attr: 'role'},
                                             '#' => { attr: 'id' },
                                             '.' => { attr: 'class' }}
CONFIG
end


# ----------------------------------------------------------------------
# Configuration files
# ----------------------------------------------------------------------

run 'mkdir spec/features'
remove_file 'spec/spec_helper.rb'
get @path + 'spec/spec_helper.rb', 'spec/spec_helper.rb'
get @path + 'spec/support/database_cleaner.rb',
  'spec/support/database_cleaner.rb'
get @path + 'spec/support/utilities.rb', 'spec/support/utilities.rb'
remove_file '.rspec'
get @path + 'rspec', '.rspec'

if options[:mongoid]
  get @path + 'spec/support/mongoid.rb', 'spec/support/mongoid.rb'
end

# Add fonts to the asset pipeline for production
inject_into_file 'config/environments/production.rb',
  after: '# config.assets.css_compressor = :sass' do <<-RUBY


  # Add fonts to asset pipeline
  config.assets.paths << Rails.root.join('app', 'assets', 'fonts')
RUBY
end

# Locale settings: time zone
gsub_file 'config/application.rb',
  /# config.time_zone = 'Central Time \(US & Canada\)'/,
  "config.time_zone = 'Pacific Time (US & Canada)'"

# Locale settings: language
gsub_file 'config/application.rb',
  /# config.i18n.default_locale = :de/,
  "config.i18n.default_locale = 'en-CA'"

# Customize application generators:
# - prevent helper creation, relying only on one application-wide one
# - prevent the creation of assets with each `rails generate` command
# - prevent the generation of view specs
# - prefer `.sass` to `.scss` because brevity > verbosity for markup
inject_into_file 'config/application.rb',
  after: "config.i18n.default_locale = 'en-CA'" do <<-RUBY


    config.generators do |generate|
      generate.helper false
      generate.assets false
      generate.view_specs false
      generate.stylesheet_engine = :sass
    end
RUBY
end

# Add development configuration for Bullet gem
bullet = <<-CODE
config.after_initialize do
    Bullet.enable = true
    Bullet.alert = true
    Bullet.bullet_logger = true
    Bullet.console = true
    # Bullet.growl = true
    # Bullet.xmpp = {
    #   account: 'bullets_account@jabber.org',
    #   password: 'bullets_password_for_jabber',
    #   receiver: 'your_account@jabber.org',
    #   show_online_status: true
    # }
    # Bullet.rails_logger = true
    # Bullet.airbrake = true
    # Bullet.add_footer = true
  end
CODE
environment "#{bullet}", env: 'development'

# Mail settings for Active Mailer
get @path + 'config/smtp.yml.example', 'config/smtp.yml.example'

# New Relic config file
if options[:new_relic]
  get 'https://raw.github.com/newrelic/rpm/master/newrelic.yml',
    'config/newrelic.yml'
end

# ----------------------------------------------------------------------
# View Templates
# ----------------------------------------------------------------------

# Copy over some respectable and sane Slim view templates boilerplate
remove_file 'app/views/layouts/application.html.erb'

%w[application _header _footer _messages].each do |template|
  get "#{@path}app/views/layouts/#{template}.html.slim",
    "app/views/layouts/#{template}.html.slim"

  # Change application name in view templates
  gsub_file "app/views/layouts/#{template}.html.slim",
    /APPLICATION_NAME/,
    app_name.humanize.titleize
end

# ----------------------------------------------------------------------
# Misc
# ----------------------------------------------------------------------

# Title Helper
inject_into_file 'app/helpers/application_helper.rb',
  before: 'end' do <<-'HELPER'
  def page_title(title)
    base_title = Rails.application.class.to_s.split("::").first
    if title.empty?
      base_title
    else
      "#{base_title}: #{title}"
    end
  end
HELPER
end

remove_file 'config/database.yml' if options[:mongoid]

# House-cleaning
%w{
  README.rdoc
  public/index.html
  public/favicon.ico
  app/assets/images/rails.png
}.each { |file| remove_file file }

# Insert new README
get @path + 'README.md', 'README.md'
gsub_file 'README.md', /APPLICATION_NAME/, app_name.humanize.titleize
gsub_file 'README.md', /CURRENT_YEAR/, "#{Time.new.year}"

# ----------------------------------------------------------------------
# Assets
# ----------------------------------------------------------------------

# Use Sass for application.css
remove_file 'app/assets/stylesheets/application.css'
create_file 'app/assets/stylesheets/application.css.sass' do <<-'SASS'
@import bourbon
@import neat
// @import variables
// @import mixins
// @import typography
// @import forms
// @import tables
// @import lists
// @import layout
// @import notifications
SASS
end

# ----------------------------------------------------------------------
# Default static Pages controller
# ----------------------------------------------------------------------

# run 'rails g controller pages index'
generate(:controller, 'pages index')
route "root to: 'pages#index'"

# Clean up the routes file
run "sed -i '/^\\\( *#.*\\\)*\\\( *\\\)$/d' config/routes.rb"
gsub_file 'config/routes.rb', '"', "'"

# ----------------------------------------------------------------------
# Git
# ----------------------------------------------------------------------

# Ignore rails doc files, Vim/Emacs swap files, .DS_Store, and more
remove_file '.gitignore'
create_file '.gitignore' do <<-'IGNORE'
.bundle
coverage
/db/*.sqlite3*
/log/*.log
/tmp
config/database.yml
config/mongoid.yml
config/smtp.yml
*~
*.swp
.DS_Store
.idea
.project
.rspec
IGNORE
end

# Initialize repository
git :init
git checkout: '-b develop'
git add: '.'
git commit: '-m "Initial commit"'

if options[:github]
  git_uri = `git config remote.origin.url`.strip
  unless git_uri.size == 0
    say 'Repository already exists:'
    say "#{git_uri}"
  else
    username = ask 'What is your GitHub username?'
    run "curl -u #{username} -d '{\"name\":\"#{app_name}\"}' " \
      "https://api.github.com/user/repos"
    git remote: "add origin git@github.com:#{username}/#{app_name}.git"
    git push: "origin master"
  end
end
