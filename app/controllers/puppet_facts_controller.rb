class PuppetFactsController < ApplicationController
  before_action :set_puppet_fact, only: [:show, :edit, :update, :destroy]

  # GET /puppet_facts
  # GET /puppet_facts.json
  def index
    @puppet_facts = PuppetFact.all
  end

  # GET /puppet_facts/1
  # GET /puppet_facts/1.json
  def show
  end

  # GET /puppet_facts/new
  def new
    @puppet_fact = PuppetFact.new
  end

  # GET /puppet_facts/1/edit
  def edit
  end

  # POST /puppet_facts
  # POST /puppet_facts.json
  def create
    @puppet_fact = PuppetFact.new(puppet_fact_params)

    respond_to do |format|
      if @puppet_fact.save
        format.html { redirect_to @puppet_fact, notice: 'Puppet fact was successfully created.' }
        format.json { render action: 'show', status: :created, location: @puppet_fact }
      else
        format.html { render action: 'new' }
        format.json { render json: @puppet_fact.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /puppet_facts/1
  # PATCH/PUT /puppet_facts/1.json
  def update
    respond_to do |format|
      if @puppet_fact.update(puppet_fact_params)
        format.html { redirect_to @puppet_fact, notice: 'Puppet fact was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @puppet_fact.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /puppet_facts/1
  # DELETE /puppet_facts/1.json
  def destroy
    @puppet_fact.destroy
    respond_to do |format|
      format.html { redirect_to puppet_facts_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_puppet_fact
      @puppet_fact = PuppetFact.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def puppet_fact_params
      params.require(:puppet_fact).permit(:name, :key, :value, :puppet_id)
    end
end
