require 'spec_helper'

describe Inspection do
  
  before { @inspection = Inspection.new() }
  subject { @inspection }
  
  it { should respond_to :inspection_type }
  it { should respond_to :unit }
  it { should respond_to :tenant }
  it { should respond_to :inspected_by }
  it { should respond_to :inspection_date }
  
end
