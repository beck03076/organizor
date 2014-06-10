
 
  <% ctnt = (render 'compare_users_modal') %>
  <% btn = button_tag "Compare", {class: "btn btn-primary", 
                                  onclick: "compareUsers('compare_user_ids',this);",
                                  data: {link: @link} } %>
 
  $('#compare-users-container').html("<%= escape_javascript(render :partial => 'shared/modal',
                                           :locals =>   {id: 'resource-compare', 
                                                         content: ctnt.html_safe,
                                                         header: 'Compare',
                                                         button: btn}) %>");
  
  $('#resource-compare').modal('show');

