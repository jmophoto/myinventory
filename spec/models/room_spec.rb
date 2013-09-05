require 'spec_helper'

describe Room do

  let(:property) { FactoryGirl.create(:property) }
  before { @room = property.rooms.build(name: "Bedroom", room_type: "bedroom") }
  subject { @room }
  
  it { should respond_to(:name) }
  it { should respond_to(:room_type) }
  it { should respond_to(:property_id) }
  it { should respond_to(:property) }
  
  its(:property) { should eq property }
  
  
  describe "when property_id is not present" do
    before { @room.property_id = nil }
    it { should_not be_valid }
  end


end
