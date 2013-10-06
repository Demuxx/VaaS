# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# Environment variables (ENV['...']) can be set in the file config/application.yml.
# See http://railsapps.github.io/rails-environment-variables.html

Box.create(
  [
    {name: "lucid32", url: "http://files.vagrantup.com/lucid32.box"},
    {name: "lucid64", url: "http://files.vagrantup.com/lucid64.box"},
    {name: "precise32", url: "http://files.vagrantup.com/precise32.box"},
    {name: "precise64", url: "http://files.vagrantup.com/precise64.box"},
    {name: "vmware_precise64", url: "http://files.vagrantup.com/precise64_vmware_fusion.box"}
  ]
)

Network.create(
  [
    {name: "public_network", bridge: "en0: Wi-Fi (AirPort)"},
    {name: "private_network", bridge: ""}
  ]
)

Status.create(
  [
    {name: "Down", color: "#CC00FF"},
    {name: "Up", color: "#33CC33"},
    {name: "Not Created", color: "#0000FF"},
    {name: "Restarting", color: "#FFFF00"},
    {name: "Off", color: "#999999"},
    {name: "Unknown", color: "#CC0000"}
  ]
)
