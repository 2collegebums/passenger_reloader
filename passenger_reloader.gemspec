# -*- encoding: utf-8 -*-
require File.expand_path("../lib/passenger_reloader/version", __FILE__)

Gem::Specification.new do |s|
  # About this gem
  s.name = %q{passenger_reloader}
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
  s.required_rubygems_version = Gem::Requirement.new(">= 1.3.6") if s.respond_to? :required_rubygems_version=

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
