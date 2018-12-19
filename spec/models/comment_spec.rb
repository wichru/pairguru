require 'rails_helper'

RSpec.describe Comment, type: :model do
  it { should belong_to(:movie) }
  it { should validates_presence_of(:movie) }
  it { should validates_presence_of(:user) }
end
