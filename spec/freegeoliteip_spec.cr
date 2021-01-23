require "./spec_helper"

describe "FREEGEOLITEIP" do
  it "renders /" do
    get "/" do |response|
      response.body.should eq "Hello, World!"
    end
  end
end
