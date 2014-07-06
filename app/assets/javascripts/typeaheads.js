function typeaheadChangeMode(){
      $('ul#typeahead-options > li').click(function(){
        $('span#typeahead-current').text($(this).text());
        var option_text = $.trim($(this).text().replace(/ /g,""));        
        $('.typeahead').typeahead('destroy');
        typeaheads($('.typeahead'),option_text);
      });
}      

function typeaheads ($obj,model) 
{
    var mode = model.toLowerCase();    
    var mapped = setDisplay(mode);     
    model = mapped["model"] || mode;
    col = mapped["search_col"] || mapped["first"][0];

         // Instantiate the Bloodhound suggestion engine
        var items = new Bloodhound({
            datumTokenizer: function (datum) {
                return Bloodhound.tokenizers.whitespace(datum.value);
            },
            queryTokenizer: Bloodhound.tokenizers.whitespace,
            remote: '../typeaheads/' + model + '/' + col + '/%QUERY.json'
        });

        // Initialize the Bloodhound suggestion engine
        items.initialize();

        var typeaheads = $obj;

        // Instantiate the Typeahead UI
        $obj.typeahead(null,{
            displayKey: function(item) {
                   return '<div class="bor-b pointer"><span class="md">' 
                          + item[mapped["first"][0]] 
                          + ' ' 
                          + (item[mapped["first"][1]] || '')
                          + '</span><br/> <span class=grey-sm>' 
                          + item[mapped["second"][0]]
                          + ' ' 
                          + (item[mapped["second"][1]] || '')
                          + '</span></div>'  ;
                },
            source: items.ttAdapter()
        });

        var numSelectedHandler = function (eventObject, suggestionObject, suggestionDataset) {
            window.location.href = '/' + model + '/' + suggestionObject.id
        };

        typeaheads.on('typeahead:selected', numSelectedHandler);
}

function setDisplay(model){
    var map =  {
        referenceno: {model: "registrations",first: ["ref_no"], second: ["first_name","surname"],search_col: "ref_no"},
        enquiries: {first: ["first_name","surname"], second: ["mobile1"]},
        registrations: {first: ["first_name","surname"], second: ["email1"]},
        institutions: {first: ["name"], second: ["email"]},
        people: {first: ["first_name","surname"], second: ["email"]},
    };
    return map[model];
}