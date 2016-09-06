require 'rails_helper'

RSpec.describe Album, type: :model do
  
  subject {
    described_class.new(name: "album_name", description: "album_description", style: 1)
    }
  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end
  
  it "is not valid without a name" do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a desciption" do
    subject.description = nil
    expect(subject).to_not be_valid    
  end

  it "is not valid without a style" do
    subject.style = nil
    expect(subject).to_not be_valid
  end
end
