require "spec_helper"

describe "using the server metadata api" do
  context "with credentials are present" do

    include_context "rummrc"

    context "when I list all metadata for my servers (and I don't have any')" do
      When {VCR.use_cassette('metadata/index') {run "rumm show metadata on server silly-saffron"}}
      Then {all_stdout =~ /you don't have any metadata/}
      And {last_exit_status.should eql 0}
    end
    context "when I show a metadatum on a given server" do
      When {VCR.use_cassette('metadata/show') {run "rumm show metadatum RackConnectLBPool on server silly-saffron"}}
      Then {last_exit_status.should eql 0}
    end
  end
end
