require 'spec_helper'

describe Profile do

  it { should belong_to(:user) }

  it { should ensure_length_of(:facebook_id).is_at_least(5).is_at_most(255) }
  it { should validate_numericality_of(:age).only_integer.is_less_than(100) }
  it { should ensure_length_of(:display_name).is_at_least(3).is_at_most(80) }

  it { should allow_value('Jim Carry Esq').for(:display_name) }
  it { should_not allow_value("@#!,. '|'").for(:display_name) }
  it { should allow_value('microgenius').for(:facebook_id) }
  it { should_not allow_value("micro genius").for(:facebook_id) }

end
