class KeysController < ApplicationController
  before_action :set_key, only: [:show, :edit, :update, :destroy]

  # GET /keys
  # GET /keys.json
  def index
    @keys = Key.all
  end

  # GET /keys/1
  # GET /keys/1.json
  def show
  end

  # GET /keys/new
  def new
    @key = Key.new
  end

  # GET /keys/1/edit
  def edit
  end

  # POST /keys
  # POST /keys.json
  def create
    @key = Key.generate(key_params[:name], key_params[:password])

    respond_to do |format|
      if @key.save
        path = Rails.root.join("uploads", "keys", "#{@key.id}")
        FileUtils.mkdir_p(path)
        @key.private_path = path.join("private").to_s
        File.open(@key.private_path, 'w') do |file|
          file.write @key.private
        end
        FileUtils.chmod 0700, @key.private_path
        
        @key.public_path = path.join("public").to_s
        File.open(@key.public_path, 'w') do |file|
          file.write @key.public
        end
        
        @key.save!
        
        format.html { redirect_to @key, notice: 'Key was successfully created.' }
        format.json { render action: 'show', status: :created, location: @key }
      else
        format.html { render action: 'new' }
        format.json { render json: @key.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /keys/1
  # DELETE /keys/1.json
  def destroy
    
    @key.destroy
    respond_to do |format|
      format.html { redirect_to keys_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_key
      @key = Key.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def key_params
      params.require(:key).permit(:name, :password)
    end
end
