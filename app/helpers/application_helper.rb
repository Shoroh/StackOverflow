module ApplicationHelper

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  # Generates title of the page like <title>'Title' — Stack Overflow</title>)
  #
  # @param page_title [String] name of the title
  #
  # @example
  #   - title 'Recent Questions'
  # @return [string] 'Recent Questions —'
  def title(page_title)
    if page_title
      content_for(:title) { page_title  + " — " }
    end
  end

end
