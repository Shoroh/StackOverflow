require 'spec_helper'

describe Question do
  let!(:question) {create_list(:question, 2)}
  let!(:deleted_question) {create_list(:deleted_question, 2)}
  let!(:pending_question) {create_list(:pending_question, 2)}

  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:body) }

  it { should ensure_length_of(:title).is_at_least(20).is_at_most(255) }
  it { should ensure_length_of(:body).is_at_least(20).is_at_most(6000) }

  it { should belong_to(:user) }

  it { should allow_value('active', 'pending', 'deleted').for(:status) }

  it "should give only active questions when 'recent'" do
    expect(Question.recent.last.active?).to be_true
    expect(Question.recent.count).to eq(2)
  end

  it "should not give deleted questions when 'recent'" do
    expect(Question.recent.last.deleted?).to be_false
  end

  it "should not give pending questions when 'recent'" do
    expect(Question.recent.last.pending?).to be_false
  end

end