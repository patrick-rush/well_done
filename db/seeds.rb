require 'database_cleaner'

DatabaseCleaner.clean_with(:truncation)

# Seed Users
5.times do
    user = User.new
    user.full_name = Faker::Name.first_name + " " + Faker::Name.last_name
    user.email = Faker::Internet.email
    user.password = SecureRandom.urlsafe_base64
    user.save
end

# Seed Projects
25.times do
    project = Project.new
    project.title = Faker::NatoPhoneticAlphabet.code_word
    project.private = Faker::Boolean.boolean
    project.save 
end

# Seed Tasks
100.times do
    random_user_id = Faker::Number.within(range: 1..5)
    random_project_id = Faker::Number.within(range: 1..25)
    task = Task.new
    task.title = Faker::Verb.base.capitalize + " " + Faker::Food.dish
    task.completed = false
    task.due_date = Faker::Date.between(from: '2020-12-01', to: '2021-12-31')
    task.user_id = random_user_id
    task.project_id = random_project_id
    task.save
end

# Seed Friendships
10.times do
    friendship = Friendship.new
    friendship.user_id = Faker::Number.within(range: 1..5)
    friendship.friend_id = Faker::Number.within(range: 1..5)
    friendship.save
end

# Seed Comments
50.times do
    random_user_id = Faker::Number.within(range: 1..5)
    random_project_id = Faker::Number.within(range: 1..25)
    random_task_id = Faker::Number.within(range: 1..100)
    random_boolean = Faker::Boolean.boolean
    comment = Comment.new
    comment.content = Faker::Lorem.sentence(word_count: 5, supplemental: true, random_words_to_add: 5)
    comment.user_id = random_user_id
    if random_boolean
        comment.commentable_type = "Task"
        comment.commentable_id = random_task_id
    else
        comment.commentable_type = "Project"
        comment.commentable_id = random_project_id
    end
    comment.save
end