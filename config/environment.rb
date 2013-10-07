# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Microsites2::Application.initialize!

require 'paperclip'

Encoding.default_external = Encoding::UTF_8
Encoding.default_internal = Encoding::UTF_8

# encoding: utf-8
# coding: utf-8

YAML::ENGINE.yamler = 'syck'