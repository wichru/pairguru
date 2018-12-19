require 'rails_helper'

RSpec.describe Movie, type: :model do
  it { should belong_to(:genre) }
  it { should have_many(:comments).dependent(:destroy) }
end
