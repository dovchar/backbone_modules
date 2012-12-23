require_relative '../../test_helper'

describe BackboneModules do
  it "must be defined" do
    BackboneModules::VERSION.wont_be_nil
  end
end