class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    @post.data_hora = Time.new.inspect

    respond_to do |format|
      if @post.save

        enviar_push_silencioso @post.token

        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # GET /random.json
  def random
    @posts = []

    todos_os_posts = Post.basic

    if todos_os_posts.size > 0
      for i in todos_os_posts
        formata_post = {}
        formata_post[:data_hora] = Time.now.inspect
        formata_post[:comments] = i[:comments]
        formata_post[:autor] = i[:autor]
        formata_post[:imagem] = ActionController::Base.helpers.asset_path('face.jpg')
        @posts << formata_post
      end
      Post.delete_all
    else
      # interage em cada agenda e formata o objeto de saida
      for i in 1..rand(1..3)
        post = monta_hash_post
        @posts << post
      end
    end

    respond_to do |format|
      format.json { render json: @posts }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:imagem, :data_hora, :autor, :comments, :token)
    end

    def enviar_push_silencioso(token)
      # troque pelo seu certificado PEM
      # detalhes de como gerar em: https://developer.apple.com/notifications/
      APNS.pem = "#{Rails.root}/config/apple_apns/cert.pem"

      # push minimo para silent push
      n1 = APNS::Notification.new(token, :content_available => :true)

      # descomente a linha para enviar um push normal
      # n1 = APNS::Notification.new(token, :alert => 'Novo post disponível!', :badge => 1, :sound => 'default')
      APNS.send_notifications([n1])
    end

    # Monta uma hash contendo dados aleatorios para simular um post
    # Imagem gerada a partir do servico http://lorempixel.com
    def monta_hash_post

      dados_post = {:imagem => "http://lorempixel.com/200/200/sports/"}
      dados_post[:data_hora] = Time.new.inspect
      dados_post[:autor] = nome_aleatorio
      dados_post[:comments] = Lipsum.new(false).words[rand(10..20)].to_s

      dados_post
    end

    # Gera um nome aleatorio
    # Nomes gerados por http://behindthename.com
    def nome_aleatorio
      nomes = ["Marcelo", "Quirino", "Antônia", "Maristela", "Estevão", "Xandinho", "Rosa", "Vitória", "Beatriz", "Amancio", "Dinis"]
      sobre_nomes = ["Guerra", "Santiago", "Salazar", "Pinheiro", "Achilles", "Fernandes", "Victor", "Garcia", "Crespo", "Fernandes", "Dcruze"]

      "#{nomes.sample} #{sobre_nomes.sample}"
    end
end
