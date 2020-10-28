require 'rails'
require 'action_mailer/railtie'
require 'action_controller/railtie'
require 'mjml/railtie'
require_relative '../spec_helper'

class Dummy < Rails::Application
  config.logger = Logger.new($stdout)
  Rails.logger = config.logger

  secrets.secret_key_base = '_'
  config.hosts << 'www.example.com' if config.respond_to?(:hosts)

  initialize!
end

class UserMailer < ActionMailer::Base
  layout 'mailer'
  default from: 'from@local'
  default(template_path: 'templates')
  prepend_view_path(FIXTURES_PATH)

  def greeting(name)
    @name = name

    mail to: 'to@local', subject: ''
  end
end

describe MJML::Railtie do
  it do
    _(Dummy.config.mjml).must_equal MJML::Config
  end

  it do
    mail = UserMailer.greeting('Dummy')
    _(mail.body).must_include('Hello, Dummy')
  end
end
