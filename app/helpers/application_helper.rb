module ApplicationHelper
  ALERT_TYPES = [:error, :info, :success, :warning, :danger].freeze unless const_defined?(:ALERT_TYPES)
	def link_to_add_address_fields(name, f, association, partial, locals = {})
    new_object = association.to_s.classify.constantize.new
    fields = f.fields_for(association, new_object, :child_index => "new_{association}") do |builder|
      locals[:f] = builder
      render(:partial => partial, :locals => locals)
    end
    link_to name, 'javascript:void(0);', :onclick => "add_fields(this, \"{association}\", \"#{escape_javascript(fields)}\")", :class => 'newAdmP newAdmExp blueboxBtn'
  end

  def bootstrap_flash(options = {})
    flash_messages = []
    flash.each do |type, message|
      # Skip empty messages, e.g. for devise messages set to nothing in a locale file.
      next if message.blank?

      type = type.to_sym
      type = :success if type == :notice
      type = :danger if type == :alert
      type = :danger if type == :error
      next unless ALERT_TYPES.include?(type)

      Array(message).each do |msg|
        text = content_tag(:div,
                           content_tag(:button, raw("&times;"), class: 'close', 'data-dismiss' => 'alert') +
                           msg.html_safe, class: "alert fade in alert-#{type}")
        flash_messages << text if msg
      end
    end
    flash_messages.join("\n").html_safe
  end

	def back_button(url = :back)
    url = back_path if url == :back
    html_content = content_tag(:span, "Back", :class => "waves-effect waves-light btn")
    link_to html_content, url, :confirm =>'Are you sure?'#,:style => "float:right;width:120px"
  end

  def more_vert_button(id)
    content_tag :button , class: "mdl-button mdl-js-button mdl-button--icon prevent_button", id: "demo-menu-lower-right#{id}" do
      content_tag :i , class: "material-icons" do
        "more_vert"
      end
    end
  end

  def edit_link(params, id)
    content_tag :a , class: "mdl-menu__item mdl-js-ripple-effect", href: "/admin/#{params[:controller].split("/").second}/#{id}/edit" , class: "mdl-menu__item"  do
        "Edit"
    end
  end

  def new_link(params, id)
    content_tag :a , class: "mdl-menu__item mdl-js-ripple-effect", href: "/admin/leaves/new" , class: "mdl-menu__item"  do
        "New"
    end
  end

  def delete_link(params, id)
    content_tag :a , class: "mdl-menu__item mdl-js-ripple-effect", href: "/admin/#{params[:controller].split("/").second}/#{id}" , 'data-method' => :delete ,class: "mdl-menu__item", data: { confirm: 'Are you sure?' } do
      "Delete"
    end
  end

  def show_link(params, id, value)
    content_tag :a , class: "collection-item" , href: "/admin/#{params[:controller].split("/").second}/#{id}" do
      value
    end
  end

  def show_on_map(id, user_id)
    #content_tag :a , class: "collection-item" , href: "/admin/maps/#{params[:id]}?user=#{user_id[:user]}" do
    content_tag :a , class: "mdl-menu__item mdl-js-ripple-effect", href: "/admin/maps/#{params[:id]}?user=#{user_id[:user_id]}" , 'data-method' => :get , :target => "_blank" do
      'View On Map'
    end
  end

  # def get_emp_status_class(user)
  #   status_class = ""
  #   if user.emp_status == "Confirm"
  #     status_class = "stausactive"
  #   elsif
  #     status_class = "statuspending"
  #   else
  #     status_class = "statusreject"
  #   end
  #   status_class
  # end

  def show_field(label, obj)
    #mdl-cell--5-col mdl-cell--4-col-tablet m-8
    content_tag :div, class: "mdl-cell--5-col no-p-l no-p-t no-p-r no-p-b" do
      content_tag :div, class: "" do
        content_tag :p, class: "no-m-b" do
          str = content_tag :strong, label
          str += content_tag :span, obj rescue nil
          str
        end
      end
    end
  end

  def back_button_detailed_page(url = :back)
    url = back_path if url == :back
    html_content = content_tag(:span, "Back", :class => "back_btn")
    link_to html_content, url, :confirm =>'Are you sure?'
  end

  def custom_basic_text_field_tag(name, title, params, *args)
    params = params.to_s
    params1 = params.gsub(/[^0-9a-z]/, '')
    params = params1.slice!(0..6)
    str = content_tag(:input, nil, :type => 'text', :name => name, :value => params1, :class => "mdl-textfield__input")
    str += content_tag :label, title, class: "mdl-textfield__label"
    str
  end

  def basic_search_value(params)
    (params[:adv_search] == "true") ? "" : params[:search]
  end

  def adv_search_value(params,name)
    params[:search].present? ? params[:search][name] : ""
  end

  def custom_basic_button_tag(title)
    content_tag :div, class: "mdl-cell--3-col mdl-cell--1-col-tablet mdl-cell--2-col-phone m-10" do
      content_tag(:input, nil, :type => 'submit', :value => title, :class => "mdl-button mdl-js-button mdl-button--raised mdl-button--colored mdl-js-ripple-effect mdl-color--light-blue-600")
    end
  end

  def custom_advance_search_link_tag(label)
    content_tag :div, class: "mdl-cell--2-col mdl-cell--2-col-tablet mdl-cell--2-col-phone m-l-15 moreBtn mdl-typography--text-right" do
      content_tag :a, "Search", class: "adminClick hvr-underline-from-center", href: "javascript:void(0);"
    end
  end

  def custom_text_field_tag(name,title, params,*args)
    content_tag :div, class: "mdl-cell--4-col mdl-cell--4-col-tablet m-8" do
      content_tag :div, class: "mdl-textfield mdl-js-textfield mdl-textfield--floating-label is-upgraded" do
        str = content_tag(:input, nil, :type => 'text', :name => name, :value => params, :class => "mdl-textfield__input", :id => (args[0].present?) ? args[0][:id] : '')
        str += content_tag :label, title, class: "mdl-textfield__label"
        str
      end
    end
  end

  def custom_button_tag(title, label)
    content_tag :div, class: "mdl-cell--4-col mdl-cell--4-col-tablet mdl-cell--4-col-phone m-8" do
      content_tag :div, class: "moreBtn collapseminus" do
        str = content_tag :a, "Hide", class: "f-right m-t-5 hvr-underline-from-center hvr-underline-from-centernew", href: "javascript:void(0);"
        str += content_tag(:input, nil, :type => 'submit', :value => title, :class => "mdl-button mdl-js-button mdl-button--raised mdl-button--colored mdl-js-ripple-effect mdl-color--light-blue-600 f-right m-r-35")
        str
      end
    end
  end

  def custom_button_tag_without_hide(title)
    content_tag :div, class: "mdl-cell--4-col mdl-cell--4-col-tablet mdl-cell--4-col-phone m-8" do
      content_tag :div, class: "moreBtn collapseminus" do
        str = content_tag(:input, nil, :type => 'submit', :value => title, :class => "mdl-button mdl-js-button mdl-button--raised mdl-button--colored mdl-js-ripple-effect mdl-color--light-blue-600 f-right m-r-35")
        str
      end
    end
  end

end
