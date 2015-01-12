class SearchCore
  attr_reader :options

  def initialize(options = {})
    @options = HashWithIndifferentAccess.new(options)
    @resources = [ :enquiries, :registrations, :institutions, :people]
  end

  def results
    term = options[:term]

    Tire.search @resources do
      query { string "#{term}" }
      # size 20
    end.results
  end

  def autocomplete
    array = []

    results.to_a.reverse.each do |result|

      name = (result.first_name + ' ' + result.surname) rescue result.name      

      array << {title: name, 
                email: result.email,
                mobile1: (result.mobile1 rescue result.phone),
                shape: icon(result._type), 
                model: result._type}
    end

    array
  end

  def icon(model)
    shape = case model
    when 'enquiry'
      'earphone'
    when 'registration'
      'pencil'
    when 'institution'
      'home'
    when 'person'
      'globe'
    end

    "<span class='#{model} glyphicon glyphicon-#{shape}'></span>"
  end
end
