require 'spec_helper'

describe VotesController do
  given!(:user){create(:user)}
  given!(:question){create(:question)}

  login_user_warden
  visit question_path(question)

end
