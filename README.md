# MJML Ruby

[![Gem](https://img.shields.io/gem/v/mjml-ruby.svg?maxAge=3600&style=flat-square)](https://rubygems.org/gems/mjml-ruby)
[![Travis](https://img.shields.io/travis/kolybasov/mjml-ruby.svg?maxAge=3600&style=flat-square)](https://travis-ci.org/kolybasov/mjml-ruby)
[![Gemnasium](https://img.shields.io/gemnasium/kolybasov/mjml-ruby.svg?maxAge=3600&style=flat-square)](https://gemnasium.com/github.com/kolybasov/mjml-ruby)
[![Code Climate](https://img.shields.io/codeclimate/github/kolybasov/mjml-ruby.svg?maxAge=3600&style=flat-square)](https://codeclimate.com/github/kolybasov/mjml-ruby)

#### [!] REQUIRE NODEJS

[MJML](https://mjml.io) parser and template engine for Ruby. 
Allows to create email templates without mess.

## Install

Add to Gemfile:

```ruby
gem 'mjml-ruby', '~> 0.2.1', require: 'mjml'
```

or

```bash
$ gem install mjml-ruby
```

Install [NodeJS](https://nodejs.org/en/) and [MJML](https://mjml.io) (both installations will works local and global).

```bash
$ npm install -g mjml@^2.3.3
$ bundle install
```

## Usage

#### With Rails

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
  config.debug = true
end

# Rails
Rails.application.configure do
  config.mjml.bin_path = '/usr/bin/env mjml'
  config.mjml.logger = Rails.logger
  config.mjml.debug = true
end
```

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
