$(function(){
        
        
         function submit_link(obj,tog){
           var name = $(obj).parent().find("input#name").val();
           var desc = $(obj).parent().find("textarea#desc").val();         
           
           if (name.length != 0){

           $.ajax({
                url: '/course_levels', //sumbits it to the given url of the form
                data:  {course_level: {name: name, desc: desc}},
                type: 'POST',
                dataType: "JSON" }).success(function(json){                
                var id = json.id;
                var name = json.name;
                $(obj).parent().find('.course_level_select').append('<option value=' + id + ' selected="selected">' + name + '</option>');
            });
            
            }
            $(tog).slideToggle();
            $("input#name").val('');
            $("textarea#desc").val('');
            return false; 
         }

});

