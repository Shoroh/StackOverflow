module ApplicationHelper

  # Check which controller is active at the moment?
  # @param controller [string] name of the controller
  # @example - if controller?('questions')
  # @return [boolean]
  def controller?(*controller)
    controller.include?(params[:controller])
  end

  # Check which action is active at the moment?
  # @param action [string] name of the action
  # @example - if action?('featured')
  # @return [boolean]
  def action?(*action)
    action.include?(params[:action])
  end

  # Generates link in sort_panel menu, to sort questions by
  #   criteria, and add 'active' css class to <a> tag.
  # @param link_text [string] — text of the link
  # @param link_path [string] - path/url of the link
  #
  # @example = sort_link('Featured', featured_questions_path)
  # @return [string]
  #   <a class="btn btn-xs btn-info (active)" href='link_path'>link_text</a>
  def sort_link(link_text, link_path, action)
    class_name = action?(action) ? 'active' : ''

    content_tag(:li, :class => class_name) do
      link_to link_text, link_path
    end
  end


  # Делаем активные ссылки в меню с классом active:
  def nav_link(link_text, link_path, controller)
    class_name = controller?(controller) ? 'active' : ''

    content_tag(:li, :class => class_name) do
      link_to link_text, link_path
    end
  end

  # Generates title of the page like <title>'Title' — Stack Overflow</title>)
  # @param page_title [String] name of the title
  # @example
  #   - title 'Recent Questions'
  # @return [string] 'Recent Questions —'
  def title(page_title)
    if page_title
      content_for(:title) { page_title  + " — " }
    end
  end


  # For Devise tests
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

end
