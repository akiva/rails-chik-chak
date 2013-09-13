# Rails Template

My Rails 4 project template, configured to suit my preferences.

## Overview

The following template provides many of the often-used settings,
alterations, Gemfiles, etc. that I use for new Ruby on Rails projects.

While some of these features are cosmetic (such as "beautifying" the
Gemfile), many ease implementing best practices and security
enhancements, while others are just plain sensible defaults.

## Usage

Generally, you would create a new app in the usual way:

    rails new {app_name} -m https://raw.github.com/akiva/rails-template/master/template.rb

Although, I often omit Active Record and MiniTest:

    rails new {app_name} -O -T -m https://raw.github.com/akiva/rails-template/master/template.rb

## Areas of Concern

### Gemfile

The generated Gemfile is not only re-organised and tidied up, but
includes the following Gems:

- [analytics-ruby][1] (global)
- [bcrypt-ruby][2] (global)
- [bourbon][3] (global)
- [simple-navigation][23] (global)
- [slim-rails][4] (global)
- [mongoid][24] (possible global)
- [thin][5] (development)
- [pry-rails][6] (development)
- [better\_errors][7] (development)
- [binding\_of\_caller][8] (development)
- [meta\_request][9] (development)
- [bullet][10] (development)
- [capistrano][18] (development)
- [rspec-rails][11] (development, test)
- [factory\_girl\_rails][12] (development, test)
- [mongoid-rspec][25] (possible test)
- [database\_cleaner][13] (test)
- [email\_spec][19] (test)
- [capybara][14] (test)
- [timecop][15] (test)
- [faker][16] (test)
- [simplecov][20] (test)
- [puma][17] (production)

## Misc

Further changes and customizations will be explained here.

## Reads of interest

Documentation on Rails templates:

- <http://guides.rubyonrails.org/rails_application_templates.html>
- <http://guides.rubyonrails.org/generators.html#application-templates>
- <https://github.com/rails/rails/blob/master/guides/source/rails_application_templates.md>

Similar projects:

- <https://github.com/lab2023/rails-template>
- <https://github.com/dockyard/sail_plan/blob/master/template.rb>
- <https://github.com/thoughtbot/suspenders>

RSpec changes:

- <http://myronmars.to/n/dev-blog/2012/06/rspecs-new-expectation-syntax>
- <http://myronmars.to/n/dev-blog/2013/07/the-plan-for-rspec-3#what_about_the_old_expectationmock_syntax>

## TODO

- Set Puma to act as the local development server as well
- Remove favicon
- Move/rename README
- Remove any content from `app/assets/stylesheets/application.css.sass`
- Add `import bourbon` to `app/assets/stylesheets/application.css.sass`
- Add `//= require jquery.ui.all` to `app/assets/javascripts/application.js`
- Remove `app/views/layouts/application.html.erb`
- Add `app/views/layouts/application.html.slim`
- Update `config/routes.rb`
- Update `config/environments/*.rb`
- Update `config/initializers/*.rb`
- Update `config/application.rb`
- Update `config/environment.rb`
- Update `public/robots.txt`
- Check for any `config/environments/*.rb` settings that may need
  altering
- Run any commands for Gem initializers:
  - `rails g rspec:install` (although, perhaps it's easier to copy over
    template files
  - `rails g mongoid:config` if running Mongoid
- Create any useful/required, custom initializers
  - https://segment.io/libraries/ruby
  - `slim.rb`
  - `action_mailer.rb`
  - `bullet.rb` (although, perhaps this is better suited within the
    `config/environments/development.rb` file
  - `filter\_parameter\_loggin.rb` (add `:password\_confirmation`)
- Create example `config/*.yml.example` files:
  - `mongoid.yml`
  - `database.yml`
  - `newrelic.yml`
  - `smtp.yml`
  - etc.
- Add fonts to the assets pipeline (`config/application.rb`):

        # Add fonts to asset pipeline
        config.assets.paths << Rails.root.join('app', 'assets', 'fonts')
- Customize generators within `config/application.rb`:

        config.generators do |generate|
          generate.helper false
          generate.assets false
          generate.view_specs false
          generate.stylesheet_engine = :sass
        end
- Re-enable authenticity token for XHR / remote forms in
  `config/application.rb`:

        config.action_view.embed_authenticity_token_in_remote_forms = true
- Add `.rspec`
- Add `README.md` boilerplate
- Reconfigure RSpec `spec_helper.rb`
- Add RSpec support files
- Add [poltergeist][21] to Gemfile
- Add [capybara-email][22] to Gemfile
- Add simple-navigation `config/navigation.rb`

[1]: https://github.com/segmentio/analytics-ruby
[2]: http://bcrypt-ruby.rubyforge.org/
[3]: https://github.com/thoughtbot/bourbon
[4]: https://github.com/slim-template/slim-rails
[5]: http://code.macournoyer.com/thin/
[6]: https://github.com/rweng/pry-rails
[7]: https://github.com/charliesome/better_errors
[8]: https://github.com/banister/binding_of_caller
[9]: https://github.com/dejan/rails_panel/tree/master/meta_request
[10]: https://github.com/flyerhzm/bullet
[11]: https://github.com/rspec/rspec-rails
[12]: https://github.com/thoughtbot/factory_girl_rails
[13]: https://github.com/bmabey/database_cleaner
[14]: https://github.com/jnicklas/capybara
[15]: https://github.com/travisjeffery/timecop
[16]: http://faker.rubyforge.org/
[17]: http://puma.io/
[18]: https://github.com/capistrano/capistrano
[19]: https://github.com/bmabey/email-spec
[20]: https://github.com/colszowka/simplecov
[21]: https://github.com/jonleighton/poltergeist
[22]: https://github.com/DockYard/capybara-email
[23]: https://github.com/andi/simple-navigation
[24]: http://mongoid.org/en/mongoid/
[25]: https://github.com/evansagge/mongoid-rspec
