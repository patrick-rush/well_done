# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# 5.times do
#     user = User.new
#     user.first_name = Faker::Name.first_name
#     user.last_name = Faker::Name.last_name
# end

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
    random_id = Faker::Number.within(range: 1..5)
    random_boolean = Faker::Boolean.boolean
    project = Project.new
    project.title = Faker::Job.position
    project.private = Faker::Boolean.boolean
    if random_boolean
        project.status = "open"
    else
        project.status = "closed"
    end
    project.creator_id = random_id
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