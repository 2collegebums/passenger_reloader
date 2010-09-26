# -*- encoding: utf-8 -*-
require File.expand_path("../lib/passenger_reloader/version", __FILE__)

Gem::Specification.new do |s|
  # About this gem
  s.name = %q{passenger_reloader}
  s.version     = PassengerReloader::VERSION
  s.platform    = Gem::Platform::RUBY

  s.authors     = ['Thomas Shafer', 'Nathan Esquenazi']
  s.date        = %q{2010-09-25}
  s.description = %q{Reloades Passenger on non cached object changes}
  s.email       = ['growly.pants@gmail.com','nesquena@gmail.com']
  s.summary = %q{Reloades Passenger on non cached object changes}
  s.homepage = %q{https://growlypants@github.com/2collegebums/passenger_reloader}
  s.rubyforge_project = %q{passenger_reloader}

  # Files
  s.files =  `git ls-files`.split("\n")
  s.executables  = `git ls-files`.split("\n").map{|f| f =~ /^bin\/(.*)/ ? $1 : nil}.compact
  s.require_path = 'lib'


  # Other stuff
  s.required_rubygems_version = ">= 1.3.6"
  s.add_development_dependency "bundler", ">= 1.0.0"

end
