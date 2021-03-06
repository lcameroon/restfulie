require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Restfulie::Common do
  it "should extract link header from links" do
    link1 = Medie::Link.new(:rel => "home", :href => "http://google.com")
    link2 = Medie::Link.new(:rel => "next", :href => "http://google.com?q=ruby")
    links = [link1, link2]
    
    Restfulie::Common.extract_link_header(links).should == "<http://google.com>; rel=home, <http://google.com?q=ruby>; rel=next"
  end  
end
