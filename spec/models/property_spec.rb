require 'spec_helper'

describe Property do
  
  let(:user) { FactoryGirl.create(:user) }
  before { @property = user.properties.build(name: "Bachelor Arms") }
  subject { @property }
  
  it { should respond_to(:name) }
  it { should respond_to(:address) }
  it { should respond_to(:city) }
  it { should respond_to(:state) }
  it { should respond_to(:zip) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should eq user }
  
  it { should be_valid }
  
  describe "when user_id is not present" do
    before { @property.user_id = nil }
    it { should_not be_valid }
  end
  
end
