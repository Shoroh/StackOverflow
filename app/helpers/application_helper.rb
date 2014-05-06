module ApplicationHelper

  # Проверяем какой контроллер сейчас активен
  def controller?(*controller)
    controller.include?(params[:controller])
  end

  # Проверяем какой метод контроллера сейчас активен
  def action?(*action)
    action.include?(params[:action])
  end

  # Делаем активные ссылки в меню с классом active:
  def nav_link(link_text, link_path)
    class_name = current_page?(link_path) ? 'menu_item_active' : ''

    content_tag(:li, :class => class_name) do
      link_to link_text, link_path
    end
  end

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
