require 'rspec'
require 'webstats/importer'

include Webstats
describe 'Importing Log File Data' do

  LOG_LINE = '93.104.31.96 - - [12/Oct/2013:16:53:47 +0000] "GET /chunked/versions.js?_=1381596826995 HTTP/1.1" 200 105 "http://docs.neo4j.org/chunked/milestone/server-java-rest-client-example.html" "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/30.0.1599.66 Safari/537.36"'
  FILE_NAME = 'access.log'
  it 'should process a line of access log' do
    expect(Importer.new(LOG_LINE).process.first[:ip]).to eq '93.104.31.96'
  end

  it 'should process a filename full of log data' do
    expect(Importer.new(FILE_NAME).process.first[:ip]).to eq '173.66.6.175'
  end

  it 'should optionally accept a callback to do something with a line of data' do
    cb = double
    expect(cb).to receive(:callback)
    Importer.new(LOG_LINE).process(cb, 'callback')
  end
end