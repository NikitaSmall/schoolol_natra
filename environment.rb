require 'rubygems'
require 'bundler/setup'
require 'dotenv'
require 'dm-core'
require 'dm-timestamps'
require 'dm-validations'
require 'dm-aggregates'
require 'dm-migrations'
require 'ostruct'

require 'slim'

require 'sinatra' unless defined?(Sinatra)

Dotenv.load

use Rack::Session::Cookie,
    key: 'rack.session',
    expire_after: 2592000,
    secret: 'nikitacrab'

ENV["DATABASE_URL"] = 'mysql://root:toor@localhost/school_natra'

configure do
  SiteConfig = OpenStruct.new(
      :title => 'School Natra',
      :author => 'nikitasmall',
      :url_base => 'http://localhost:4567/'
  )

  # load models
  $LOAD_PATH.unshift("#{File.dirname(__FILE__)}/lib")
  Dir.glob("#{File.dirname(__FILE__)}/lib/*.rb") { |lib| require File.basename(lib, '.*') }

  DataMapper.setup(:default, (ENV["DATABASE_URL"] || "sqlite3:///#{File.expand_path(File.dirname(__FILE__))}/#{Sinatra::Base.environment}.db"))
  DataMapper.finalize
  DataMapper.auto_upgrade!
end
