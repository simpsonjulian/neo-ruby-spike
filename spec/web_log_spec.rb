require 'rubygems'
require 'bundler'


Bundler.require
require 'spec_helper'
require 'rspec'
require 'webstats/processor'

include Webstats
describe 'Processing Parsed Logs' do
  before(:each) do
    Visitor.find_by(address: '192.168.0.1').destroy
    Page.find_by(url: '/home').destroy
  end

  it 'should create things ' do
    Processor.new.process({:ip => '192.168.0.1', :request=> 'GET /home HTTP/1.1', :status => "200"})
    expect(Visitor.find_by(address: '192.168.0.1')).to exist
    expect(Page.find_by(url: '/home')).to exist
  end
end