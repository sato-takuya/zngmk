class PostsController < ApplicationController
  require 'securerandom'

  #set_post、new_postを事前に行う
  before_action :authenticate_user!,except:[:element,:share]
  before_action :set_post, only: [:confirm, :edit, :update]
  before_action :new_post, only: [:show, :new]

  def show
    #showアクションが呼ばれた場合、new.html.erbを呼び出す
    render :new
  end

  # ④インスタンス生成はbefore_action :new_postに集約
  def new
  end

  def edit
  end

  def create
    #@postに入力したcontentが入っている。（id、pictureはまだ入っていない）
    @post = Post.new(post_params)
    # ⑤-2 idとして採番予定の数字を作成（現在作成しているidの次、存在しない場合は1を採番）
    if Post.last.present?
      next_id = Post.last.id + 1
    else
      next_id = 1
    end
    # ⑤-3 画像の生成メソッド呼び出し（画像のファイル名にidを使うため、引数として渡す）
    @post.user_id = current_user.id
    @post.image_secure = imagesecure()
    make_picture(@post.image_secure)

    if @post.save
      # ⑤-4 確認画面へリダイレクト
      redirect_to confirm_path(@post)
    else
      render :new
    end
  end

  def update
    if @post.update(post_params)
      make_picture(@post.image_secure)
      redirect_to confirm_path(@post)
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find_by(public_uid: params[:id])
    @post.destroy
    redirect_to root_path,notice: '投稿を削除しました'
  end

  #confirmアクションを追加
  def confirm
  end

  def element
    @post = Post.find_by(public_uid: params[:id])
  end

  def share
    @post = Post.find_by(public_uid: params[:id])
    render :element
  end

  #編集の場合、@postインスタンス作成
  private
  def set_post
    @post = Post.find_by(public_uid: params[:id])
  end

  #新規作成の場合、@postインスタンス作成
  def new_post
    @post = Post.new
  end

  def post_params
    params.require(:post).permit(:content, :picture,:user_id)
  end


  def imagesecure
    SecureRandom.hex(13)
  end

  #画像生成メソッド
  def make_picture(secure)
    sentense = ""
    #改行を消去
    content = @post.content.gsub(/\r\n|\r|\n/," ")
    #contentの文字数に応じて条件分岐
    if content.length <= 28 then
      #28文字以下の場合は7文字毎に改行
      n = (content.length / 7).floor + 1
      n.times do |i|
        s_num = i * 7
        f_num = s_num + 6
        range =  Range.new(s_num,f_num)
        sentense += content.slice(range)
        sentense += "\n" if n != i+1
      end
      pointsize = 90
    elsif content.length <= 50 then
      n = (content.length / 10).floor + 1
      n.times do |i|
        s_num = i * 10
        f_num = s_num + 9
        range =  Range.new(s_num,f_num)
        sentense += content.slice(range)
        sentense += "\n" if n != i+1
      end
      pointsize = 60
    else
      n = (content.length / 15).floor + 1
      n.times do |i|
        s_num = i * 15
        f_num = s_num + 14
        range =  Range.new(s_num,f_num)
        sentense += content.slice(range)
        sentense += "\n" if n != i+1
      end
      pointsize = 45
    end

    image = MiniMagick::Image.open("app/assets/images/white.png")

    image.combine_options do |i|
      i.font "app/assets/fonts/GenShinGothic-Normal.ttf"
      i.fill "#404040"
      i.gravity 'center'
      i.pointsize pointsize
      i.draw "text 0,0 '#{sentense}'"
    end
    # ⑨-12 保存先のストレージの指定。Amazon S3を指定する。
    storage = Fog::Storage.new(
      provider: 'AWS',
      aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'],
      aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
      region: 'ap-northeast-1'
    )
    # ⑨-13 開発環境or本番環境でS3のバケット（フォルダのようなもの）を分ける
    case Rails.env
      when 'production'
        # ⑨-14 バケットの指定・URLの設定
        bucket = storage.directories.get('zangemaker-production')
        # ⑨-15 保存するディレクトリ、ファイル名の指定（ファイル名は投稿id.pngとしています）
        png_path = 'images/' + secure.to_s + '.png'
        image_uri = image.path
        file = bucket.files.create(key: png_path, public: true, body: open(image_uri))
        @post.picture = 'https://s3-ap-northeast-1.amazonaws.com/zangemaker-production' + "/" + png_path
      when 'development'
        bucket = storage.directories.get('zangemaker-development')
        png_path = 'images/' + secure.to_s + '.png'
        image_uri = image.path
        file = bucket.files.create(key: png_path, public: true, body: open(image_uri))
        @post.picture = 'https://s3-ap-northeast-1.amazonaws.com/zangemaker-development' + "/" + png_path
    end
  end
end