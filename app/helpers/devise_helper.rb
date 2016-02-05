module DeviseHelper
  def devise_error_messages!
    return '' if resource.errors.empty?

    messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join

    # Sample:
    # sentence = I18n.t('errors.messages.not_saved',
    #                   :count => resource.errors.count,
    #                   :resource => resource.class.model_name.human.downcase)
    #
    # html = <<-HTML
    #   <div id="error_explanation">
    #     <h2>#{sentence}</h2>
    #     <ul>#{messages}</ul>
    #   </div>
    # HTML
    #

    # Slim sample
    # - if resource.errors.any?
    #     ul
    #     - if resource.errors.messages.key?(:email)
    #         li= "#{:email} #{resource.errors.messages[:email].join}"
    #         - if resource.errors.messages.key?(:password)
    #             li= "#{:password} #{resource.errors.messages[:password].join}"
    html = "<ul>#{messages}</ul>"

    html.html_safe
  end

  def devise_error_messages?
    resource.errors.empty? ? false : true
  end
end
