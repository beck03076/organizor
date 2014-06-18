module ActionPopulate  
     # ("enquiries",3)
    def create_emails_per_core(core_type,core_id,model)

      current_emails = []
      Email.populate 1..5 do |email|
        current_emails << email.id
        email.auto = @bool
        email.subject = Faker::Lorem.word
        email.body = Faker::Lorem.paragraph
        email.core = core_type
        email.created_at = @created
        email.created_by = @user
        email.from = Smtp.all.map &:name
        email.smtp_id = Smtp.ids
        email.signature = Faker::Lorem.sentence(3)
      end

      core_id_name = (core_type.singularize + "_id").to_sym
      email_model = model.camelize.constantize

      current_emails.each do |email_id|
        email_model.create! email_id: email_id,core_id_name => core_id
      end

      current_emails.size

    end 


    def create_todos_per_core(core_type,core_id,dummy)

      core_model = core_type.singularize.camelize

      todos_count = 0
      Todo.populate 1..5 do |todo|
        todos_count += 1
        todo.topic_id = @todo_topic
        todo.desc = Faker::Lorem.sentence
        todo.duedate = @near_future
        todo.created_by = @user
        todo.created_at = @created
        todo.assigned_to = @user
        todo.assigned_by = @user
        todo.done = @bool

        if todo.done
          todo.done_at = todo.duedate - 1.week
        end

        todo.title = Faker::Lorem.sentence
        todo.auto = @bool
        todo.todoable_type = core_model
        todo.todoable_id = core_id
      end

      todos_count

    end


    def create_follow_ups_per_core(core_type,core_id,dummy)

      core_model = core_type.singularize.camelize

      fus_count = 0
      FollowUp.populate 1..5 do |fu|
        fus_count += 1
        fu.title = Faker::Lorem.sentence
        fu.desc = Faker::Lorem.sentence
        fu.starts_at = @near_future
        fu.ends_at = fu.starts_at + 2.weeks
        fu.event_type_id = @event_type
        fu.venue =  Faker::Lorem.word
        fu.remind_before = [15,30,45,60]
        fu.created_by = @user
        fu.created_at = @created
        fu.assigned_to = @user
        fu.assigned_by = @user        
        fu.followed = @bool
        fu.auto = @bool

        if fu.followed
          fu.followed_at = fu.ends_at - 1.week
        end
        fu.follow_upable_type = core_model
        fu.follow_upable_id = core_id
      end

      fus_count
    end


    def create_notes_per_core(core_type,core_id,dummy)

      core_model = core_type.singularize.camelize

      notes_count = 0
      Note.populate 1..5 do |note|
        notes_count += 1
        note.content = Faker::Lorem.paragraph
        note.created_by = @user
        note.created_at = @created        
        note.auto = @bool
        note.noteable_type = core_model
        note.noteable_id = core_id
      end

      notes_count
    end
end    