module ApplicationHelper
  
  def account_select(form, customer, account_field = :source_account_id)
    form.collection_select(account_field, customer.accounts, :id, :display, :prompt => 'Select an Account')
  end
  
  def print_or_display
    content_tag :p, :class => 'print_or_display' do
      label_tag("Display On Screen: ") +
      radio_button_tag('output', 'screen', true) + "<br />".html_safe +
      label_tag("Print Receipt: ") +
      radio_button_tag('output', 'print')
    end
  end
  
  
end
