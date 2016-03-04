module ApplicationHelper

  def force_action(action)
    <<-HTML.html_safe
     <input type="hidden" name="_method" value="#{h(action.to_s)}">
    HTML
  end

  def our_button_to(value, action_url, method)
    <<-HTML.html_safe
    <form action="#{h(action_url)}" method="#{h(method.to_s)}">
      <input type="submit" value="#{h(value)}">
    </form>
    HTML
  end
end
