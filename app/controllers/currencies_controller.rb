class CurrenciesController < ActionController::Base
  def first_currency
    @array_of_symbols = JSON.parse(open("https://api.exchangerate.host/symbols").read).fetch("symbols").keys
    
    render({ :template => "currency_templates/step_one.html.erb" })
  end

  def second_currency
    @array_of_symbols = JSON.parse(open("https://api.exchangerate.host/symbols").read).fetch("symbols").keys
    @from_currency = params.fetch("from_currency")
    
    render({ :template => "currency_templates/step_two.html.erb" })
  end
end
