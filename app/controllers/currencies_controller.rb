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

  def third_currency
    @from_currency = params.fetch("from_currency")
    @to_currency = params.fetch("to_currency")
    @rate = JSON.parse(open("https://api.exchangerate.host/convert?from=" + @from_currency + "&to=" + @to_currency).read).fetch("info").fetch("rate")
    
    render({ :template => "currency_templates/step_three.html.erb" })
  end
end
