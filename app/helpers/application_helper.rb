module ApplicationHelper
  def get_twitter_card_info(post)
    twitter_card = {}
    if post.present?
        twitter_card[:url] = "https://www.zangemaker.com/posts/#{post.public_uid}"
        twitter_card[:image] = "https://s3-ap-northeast-1.amazonaws.com/zangemaker-production/images/#{post.image_secure}.png"
        twitter_card[:description] = "#{post.content}"
        twitter_card[:title] = "懺悔メーカー【タップして罪を許す】"
    else
      twitter_card[:url] = 'https://www.zangemaker.com/'
      twitter_card[:image] = "https://s3-ap-northeast-1.amazonaws.com/zangemaker-production/images/logo.png"
      twitter_card[:description] = "日々の懺悔を画像付きでツイート"
      twitter_card[:title] = "懺悔メーカー"
    end
    twitter_card[:card] = 'summary_large_image'
    twitter_card
  end
end