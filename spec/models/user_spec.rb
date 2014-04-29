require 'spec_helper'

describe User do

  it { should validate_uniqueness_of(:email) }
  it { should validate_uniqueness_of(:name) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }

  it { should ensure_length_of(:password).is_at_least(8) }

  it { should have_many(:questions) }

end
