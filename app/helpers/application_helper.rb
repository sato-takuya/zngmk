module ApplicationHelper
  def get_twitter_card_info(post)
    twitter_card = {}
    if post.present?
      if post.to_element.true?
      twitter_card[:url] = "https://zngmk.herokuapp.com/posts/#{post.public_uid}"
      twitter_card[:image] = "https://s3-ap-northeast-1.amazonaws.com/zangemaker-production/images/#{post.image_secure}.png"
      twitter_card[:description] = "#{post.content}"
      post.to_element = false
      else
        twitter_card[:url] = 'https://zngmk.herokuapp.com/'
        twitter_card[:image] = "https://s3-ap-northeast-1.amazonaws.com/zangemaker-production/images/red.jpg"
        twitter_card[:description] = "日々の懺悔を画像付きでツイート"
      end
    else
      twitter_card[:url] = 'https://zngmk.herokuapp.com/'
      twitter_card[:image] = "https://s3-ap-northeast-1.amazonaws.com/zangemaker-production/images/logo.png"
      twitter_card[:description] = "日々の懺悔を画像付きでツイート"
    end
    twitter_card[:title] = "懺悔メーカー"
    twitter_card[:card] = 'summary_large_image'
    twitter_card
  end
end