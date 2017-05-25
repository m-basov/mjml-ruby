# MJML Ruby

[![Gem](https://img.shields.io/gem/v/mjml-ruby.svg?maxAge=3600&style=flat-square)](https://rubygems.org/gems/mjml-ruby)
[![Travis](https://img.shields.io/travis/kolybasov/mjml-ruby.svg?maxAge=3600&style=flat-square)](https://travis-ci.org/kolybasov/mjml-ruby)
[![Gemnasium](https://img.shields.io/gemnasium/kolybasov/mjml-ruby.svg?maxAge=3600&style=flat-square)](https://gemnasium.com/github.com/kolybasov/mjml-ruby)
[![Code Climate](https://img.shields.io/codeclimate/github/kolybasov/mjml-ruby.svg?maxAge=3600&style=flat-square)](https://codeclimate.com/github/kolybasov/mjml-ruby)

__[!] REQUIRE NODEJS__

[MJML](https://mjml.io) parser and template engine for Ruby.
Allows to create email templates without mess.

## Install

Add to Gemfile:

```ruby
gem 'mjml-ruby', '~> 0.3', require: 'mjml'
```

or

```bash
$ gem install mjml-ruby
```

Install [NodeJS](https://nodejs.org/en/) and [MJML](https://mjml.io)
(both installations will works local and global).

```bash
$ npm install -g mjml@^3.0.0
$ bundle install
```

## Usage

### MJML v3

[MJML v3](https://github.com/mjmlio/mjml/releases/tag/3.0.0) had added validation
for templates and it breaks mjml-ruby `v0.2.x` if your template was invalid.
mjml-ruby `> v0.3.x` has `validation_level` option(`:soft` by default) and
allows to use old templates with v3. All validation errors will be logged.

Example:

```ruby
MJML.configure do |config|
  config.validation_level = :soft # :skip/:soft/:strict
end
```

### With Rails

```erb
<!-- app/views/layouts/mailer.html.mjml -->

<mjml>
  <mj-body>
    <mj-container>
      <%= yield %>
    </mj-container>
  <mj-body>
</mjml>
```

```erb
<!-- app/views/welcome_mailer/welcome.html.mjml -->

<mj-text>Hello, <%= @user.name %></mj-text>
```

```ruby
class WelcomeMailer < ApplicationMailer
  def welcome(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome')
  end
end
```

#### With [Tilt](https://github.com/rtomayko/tilt)

```erb
<!-- templates/hello.mjml -->

<mjml>
  <mj-body>
    <mj-container>
      <mj-text>Hello, world!</mj-text>
    </mj-container>
  <mj-body>
</mjml>
```

```ruby
require 'tilt'
require 'mjml'

template = Tilt.new('templates/hello.mjml')
template.render # returns compiled HTML
```

#### With [mail](https://github.com/mikel/mail) gem

```erb
<!-- hello.mjml -->

<mjml>
  <mj-body>
    <mj-container>
      <mj-text>Hello, world!</mj-text>
    </mj-container>
  <mj-body>
</mjml>
```

```ruby
require 'mail'
require 'mjml'

template = File.open('hello.mjml', 'rb') { |f| MJML::Parser.new.call(f) }

Mail.deliver do
  from 'example@mail.com'
  to 'example@mail.com'
  subject 'Hello'
  body template
end
```

## Configuration

```ruby
# Change default mjml executable

# Regular Ruby
MJML.configure do |config|
  config.bin_path = '/usr/bin/env mjml'
  config.logger = YourLogger.new(STDOUT)
  config.minify_output = true
  config.validation_level = :soft
end

# Rails
Rails.application.configure do
  config.mjml.bin_path = '/usr/bin/env mjml'
  config.mjml.logger = MJML::Logger.setup!(STDOUT)
  config.mjml.minify_output = true
  config.mjml.validation_level = :soft
end
```

## Deprecations

### v0.3

- `config.debug = true` is deprecated. If you are using default MJML Logger
use `config.logger.level = ::Logger::DEBUG` instead.

## TODO

- [x] Create parser
- [x] Make it configurable
- [x] Create Tilt interface
- [x] Create Sprockets interface
- [x] Create Railtie
- [x] Setup Travis
- [x] Add usage guide
- [x] Fix tests on CI
- [ ] Add more tests
- [ ] Improove docs
