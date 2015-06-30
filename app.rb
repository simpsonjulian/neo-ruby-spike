require 'rubygems'
require 'bundler'

Bundler.require

# require 'sinatra'






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