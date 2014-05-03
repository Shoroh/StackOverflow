module Features

  def user_sees_alert(text)
    expect(page).to have_css '.alert', text: text
  end

end