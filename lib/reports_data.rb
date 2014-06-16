module ReportsData
	#=== Users =====================================
    # default filters for enquiries module
	def def_use_fil
		[:first_name,:surname,:mobile,:email,:gender,:date_of_birth,
		:branch_name,:updated_at,:created_at,:associations]		
	end

	def real_use_cols
		{# defaults
		 first_name: 0,surname: 0,mobile: 0,
		 email: 0,gender: ["select",["m","f"], :gender],date_of_birth: "datepicker",
		 # associations		 	 
		 branch_name: ["collection_select","Branch",nil,:branch_id],
		 # history
		 updated_at: "datepicker",
		 created_at: "datepicker",
		   # associations
		 associations: [
						follow_ups,
						todos,
						emails,
						enquiries,
						registrations,
						programmes
					   ] 
		}
	end

	def use_pie_val
		%w(branch role permission)
	end

	def use_bar_split_val
		[["Role","rol"]]
	end

	def use_bar_split(val = "rol")
		case val 
		when "rol", "def"
			[:role_id]       		
		end
	end

	#=== Single Users =====================================
	%w(def_use_fil real_use_cols use_pie_val use_bar_split_val use_bar_split).each do |i| 
      alias_method i.gsub(/use/,'sin').to_sym, i.to_sym
    end 
    #======================================================

    #=== People =====================================
    # default filters for people module
	def def_peo_fil
		[:first_name,:surname,:mobile,:email,:work_phone,:home_phone,:gender,:institution_name,
		 :country_name,:city_name,:type_name,:owner,:creator,:created_at,:updated_at,:associations]		
	end

	def real_peo_cols
		{# defaults
		 first_name: 0,surname: 0,mobile: 0,email: 0,work_phone: 0,home_phone: 0,
		 gender: ["select",["m","f"], :gender],
		 country_name: ["collection_select","Country",nil,:country_id],
		 city_name: ["collection_select","Country",nil,:city_id],
		 # associations
		 type_name: ["collection_select","PersonType",nil, :type_id],
		 institution_name: ["collection_select","Institution",nil, :institution_id],		 
		 # history
		 owner: owner,
		 creator: creator,
		 updated_at: updated_at,
		 created_at: created_at,
		  # associations
		 associations: [
						follow_ups,
						todos,
						emails
					   ] 
		}
	end

	def peo_pie_val
		%w(institution person_type country city)
	end

	def peo_bar_split_val
		[]
	end

	def peo_bar_split(val = "sub")
		nil
	end
    #======================================================

    #=== Institutions =====================================
    # default filters for institutions module
	def def_ins_fil
		[:name,:email,:phone,:fax,:website,:address_line1,:address_line2,:address_post_code,
	     :city,:country,:type,:group,:poc,
	     :owner,:created_at,:updated_at,:associations]		
	end

	def real_ins_cols
		{# defaults
		 name: 0,email: 0,phone: 0,fax: 0,website: 0,address_line1: 0,address_line2: 0,address_post_code: 0,
		 country_name: ["collection_select","Country",nil,:country_id],
		 city_name: ["collection_select","Country",nil,:city_id],
		 # associations
		 type_name: ["collection_select","InstitutionType",nil, :type_id],
		 group_name: ["collection_select","InstitutionGroup",nil, :group_id],
		 poc: ["collection_select","Person",:first_name, :person_id],
		 # history
		 owner: owner,
		 creator: creator,
		 updated_at: updated_at,
		 created_at: created_at,
		  # associations
		 associations: [
						follow_ups,
						todos,
						emails,
						programmes,
						fees,
						commissions						
					   ] 
		}
	end

	def ins_pie_val
		%w(institution_type institution_group)
	end

	def ins_bar_split_val
		[["Statuses","sta"],["CourseLevels","cou"]]
	end

	def ins_bar_split(val = "sta")
		case val 
		when "sta", "def"
			[{programmes: [:application_status]},:application_status,:name]       
		when "cou"
			[{programmes: [:course_level]},:course_level,:name]        
		end
	end
    #======================================================

	#=== Enquiries =====================================
    # default filters for enquiries module
	def def_enq_fil
		[:first_name,:surname,:mobile1,:email1,:gender,:score,:nationality,
		:channel,:status_name,:registered,:source,
		:branch_name,:owner,:date_of_birth,:updated_at,:created_at,:associations]		
	end

	def real_enq_cols
		{# defaults
		 first_name: 0,surname: 0,mobile1: 0,
		 email1: 0,gender: ["select",["m","f"], :gender],date_of_birth: "datepicker",
		 score: 0,nationality: ["collection_select","Country",nil,:country_id],
		 # associations
		 source: ["collection_select","StudentSource",nil, :student_source_id] ,
		 channel: ["collection_select","ContactType",:name,:contact_type_id],
		 status_name: ["collection_select","EnquiryStatus",nil,:status_id],
		 registered: ["select",[true,false],:registered], 		 
		 branch_name: ["collection_select","Branch",nil,:branch_id],
		 # history
		 owner: owner,
		 creator: creator,
		 date_of_birth: date_of_birth,		 
		 updated_at: updated_at,
		 created_at: created_at,
		  # associations
		 associations: [{title: "Preferred Countries",
		 	             table: "preferred_countries", 
		 	             cols: {countries: ["collection_select","Country",nil,:preferred_countries_country_id]},
						 logo: "plane"},
						follow_ups,
						todos,
						emails,
						programmes				 
						] 
		}
	end

	def enq_pie_val
		%w(student_source contact_type branch user sub_agent enquiry_status country_of_origin )
	end

	def enq_bar_split_val
		[["Registered","reg"],["Score","sco"]]
	end

	def enq_bar_split(val = "sco")
		case val 
		when "sco", "def"
			[:score]       
		when "reg"
			[:registered]  
		end
	end
    #=== Registrations =====================================
    def reg_pie_val
		%w(student_source contact_type branch user sub_agent country qualification progression_status)
	end

	def reg_bar_split_val
		[["Statuses","sta"],["CourseLevels","cou"],["ExamTypes","exa"],["EnglishLevels","eng"]]
	end

	def reg_bar_split(val)
		case val 
		when "sta", "def"
			[{programmes: [:application_status]},:application_status,:name]       
		when "cou"
			[{programmes: [:course_level]},:course_level,:name]        
		when "exa"
			[{proficiency_exams: [:exam_type]},:exam_type,:name]        	
		when "eng"
			[{proficiency_exams: [:english_level]},:english_level,:name]        		
		end
	end


	# default filters for registrations module
	def def_reg_fil
		[:ref_no,:first_name,:surname,:mobile1,:email1,:gender,
		 :address_post_code,:address_city,
		 :channel,:source,:branch_name,:owner,
		 :progression_status_name,:qualification_name,:qua_subject,
		 :qua_institution,:qua_grade,:qua_exam,:qua_score,
		 :branch_name,:owner,:passport_number,:visa_type,:date_of_birth,
		 :updated_at,:created_at,:passport_valid_till,
		 :visa_valid_till,:associations ]		
	end

	def real_reg_cols
		{# defaults
		 ref_no: 0,	
		 first_name: 0,surname: 0,mobile1: 0,
		 email1: 0,gender: ["select",["m","f"], :gender],date_of_birth: "datepicker",
		 # associations
		 source: ["collection_select","StudentSource",nil, :student_source_id] ,
		 channel: ["collection_select","ContactType",:name,:contact_type_id],
		 branch_name: ["collection_select","Branch",nil,:branch_id],
		 owner: owner,
		 creator: creator,
		 branch_name: ["collection_select","Branch",nil,:branch_id],
		 nationality: ["collection_select","Country",nil,:country_id],
		 progression_status_name: ["collection_select","ProgressionStatus",nil,:progression_status_id],
		 address_city: 0,address_post_code: 0,
		 qualification_name: ["collection_select","Qualification",nil,:qualification_id],
		 qua_subject: 0, qua_institution: 0, qua_grade: 0, qua_exam: 0,qua_score: 0,
		 passport_number: 0, visa_type: 0,
		 # ph stands for placeholder
		 passport_valid_till: { range_col: "passport_valid_till",
		 	         			cols: {passport_valid_till: 0},
		 	         			title: "Passport Validity",
		 	         			cl: "datepicker",
		 	         			ph: "Passport Valid",
		 	         			logo: "book"
		 	       			  },
		 visa_valid_till: {     range_col: "visa_valid_till",
		 	         			cols: {visa_valid_till: 0},
		 	         			title: "Visa Validity",
		 	         			cl: "datepicker",
		 	         			ph: "Visa Valid",
		 	         			logo: "plane"
		 	         	  }, 
		 # associations
		 associations: [programmes,
						 institutions,	
						 {title: "Exams",
		 	             table: "proficiency_exams", 
		 	             cols: {
		 	             	    english_level: ["collection_select","EnglishLevel",nil,:exams_eng_level_id],	
		 	             	    exam_type: ["collection_select","ExamType",nil,:exams_exam_type_id],	             	  
							   },
					     logo: "font"		   
						 },	
						 fees,
						 commissions,		
						follow_ups,
						todos,
						emails	
		               ],		 		 
		 # history
		 owner: owner,
		 date_of_birth: date_of_birth,		 
		 updated_at: updated_at,
		 created_at: created_at,
		}
	end




	#========== General Useable Hashed like Actions(FollowUps Todos Emails) ===========




    def emails
    	{title: "Emails",
	         table: "emails", 
	         cols: {subject: 0,
	         	    created_at: {  
	         	    	           cols: [],
	         	    	           range_col: "emails_created_at",
	         	    	           cl: "datepicker",
				 	           ph: "Email Sent At"
				 	       	},
				 created_by: ["collection_select","User",:first_name,:emails_created_by],
				 sent_from: ["collection_select","Smtp",nil,:emails_smtp_id],	  								 
				},
	         logo: "envelope"
		 }
    end

    def todos
    	{title: "Todos",
             table: "todos", 
             cols: {title: 0,
             	    duedate: {  
             	    	           cols: [],
             	    	           range_col: "todos_duedate",
             	    	           cl: "datepicker",
				 	           ph: "Todo Duedate"
				 	       	},
				 created_by: ["collection_select","User",:first_name,:todos_created_by],
				 assigned_to: ["collection_select","User",:first_name,:todos_assigned_to],	  
				 done: ["select",[true,false],:todos_done],	     	
				},
             logo: "check"
		 }
    end

    def follow_ups
    	{title: "FollowUps",
	         table: "follow_ups", 
	         cols: {title: 0,
	         	    starts_at: {  
	         	    	           cols: [],
	         	    	           range_col: "follow_ups_starts_at",
	         	    	           cl: "datepicker",
				 	           ph: "Follow Up Starts At"
				 	       	},
				 ends_at: {  
	         	    	           cols: [],
	         	    	           range_col: "follow_ups_ends_at",
	         	    	           cl: "datepicker",
				 	           ph: "Follow Up Ends At"
				 	       	},
				 venue: 0,
				 event_type: ["collection_select","EventType",nil,:follow_ups_event_type_id],
				 created_by: ["collection_select","User",:first_name,:follow_ups_created_by],
				 assigned_to: ["collection_select","User",:first_name,:follow_ups_assigned_to],	  
				 followed: ["select",[true,false],:follow_ups_followed],	     	
				},
	         logo: "calendar"
		 }

    end

    def institutions
    	{title: "Institutions",
             table: "institutions", 
             cols: {name: 0,
             	    city: ["collection_select","City",nil,:institutions_city_id],
             	    country: ["collection_select","Country",nil,:institutions_country_id],
             	    type: ["collection_select","InstitutionType",nil,:institutions_type_id],
				},
         logo: "home"				 
		 }
	end	 

	def owner
	  ["collection_select","User",:first_name,:assigned_to]
	end

	def creator
	  ["collection_select","User",:first_name,:created_by]
	end
	
	def date_of_birth  
		{ range_col: "date_of_birth",		 	           
		 	           title: "Date Of Birth",
		 	           cl: "datepicker",
		 	           ph: "Date Of Birth",
		 	           logo: "gift",
		 	           cols: []
		}
	end
	
	def updated_at	
		{ range_col: "updated_at",		 	           
	       title: "Updated",
	       cl: "datepicker",
	       ph: "Last Modified At",
	       logo: "time",
	       cols: {updated_at: 0},
		}
	end
	
	def created_at	
		{ range_col: "created_at",		 	           
           title: "Created",
           cl: "datepicker",
           ph: "Created At",
           logo: "time",
           cols: {created_at: 0},
		}
	end	

	def programmes
		{title: "Course",
	         table: "programmes", 
	         cols: {status: ["collection_select","ApplicationStatus",nil,:programmes_app_status_id],		 	             	    
	         	    created_by: ["collection_select","User",:first_name,:programmes_created_by],
	         	    course_level: ["collection_select","CourseLevel",nil,:programmes_level_id], 
	         	    course_subject_text: 0,
	         	    start_date: {  
	         	    	           cols: [],
	         	    	           range_col: "programmes_start_date",
	         	    	           cl: "datepicker",
				 	           ph: "Course Start Date"
				 	       	},
				updated_at: "datepicker<",
				ins_ref_no: 0 },
		 logo: "certificate"		
		 }
	end

	def fees
		{title: "Fees",
	         table: "fee", 
	         cols: {
	         	    tuition_fee: {  
	         	    	           cols: [],
	         	    	           range_col: "fee_tuition_fee",
	         	    	           type: "range",
				 	           ph: "Tuition Fee",
				 	           cl: "",
				 	       	}, 
				scholarship: {  
	         	    	           cols: [],
	         	    	           range_col: "fee_scholarship",
	         	    	           type: "range",
				 	           ph: "Scholarship",
				 	           cl: "",
				 	       	},  
				invoice_date: {  
	         	    	           cols: [],
	         	    	           range_col: "fee_invoice_date",
	         	    	           type: "range",
				 	           ph: "Invoice Date",
				 	           cl: "datepicker",
				 	       	},  	       	
				},
	     logo: "euro"			
		 }
	end

	def commissions
		{title: "Commission",
             table: "fee", 
             cols: {	 
                    commission_percentage: {  
             	    	           cols: [],
             	    	           range_col: "fee_commission_percentage",
             	    	           type: "range",
				 	           ph: "Commission Percentage",
				 	           cl: "",
				 	       	}, 	 	       		       	  
				commission_amount: {  
             	    	           cols: [],
             	    	           range_col: "fee_commission_amount",
             	    	           type: "range",
				 	           ph: "Commission Amount",
				 	           cl: "",
				 	       	}, 	       	     	  
			   },
		 logo: "gbp"	   
		 }
	end

	def range_no(col,ph = col,cl = "")
		{ 
	       cols: [],
	       range_col: col,
	       type: "range",
		   ph: col.titleize,
		   cl: cl,
		}

	end

	def enquiries
		{title: "Enquiry",
	         table: "enquiries", 
	         cols: {status: ["collection_select","EnquiryStatus",nil,:enquiries_status_id],		 	             	    
	         	    updated_at: updated_at,
	         	    created_at: created_at,
	         	    score: 0,
	         	    conversion_time: range_no("enquiries_conversion_time"),
	         	    impressions_count: range_no("enquiries_impressions_count"),
	         	    response_time: range_no("enquiries_response_time")
	         	   },
	      logo: "earphone"   	     	
		 }
	end

	def registrations
		{title: "Registration",
	         table: "registrations", 
	         cols: {status: ["collection_select","ApplicationStatus",nil,:registrations_programmes_app_status_id],		 	             	    
	         	    updated_at: updated_at,
	         	    created_at: created_at,	         	    
	         	    conversion_time: range_no("registrations_conversion_time"),
	         	    impressions_count: range_no("registrations_impressions_count"),
	         	    response_time: range_no("registrations_response_time") 	
	         	   },
	      logo: "pencil"
		 }
	end

	def programmes
		{title: "Programmes",
	         table: "programmes", 
	         cols: {institution: ["collection_select","Institution",nil,:programmes_institution_id],		 
	                course_level: ["collection_select","CourseLevel",nil,:programmes_level_id],		 	             	    
	         	   },  
	     logo: "certificate"    	   	
		 }
	end





    #==================================================================================

	


end