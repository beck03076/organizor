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
    
    // var mode = model.toLowerCase();    
    // var mapped = setDisplay(mode);     
    // model = mapped["model"] || mode;
    var mapped = setDisplay();    
    col = "title";

         // Instantiate the Bloodhound suggestion engine
        var items = new Bloodhound({
            datumTokenizer: function (datum) {
                return Bloodhound.tokenizers.whitespace(datum.value);
            },
            queryTokenizer: Bloodhound.tokenizers.whitespace,
            //remote: '../typeaheads/' + model + '/' + col + '/%QUERY'
            remote: '../typeaheads' + '/%QUERY'
        });

        // Initialize the Bloodhound suggestion engine
        items.initialize();

        var typeaheads = $obj;

        // Instantiate the Typeahead UI
        $obj.typeahead({minLength: 3},{
            displayKey: function(item) {
                   ico = item[mapped["first"][0]];
                   model = item[mapped["second"][2]];
                   return '<div class="bor-b pointer row">'                          
                          + '<div class="col-xs-9">'
                          + '<span class="md ' + model + '">'                           
                          + (item[mapped["first"][1]] || '')
                          + '</span><br/> <div class=grey-sm>' 
                          + (item[mapped["second"][0]] || "No email")
                          + '<br/>'
                          + (item[mapped["second"][1]] || "No phone")
                          + '</div></div>'
                          + '<div class=col-xs-3>'
                          + ico
                          + '</div></div>'  ;
                },
            source: items.ttAdapter()
        });

        var numSelectedHandler = function (eventObject, suggestionObject, suggestionDataset) {
            window.location.href = '/' + model + '/' + suggestionObject.id
        };

        typeaheads.on('typeahead:selected', numSelectedHandler);
}


function setDisplay(){
    return { model: "all",first: ["shape","title"], second: ["email","mobile1","model"] };    
}

/*
function setDisplay(model){
    var map =  {
        referenceno: {model: "registrations",first: ["ref_no"], second: ["first_name","surname"],search_col: "ref_no"},
        enquiries: {first: ["first_name","surname"], second: ["mobile1"]},
        registrations: {first: ["first_name","surname"], second: ["email1"]},
        institutions: {first: ["name"], second: ["email"]},
        people: {first: ["first_name","surname"], second: ["email"]},
        all: {model: "all",first: ["title"], second: ["description"]},
    };
    return map["all"];
}
*/