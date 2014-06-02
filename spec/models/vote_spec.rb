require 'spec_helper'

describe Vote do
  it { should validate_presence_of(:votable_id) }
  it { should validate_presence_of(:votable_type) }
  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:value) }

  # TODO Добавить тоже самое в модели Question, Answer и User
  it { should belong_to(:votable) }
  it { should belong_to(:user) }

  it { should allow_value('like', 'unlike', 'abstain').for(:value) }
end
