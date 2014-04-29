require 'spec_helper'

describe Question do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:body) }
  it { should ensure_length_of(:title).is_at_least(5).is_at_most(80) }

  it { should belong_to(:user) }
end