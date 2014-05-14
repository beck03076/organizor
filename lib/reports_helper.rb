module ReportsHelper
    # default filters for enquiries module
	def def_enq_fil
		[:first_name,:surname,:mobile1,:email1,:gender,:date_of_birth,:score,:nationality,
		:channel,:status,:registered,:source,
		:branch,:owner,:updated_at,:created_at]		
	end

	def real_enq_cols
		{# defaults
		 first_name: 0,surname: 0,mobile1: 0,
		 email1: 0,gender: ["select",["male","female"], :gender],date_of_birth: "datepicker",
		 score: 0,nationality: ["collection_select","Country",nil,:country_id],
		 # associations
		 source: ["collection_select","StudentSource",nil, :source_id] ,
		 channel: ["collection_select","ContactType",:name,:contact_type_id],
		 status: ["collection_select","EnquiryStatus",nil,:status_id],
		 registered: ["select",[true,false],:registered], 		 
		 branch: ["collection_select","Branch",nil,:branch_id],
		 # history
		 owner: ["collection_select","User",:first_name,:assigned_to],
		 updated_at: "datepicker",
		 created_at: "datepicker"
		}
	end

	def enq_pie_val
		%w(student_source country contact_type branch enquiry_status user)
	end

	def enq_bar

	end


end