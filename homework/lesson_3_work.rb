#1
["Lorem", "ipsum", "dolor", "sit", "amet"].each.with_index do |body, index|
  user = User.create(name: 'Jan')
  Post.create(title: "Title #{index}", body: body.capitalize, user_id: user.id)
end
#4
Comment.all.each {|comment| puts comment.user.name }
#5
Post.joins(:user).where(users: { name: 'put name here' } )
#6
Comment.joins(:user).where(users: { name: 'put name here' } )
#7
Comment.joins(:user, :post).where(users: { name: 'put name here' }, posts: { title: 'put title here' } )
#8
Comment.create(content: 'Lorem ipsum dolor sit amet', created_at: Date.tomorrow, post_id: Post.last.id, user_id: User.last.id)
Comment.where('created_at < ?', Time.zone.now - 5.minutes).where('length(content) > 100')
