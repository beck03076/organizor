module ReportsData
	#=== Enquiries =====================================
    # default filters for enquiries module
	def def_enq_fil
		[:first_name,:surname,:mobile1,:email1,:gender,:date_of_birth,:score,:nationality,
		:channel,:status_name,:registered,:source,
		:branch_name,:owner,:updated_at,:created_at]		
	end

	def real_enq_cols
		{# defaults
		 first_name: 0,surname: 0,mobile1: 0,
		 email1: 0,gender: ["select",["M","F"], :gender],date_of_birth: "datepicker",
		 score: 0,nationality: ["collection_select","Country",nil,:country_id],
		 # associations
		 source: ["collection_select","StudentSource",nil, :source_id] ,
		 channel: ["collection_select","ContactType",:name,:contact_type_id],
		 status_name: ["collection_select","EnquiryStatus",nil,:status_id],
		 registered: ["select",[true,false],:registered], 		 
		 branch_name: ["collection_select","Branch",nil,:branch_id],
		 # history
		 owner: ["collection_select","User",:first_name,:assigned_to],
		 updated_at: "datepicker",
		 created_at: "datepicker"
		}
	end

	def enq_pie_val
		%w(student_source country contact_type branch enquiry_status user)
	end

	def enq_bar_split_val
		[["Registered","reg"],["Score","sco"]]
	end

	def enq_bar_split(val = "sco")
		case val 
		when "sco"
			["sco",[['Low',[1,3]],
			        ['Medium',[4,6]],
			        ['High',[7,10]]
			       ]
			]       
		when "reg"
			["reg",[['Registered',true],
			        ['Unregistered',false]
			       ]
			]  
		end
	end
    #=== Registrations =====================================
	# default filters for registrations module
	def def_reg_fil
		[:ref_no,:first_name,:surname,:mobile1,:email1,:gender,
		 :address_post_code,:address_city,:address_post_code,
		 :qualification,:qua_subject,:qua_institution,:qua_exam,
		 :passport_number,:branch_name,:owner,:updated_at,:created_at,
		 :passport_valid_till, :visa_valid_till,:associations ]		
	end

	def real_reg_cols
		{# defaults
		 ref_no: 0,	
		 first_name: 0,surname: 0,mobile1: 0,
		 email1: 0,gender: ["select",["M","F"], :gender],date_of_birth: "datepicker",
		 branch_name: ["collection_select","Branch",nil,:branch_id],
		 nationality: ["collection_select","Country",nil,:country_id],
		 address_city: 0,address_post_code: 0,
		 qualification: ["collection_select","Qualification",nil,:qua_id],
		 qua_subject: 0, qua_institution: 0, qua_grade: 0, qua_exam: 0,qua_score: 0,
		 # ph stands for placeholder
		 passport_valid_till: { range_col: "passport_valid_till",
		 	         			cols: %w(passport_number),
		 	         			title: "Passport",
		 	         			cl: "datepicker",
		 	         			ph: "Passport Valid"
		 	       			  },
		 visa_valid_till: {     range_col: "visa_valid_till",
		 	         			cols: %w(visa_type),
		 	         			title: "Visa",
		 	         			cl: "datepicker",
		 	         			ph: "Visa Valid"
		 	         	  }, 
		 # associations
		 associations: [{title: "Programmes",
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
								ins_ref_no: 0 }
						 },
						 {title: "Institutions",
		 	             table: "institutions", 
		 	             cols: {name: 0,
		 	             	    city: ["collection_select","City",nil,:institutions_city_id],
		 	             	    country: ["collection_select","Country",nil,:institutions_country_id],
		 	             	    type: ["collection_select","InstitutionType",nil,:institutions_type_id],
								updated_at: "datepicker<" }
						 },	
						 {title: "Exams",
		 	             table: "proficiency_exams", 
		 	             cols: {
		 	             	    english_level: ["collection_select","EnglishLevel",nil,:exams_eng_level_id],	
		 	             	    exam_type: ["collection_select","ExamType",nil,:exams_exam_type_id],	             	  
							   }
						 },	
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
								}
						 },
						 {title: "Commission",
		 	             table: "fee", 
		 	             cols: {	 	       		       	  
								commission_amount: {  
		 	             	    	           cols: %w(fee_commission_percentage),
		 	             	    	           range_col: "fee_commission_amount",
		 	             	    	           type: "range",
								 	           ph: "Commission Amount",
								 	           cl: "",
								 	       	}, 	       	     	  
							   }
						 },			
		               ],		 		 
		 # history
		 owner: ["collection_select","User",:first_name,:assigned_to],
		 updated_at: "datepicker",
		 created_at: "datepicker"
		}
	end

	def reg_pie_val
		%w(contact_type branch user)
	end

	def reg_bar_split_val
		[["Registered","reg"],["Score","sco"]]
	end

	def reg_bar_split(val = "sco")
		case val 
		when "sco"
			["sco",[['Low',[1,3]],
			        ['Medium',[4,6]],
			        ['High',[7,10]]
			       ]
			]       
		when "reg"
			["reg",[['Registered',true],
			        ['Unregistered',false]
			       ]
			]  
		end
	end


end