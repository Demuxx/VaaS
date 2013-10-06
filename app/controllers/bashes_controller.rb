class BashesController < ApplicationController
  before_action :set_bash, only: [:show, :edit, :update, :destroy]

  # GET /bashes
  # GET /bashes.json
  def index
    @bashes = Bash.all
  end

  # GET /bashes/1
  # GET /bashes/1.json
  def show
  end

  # GET /bashes/new
  def new
    @bash = Bash.new
  end

  # GET /bashes/1/edit
  def edit
  end

  # POST /bashes
  # POST /bashes.json
  def create
    params, raw = parse_params(bash_params)
    @bash = Bash.new(params)
    @bash.file_path = Rails.root.join("uploads", "bashes", "#{@bash.id}", raw.original_filename).to_s

    respond_to do |format|
      if @bash.save
        @bash.file_path = Rails.root.join("uploads", "bashes", "#{@bash.id}", raw.original_filename).to_s
        @bash.save!
        put_file(raw, @bash.file_path) if !raw.nil?

        format.html { redirect_to @bash, notice: 'Bash was successfully created.' }
        format.json { render action: 'show', status: :created, location: @bash }
      else
        format.html { render action: 'new' }
        format.json { render json: @bash.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bashes/1
  # PATCH/PUT /bashes/1.json
  def update
    params, raw = parse_params(bash_params)
    old_bash = @bash.dup
    respond_to do |format|
      if @bash.update(params)
        @bash.file_path = Rails.root.join("uploads", "bashes", "#{@bash.id}", raw.original_filename).to_s
        @bash.save!
        put_file(raw, @bash.file_path, old_bash.file_path) if !raw.nil?

        format.html { redirect_to @bash, notice: 'Bash was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @bash.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bashes/1
  # DELETE /bashes/1.json
  def destroy
    FileUtils.rm_rf(Rails.root.join("uploads", "bashes", "#{@bash.id}"))
    @bash.destroy
    respond_to do |format|
      format.html { redirect_to bashes_url }
      format.json { head :no_content }
    end
  end

  private
    def parse_params(params)
      raw = params.delete(:raw)
      params[:file] = raw.original_filename if !raw.nil?
      return [params, raw]
    end
    
    def put_file(binary, new_path, old_path=nil)
      puts "Deleting #{old_path}"
      FileUtils.rm_f(old_path) if !old_path.nil?
      FileUtils.mkdir_p(File.dirname(new_path))
      File.open(new_path, 'w') do |file|
        file.write(binary.read)
      end
    end
  
    # Use callbacks to share common setup or constraints between actions.
    def set_bash
      @bash = Bash.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bash_params
      params.require(:bash).permit(:name, :raw, :file, :file_path)
    end
end
