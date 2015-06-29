require 'rubygems'
require 'bundler'

Bundler.require

# require 'sinatra'


Neo4j::Session.open(:server_db, 'http://localhost:7474', {basic_auth: {username: 'neo4j', password: 'secret'}})

class Page
  include Neo4j::ActiveNode
  property :url, constraint: :unique
  has_many :in, :visitors, unique: true, type: :VISITED
end

class Visitor
  include Neo4j::ActiveNode
  property :address, constraint: :unique
  property :version, default: 4
end

def process_log(log_file_name)
  parser = HttpLogParser.new
  File.open(log_file_name, 'r:ascii-8bit') do |file|
    while (line = file.gets)
      parsed_data = parser.parse_line(line)
      if parsed_data[:status] == '200'
        _, path, _ = parsed_data[:request].split(' ')
        Neo4j::Transaction.run do |tx|
          v = Visitor.find_or_create(address: parsed_data[:ip])
          v.save
          p = Page.find_or_create(url: path)
          # noinspection RubyResolve
          p.visitors = v
          p.save
          # tx.success
        end
      end

      p parsed_data
    end
  end
end

process_log('access.log')

print Visitor.all

# get '/' do
#
#
#
#
# end