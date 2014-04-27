module UsersHelper
  
  def sim_fields(sim_transaction, html_options = {})
    fields = sim_transaction.form_fields.collect do |k, v|
      if v.kind_of? Array
        v.collect { |val| hidden_field_tag(k, val, html_options) }
      else
        hidden_field_tag(k, v, html_options)
      end
    end
    fields.flatten!
    field_str = fields.join("\n")
    if field_str.respond_to?(:html_safe)
      return field_str.html_safe
    else
      return field_str
    end
  end
    
end
