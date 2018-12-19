require 'rails_helper'

RSpec.describe Comment, type: :model do
  it { should belong_to(:movie) }
  it { should validate_presence_of(:movie) }
  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:body) }
end
