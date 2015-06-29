require 'http_log_parser'

module Webstats
  class Importer
    def initialize(arg)
      @parser = HttpLogParser.new
      process_inputs(arg)
    end

    def process_inputs(arg)
      if arg =~ /^\d+\.\d+\.\d+\.\d+/
        @workload = [arg]
      elsif File.exist?(arg)
        @workload = File.read(arg).each_line.collect
      else
        puts Dir.pwd
        raise "#{arg} not found"
      end
    end

    def process(obj=nil, meth=nil)
      output = []
      @workload.each do |line|
        response = @parser.parse_line(line)
        output << response
        if obj && meth
          obj.send(meth,response)
        end
      end
      output
    end

  end
end