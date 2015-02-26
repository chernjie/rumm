require "spec_helper"

describe "using the server metadata api" do
  context "with credentials are present" do

    include_context "rummrc"

    context "when I list all metadata for my servers (and I don't have any')" do
      When {VCR.use_cassette('metadata/index') {run "rumm show metadata on server silly-saffron"}}
      Then {all_stdout =~ /rackconnect_automation_status/}
      And {last_exit_status.should eql 0}
    end
    context "when I create a metadatum on a given server" do
      When {VCR.use_cassette('metadata/create') {run "rumm create metadatum on server silly-saffron --key testRackConnectLBPool --value POOL-some-pool"}}
      Then {all_stdout =~ /created metadatum/}
      And {last_exit_status.should eql 0}
    end
    context "when I update a metadatum on a given server" do
      When {VCR.use_cassette('metadata/update') {run "rumm update metadatum testRackConnectLBPool on server silly-saffron --value POOL-other-pool"}}
      Then {all_stdout =~ /metadatum update/}
      And {last_exit_status.should eql 0}
    end
    context "when I show a metadatum on a given server" do
      When {VCR.use_cassette('metadata/show') {run "rumm show metadatum testRackConnectLBPool on server silly-saffron"}}
      Then {last_exit_status.should eql 0}
    end
    context "when I destroy a metadatum on a given server that exists" do
      When {VCR.use_cassette('metadata/destroy') {run "rumm destroy metadatum testRackConnectLBPool on server silly-saffron"}}
      Then {all_stdout =~ /destruction/}
      And {last_exit_status.should eql 0}
    end
  end
end
