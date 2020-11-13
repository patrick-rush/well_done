module TasksHelper

    def readable_due_date(object)
        object.due_date.strftime("%b %d, %Y")
    end
    
end
