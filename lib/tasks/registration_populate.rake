module RegistrationPopulate

  def set_ref_no
        # creating new reference number logic
        ref_temp = (Registration.select("max(ref_no) as ref_no").map &:ref_no)[0]
        ref_temp_no = ref_temp.nil? ? "0000" : ref_temp.to_s[4..7]
        ym = Time.now.strftime("%y%m").to_s
        ym + "%04d" % (ref_temp_no.to_i + 1)
  end

	def start_registration_populate			
		    p "Started populating registrations"
		    Enquiry.where(registered: true).all.each do |enq|
		      Registration.populate 1 do |r|	
		          r.enquiry_id = enq.id		      
		      	  r.ref_no = set_ref_no
			      r.first_name = enq.first_name
			      r.surname = enq.surname
			      r.mobile1 = enq.mobile1
			      r.mobile2 = enq.mobile2
			      r.email1 = enq.email1
			      r.email2 = enq.email2
			      r.gender = enq.gender
			      r.date_of_birth  = enq.date_of_birth
			      r.assigned_to = enq.assigned_to
			      r.created_by = enq.registered_by
			      r.assigned_by = r.created_by
			      r.created_at = enq.registered_at || Time.now
			      r.country_id = enq.country_id
			      r.branch_id = enq.branch_id
			      r.assigned_at = enq.created_at || Time.now
			      r.contact_type_id = enq.contact_type_id 
			      r.student_source_id = enq.student_source_id
			      r.sub_agent_id = enq.sub_agent_id	

			      User.current = User.first
			      enq.programmes.each do |prog|
				      	prog.tap do |p|
					      	#current_prog = prog.attributes.except("id","created_at","updated_at","conversion_time")
					      	p.registration_id = r.id
					      	p.app_status_id = @app_status.sample
					      	p.created_at = rand(@created)
					      	p.ins_ref_no = Faker::Number.number(10)
					      	p.claim_status_id = @claim_status.sample
					      	p.p_fee_id = @p_fee.sample
					      	p.p_fee_status_id = @p_fee_status.sample
					      	p.p_fee_cents = rand(4500..20000)
					      	p.p_fee_bank_details = Faker::Lorem.paragraph(2)						      					      	
				        end		
				        p r.first_name	  				        
				        prog.save 

				        if Programme.joined?(prog.app_status_id)
				        	p "==="
				        	p "Joined"

					        Fee.populate 1 do |f|
					        	f.tuition_fee_cents = (1000000..9000000)
					        	f.commission_percentage = (8..27)
					        	f.programme_id = prog.id
					        	f.scholarship_cents = (100000..800000)
					        	f.commission_amount_cents = (f.tuition_fee_cents - f.scholarship_cents ) / f.commission_percentage
					        	f.created_at = r.created_at + 1.month
					        	f.invoice_date = f.created_at + 1.month
					        	f.first_payment_date = f.invoice_date + 1.month
					       
					        		@current_pay = f.commission_amount_cents / 3 
					        		Commission.populate 1 do |c|
					        			c.paid_cents = @current_pay
					        			f.commission_paid_cents = c.paid_cents				        			

					        			c.fee_id = f.id
					        			c.created_at = f.first_payment_date

					        			@one = f.commission_amount_cents - c.paid_cents					        			
					        			c.remaining_cents = @one

					        			c.status_id = CommissionStatus.find_by_name("partially paid").id
					        		end

					        		if @bool.sample
					        			Commission.populate 1 do |c|
					        			 c.paid_cents = @current_pay
					        			 f.commission_paid_cents = f.commission_paid_cents + c.paid_cents				        								        			 

					        			 c.fee_id = f.id
					        			 c.created_at = f.first_payment_date + 1.week					        			 
					        			 
					        			 @two = @one - @current_pay
					        			 c.remaining_cents = @two

					        			 c.status_id = CommissionStatus.find_by_name("partially paid").id
					        			 @two_run = true
					        		    end
					        		end

					        		if @two_run
					        			Commission.populate 1 do |c|
					        			 c.paid_cents = @current_pay
					        			 f.commission_paid_cents = f.commission_paid_cents + c.paid_cents

					        			 c.fee_id = f.id
					        			 c.created_at = f.first_payment_date + 2.weeks					        			 
					        			 
					        			 c.remaining_cents = @two - @current_pay
					        			 c.status_id = CommissionStatus.find_by_name("fully paid").id
					        		    end
					        		    @two_run = false
					        		end				        	
					        end	      
					    end
			      end    

			      %w(emails todos follow_ups notes).each do |a|
			      	p "--#{a}--"	
			        r.send(a + '_count=',send('create_' + a + '_per_core',"registrations",r.id,"emails_registration"))
			      end 
			  end      
		    end
	end

end