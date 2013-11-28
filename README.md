# Rails Chik Chak

A [Ruby on Rails][30] 4 project template; configured to suit my
preferences.

## Overview

The following template provides many of the often-used settings,
alterations, Gemfiles, and other configurations that I prefer for new
Ruby on Rails projects.

While some of these features are cosmetic (such as "beautifying" the
Gemfile), many ease implementing best practices and security
enhancements, whilst others are just sensible defaults.

## Usage

Generally, you would create a new app in the usual way:

    rails new {app_name} -m https://raw.github.com/akiva/rails-chik-chak/master/template.rb

Although, I often omit Active Record and MiniTest:

    rails new {app_name} -O -T -m https://raw.github.com/akiva/rails-chik-chak/master/template.rb

## Areas of Concern

### Gemfile

The generated Gemfile is not only re-organised and cleaned, but includes
the following Gems:

- [analytics-ruby][1]
- [bcrypt-ruby][2]
- [better\_errors][7]
- [binding\_of\_caller][8]
- [bourbon][3]
- [bullet][10]
- [capistrano][18]
- [capybara][14]
- [database\_cleaner][13]
- [factory\_girl\_rails][12]
- [faker][16]
- [mongoid][24] (optional)
- [pry-rails][6]
- [simple-navigation][23] (optional)
- [slim-rails][4]
- [thin][5]
- [meta\_request][9]
- [rspec-rails][11]
- [mongoid-rspec][25] (optional)
- [capybara-email][19]
- [email\_spec][28]
- [timecop][15]
- [simplecov][20]
- [puma][17]
- [newrelic_rpm][26] (optional)
- [neat][27]
- [poltergeist][29]

### View Templates

A basic application layout, including header, footer, and message
notification partials are included (using the Slim templating language).

### Config Files

Various configuration files are altered:

- `spec/spec_helper.rb`

New configuration files are created:

- `spec/support/database_cleaner.rb`, adding support for the _Database
  Cleaner_ gem

- `spec/support/utilities.rb`, adding support for reading from and
  including the `application_helper.rb`

- `spec/support/mongoid.rb`, adding support for _Mongoid_ (optional)

- `application.rb`

  - adding locale support, both timezone and language

  - adding generator settings to prevent the generation of helpers,
    views specs, and assets

  - specify `.sass` to `.scss` files, because `brevity > verbosity` for
    markup

- `bullet.rb`, which sets up some sane defaults for the _Bullet_ gem.

- `smtp.yml.example`, for Action Mailer initializer (see:
  [Initializers](#initializers))

- `newrelic.yml`, for the New Relic gem (optional)

### Helpers

While I personally do not use helpers (or, limit their usage as much as
possible), I do find it helpful to sometimes include application-wide
helpers, such as the one included, which defines a `page_title` method.

### House-Cleaning

Removal of cruft files: `README.rdoc`, `index.html`, `favicon.ico`, and
`rails.png`.

A new `README.md` boilerplate file is inserted into the project at this
point.

Additionally, the `database.yml` file is removed if using Mongoid.

### Creation of a default static page controller

A placeholder `pages` controller, along with an `index` method is
created.

### Initializers

The following initializers are modified:

- `filter\_parameter\_logging.rb`, adding `:password_confirmation` to
  the list

The following initializers are added:

- `action\_mailer.rb`, which adds support for reading an `smtp.yml`
  file, containing your sensitive mail server settings

- `slim.rb`, which adds support for using `@` as a custom _role_
  attribute for HTML elements

### Assets

`application.css` is replaced by `application.css.sass` (configured for
the inclusion of the _Bourbon_ and _Neat_ gems).

### Git configuration and initialization

This template updates the default `.gitignore` file, as well as creating
a `develop` branch with which to target for initial commits.

It also offers the ability to create a GitHub repository to sync the
project to.

## Reads of Interest

Documentation on Rails templates:

- <http://guides.rubyonrails.org/rails_application_templates.html>
- <http://guides.rubyonrails.org/generators.html#application-templates>
- <https://github.com/rails/rails/blob/master/guides/source/rails_application_templates.md>

Similar projects:

- <https://github.com/lab2023/rails-template>
- <https://github.com/dockyard/sail_plan/blob/master/template.rb>
- <https://github.com/thoughtbot/suspenders>

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
[19]: https://github.com/DockYard/capybara-email
[20]: https://github.com/colszowka/simplecov
[21]: https://github.com/jonleighton/poltergeist
[22]: https://github.com/DockYard/capybara-email
[23]: https://github.com/andi/simple-navigation
[24]: http://mongoid.org/en/mongoid/
[25]: https://github.com/evansagge/mongoid-rspec
[26]: https://github.com/newrelic/rpm
[27]: https://github.com/thoughtbot/neat
[28]: https://github.com/bmabey/email-spec
[29]: https://github.com/jonleighton/poltergeist
[30]: http://rubyonrails.org/
