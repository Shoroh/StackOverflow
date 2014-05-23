require 'spec_helper'

describe Answer do
  it { should belong_to(:question)}
  it { should belong_to(:user)}
  it { should have_many(:attachments)}

  it { should validate_presence_of(:body) }
  it { should ensure_length_of(:body).is_at_least(3).is_at_most(6000) }

  it { should allow_value('active', 'pending', 'deleted').for(:status) }

  it { should accept_nested_attributes_for :attachments}

end
