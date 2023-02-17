users = [['Rafael', 'Guzman', 'rega1237', 'rafa@mail.com', '123456'], ['Juan', 'Perez', 'juperez', 'juan@mail.com', '123456'], ['Maria', 'Gomez', 'magomez', 'maria@mail.com', '123456']]

categories = ["General", "Ruby", "Python", "HTML", "CSS", "Javascript", "Typescript", "React"]

discussions = ['How to center a div?', 'How to create a table?', 'How to create a form?', 'What is the best way to learn Ruby?']

post = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus justo ipsum, ultricies ut fringilla hendrerit, posuere sit amet orci. Vivamus tellus lectus, interdum a urna vel, tincidunt dapibus ligula. Fusce eros magna, mollis quis scelerisque a, ornare in elit. Suspendisse.'

def create_users(users)
  puts 'Creating users...'
  users.each do |user|
    User.create(name: user[0], last_name: user[1], username: user[2], email: user[3], password: user[4])
  end
  puts 'Users created!'
end

def create_categories(categories)
  puts 'Creating categories...'
  categories.each do |category|
    Category.create(name: category)
  end
  puts 'Categories created!'
end

def create_discussions(discussions)
  puts 'Creating discussions...'
  bool = [true, false]
  discussions.each do |discussion|
    user = User.all.sample
    categorie = Category.all.sample
    Discussion.create(title: discussion, user_id: user.id, category_id: categorie.id, pinned: bool.sample, closed: bool.sample)
  end
  puts 'Discussions created!'
end

def create_post(post, discussions)
  puts 'Creating posts...'
  Discussion.all.each do |discussion|
    3.times do
      user = User.all.sample
      Post.create(body: post, user_id: user.id, discussion_id: discussion.id)
    end
  end
  puts 'Posts created!'
end

create_users(users)
create_categories(categories)
create_discussions(discussions)
create_post(post, discussions)
