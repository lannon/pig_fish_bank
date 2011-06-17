module ApplicationHelper
  
  def account_select(form, customer, account_field = :source_account_id)
    form.collection_select(account_field, customer.accounts, :id, :display)
  end
  
  
end
