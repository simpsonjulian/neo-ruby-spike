require 'webstats/page'
require 'webstats/visitor'
module Webstats
  class Importer

    def process(line)
      if line[:status] == '200'
        _, path, _ = line[:request].split(' ')
        create_in_transaction(line[:ip], path)
      end
    end

    def create_in_transaction(ip, path)
      Neo4j::Transaction.run do |tx|
        visitor = Visitor.find_or_create(address: ip)
        visitor.save

        page = Page.find_or_create(url: path)
        # noinspection RubyResolve
        page.visitors = visitor
        page.save
      end
    end

  end
end