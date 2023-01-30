class CovidController < ActionController::Base
  def all_states
    @states = JSON.parse(open("https://api.covidtracking.com/v1/states/current.json").read)

    render({ :template => "covid_templates/all_states.html.erb" })
  end
  def state_details
    require "date"

    @state = params.fetch("state")
    @daily = JSON.parse(open("https://api.covidtracking.com/v1/states/" + @state.downcase + "/daily.json").read)

    @data_array = Array.new()
    @data_array.push(["Date", "Percent of new tests comprised of new positive cases"])

    @daily.reverse.each do |day|
      @data_array.push([Date.parse(day.fetch("date").to_s).strftime('%Y-%m-%d'), (day.fetch("positiveIncrease").to_f / day.fetch("totalTestResultsIncrease").to_f) * 100])
    end

    render({ :template => "covid_templates/state_details.html.erb" })
  end
end
