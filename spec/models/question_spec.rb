require 'spec_helper'
require 'shoulda/matchers'

describe Question do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:body) }

  # Почему следующие две строчки не работают?
  question = FactoryGirl.build :question # — так указано в доках к FactoryGirls, но работает только вместе с "question = FactoryGirl.build :question"
  it { should ensure_length_of(question.title).is_at_least(5).is_at_most(80) } # — всегда провальный тест.


end