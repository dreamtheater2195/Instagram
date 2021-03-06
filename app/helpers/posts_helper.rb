module PostsHelper

    def display_likes(post)
        votes = post.votes_for.up.by_type(User)
        return list_likers(votes) if votes.size <= 8
        count_likers(votes)
    end

    def liked_post(post)
        if current_user.voted_for? post
            link_to '', unlike_post_path(post.id), remote: true, id: "like_#{post.id}", class: "glyphicon like glyphicon-heart"
        else
            link_to '', like_post_path(post.id), remote: true, id: "like_#{post.id}", class: "glyphicon glyphicon-heart-empty"
        end
    end
    
    private

    def list_likers(votes)
        usernames = []
        unless votes.blank?
            votes.voters.each do |voter|
                usernames.push(link_to voter.username, profile_path(voter.username), class: 'user-name')
            end
            usernames.to_sentence.html_safe + like_plural(votes)
        end
    end

    def count_likers(votes) 
        vote_count = votes.size 
        vote_count.to_s + ' likes'
    end
    def like_plural(votes)
        return ' like this' if votes.count > 1
        ' likes this'
    end
end
