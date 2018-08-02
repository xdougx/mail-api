require 'bundler'
Bundler.require(:default, :development)

ARGUMENTS = ARGV.each_with_object({}) do |ele, obj|
  key, val = ele.split("=")
  obj[key] = val
end

require 'net/imap'
require 'mail'
require 'awesome_print'
require 'irb'
require 'colorize'
require 'rack'
require 'grape'

require './lib/kanamobi' 
require './lib/kanamobi/mailer'
require './lib/kanamobi/server'

run Kanamobi::Server
