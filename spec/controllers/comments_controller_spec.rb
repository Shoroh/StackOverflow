require 'spec_helper'

describe CommentsController do

  let(:question){create(:question)}
  it { should route(:post, "/questions/#{question.id}/comments").to(controller: 'comments', action: 'create', question_id: question.id) }

  

end
