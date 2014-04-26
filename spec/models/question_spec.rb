require 'spec_helper'
require 'shoulda/matchers'

describe Question do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:body) }
  end
end
