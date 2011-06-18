module ApplicationHelper
  
  def account_select(form, customer, account_field = :source_account_id)
    form.collection_select(account_field, customer.accounts, :id, :display, :prompt => 'Select an Account')
  end
  
  def print_or_display
    content_tag :p, :class => 'print_or_display' do
      radio_button_tag('output', 'screen', true)  +
      label_tag(" Display on Screen").titleize + "<br />".html_safe +
      radio_button_tag('output', 'print') +
      label_tag(" Print Receipt").titleize
    end
  end
  
  def flash_messages
    flash.collect do |name, msg|
      content_tag :div, msg, :class => 'flash', :id => name
    end.join.html_safe
  end
  
  
end
