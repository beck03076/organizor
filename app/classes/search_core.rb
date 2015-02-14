class SearchCore
  attr_reader :options

  def initialize(options = {})
    @options = HashWithIndifferentAccess.new(options)
    @resources = [ :enquiries, :registrations, :partners, :people]
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
      core = result._type

      array << {title: name, 
                email: result.email,
                mobile1: (result.mobile1 rescue result.phone),
                shape: icon(core), 
                model: core,
                model_pl: core.pluralize,
                id: result.id}
    end

    array
  end

  def icon(model)
    shape = case model
    when 'enquiry'
      'phone-alt'
    when 'registration'
      'flag'
    when 'partner'
      'heart'
    when 'person'
      'globe'
    end

    "<span class='#{model} glyphicon glyphicon-#{shape} xl'></span>"

  end
end
