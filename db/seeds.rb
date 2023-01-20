users = [['Rafael', 'Guzman', 'rega1237', 'rafa@mail.com', '123456'], ['Juan', 'Perez', 'juperez', 'juan@mail.com', '123456'], ['Maria', 'Gomez', 'magomez', 'maria@mail.com', '123456']]

discussions = ['How to center a div?', 'How to create a table?', 'How to create a form?', 'What is the best way to learn Ruby?']

post = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus justo ipsum, ultricies ut fringilla hendrerit, posuere sit amet orci. Vivamus tellus lectus, interdum a urna vel, tincidunt dapibus ligula. Fusce eros magna, mollis quis scelerisque a, ornare in elit. Suspendisse.'

def create_users(users)
  puts 'Creating users...'
  users.each do |user|
    User.create(name: user[0], last_name: user[1], username: user[2], email: user[3], password: user[4])
  end
  puts 'Users created!'
end

def create_discussions(discussions)
  puts 'Creating discussions...'
  discussions.each do |discussion|
    user = User.all.sample
    Discussion.create(title: discussion, user_id: user.id)
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
create_discussions(discussions)
create_post(post, discussions)
